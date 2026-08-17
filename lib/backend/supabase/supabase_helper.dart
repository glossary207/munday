import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase operations used by the interactive venue layout.
///
/// The layout reader supports both the legacy `other_data` JSONB format and
/// the normalized floor/table schema. Normalized rows are converted back to
/// the same map shape consumed by [LayoutPreviewWidget].
class SupabaseHelper {
  SupabaseHelper._();

  static SupabaseClient get client => Supabase.instance.client;

  static Future<List<Map<String, dynamic>>> query(
    String table, {
    Map<String, Object?> equals = const {},
    String columns = '*',
  }) async {
    dynamic request = client.from(table).select(columns);
    for (final filter in equals.entries) {
      request = request.eq(filter.key, filter.value);
    }

    final dynamic response = await request;
    if (response is! List) return const [];
    return response
        .whereType<Map>()
        .map((row) => Map<String, dynamic>.from(row))
        .toList(growable: false);
  }

  static Future<Map<String, dynamic>?> fetchVenueDailyLayoutOnce(
    String venueId,
    String date,
  ) async {
    final dynamic response = await client
        .from('venue_daily_layouts')
        .select()
        .eq('venue_id', venueId)
        .eq('date', date)
        .maybeSingle();

    if (response is! Map) return null;
    final layout = normalizeLayoutPayload(Map<String, dynamic>.from(response));

    try {
      final normalized = await fetchLayoutFromNormalizedTables(
        layoutId: layout['id'].toString(),
        baseLayout: layout,
      );
      return normalized ?? layout;
    } on PostgrestException catch (error) {
      // Deployments using only the legacy JSONB layout do not have the
      // normalized tables. Keep those deployments working during migration.
      if (_isMissingNormalizedSchema(error)) return layout;
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> fetchLayoutFromNormalizedTables({
    required String layoutId,
    Map<String, dynamic> baseLayout = const {},
  }) async {
    final dynamic floorResponse = await client
        .from('venue_daily_layout_floors')
        .select()
        .eq('venue_daily_layout_id', layoutId)
        .order('sort_order', ascending: true);

    if (floorResponse is! List || floorResponse.isEmpty) return null;

    final floors = <String, dynamic>{};
    for (final rawFloor in floorResponse.whereType<Map>()) {
      final floor = Map<String, dynamic>.from(rawFloor);
      final floorRowId = floor['id']?.toString();
      if (floorRowId == null || floorRowId.isEmpty) continue;

      final floorKey = (floor['floor_key'] ?? floor['floor_id'] ?? floorRowId)
          .toString();
      final dynamic tableResponse = await client
          .from('venue_daily_layout_tables')
          .select()
          .eq('venue_daily_layout_floor_id', floorRowId)
          .order('table_key', ascending: true);

      final tableLayout = <String, dynamic>{};
      if (tableResponse is List) {
        for (final rawTable in tableResponse.whereType<Map>()) {
          final table = Map<String, dynamic>.from(rawTable);
          final tableKey =
              (table['table_key'] ?? table['table_id'] ?? table['id'])
                  ?.toString();
          if (tableKey == null || tableKey.isEmpty) continue;
          tableLayout[tableKey] = _tableForPreview(table, tableKey);
        }
      }

      final floorMeta = _asStringMap(floor['meta']);
      final floorOtherData = _asStringMap(floor['other_data']);
      floors[floorKey] = <String, dynamic>{
        ...floorOtherData,
        ...floorMeta,
        '_row_id': floorRowId,
        '_normalized_table_count': tableLayout.length,
        if (floor['label'] != null) 'label': floor['label'],
        if (floor['bounds'] != null) 'bounds': floor['bounds'],
        'table_layout': tableLayout,
        'walls':
            floor['walls'] ??
            floorOtherData['walls'] ??
            floorMeta['walls'] ??
            const <String, dynamic>{},
      };
    }

    if (floors.isEmpty) return null;
    return mergeLayoutSources(baseLayout: baseLayout, normalizedFloors: floors);
  }

  /// Combines an in-progress normalized migration with legacy JSONB data.
  ///
  /// Some layouts contain rows in `venue_daily_layout_floors` before their
  /// table rows have been migrated. Treating the normalized floor shell as the
  /// whole layout would hide valid tables still stored in `other_data`. Legacy
  /// geometry is therefore retained, while normalized rows override matching
  /// table keys because their reservation status is the live source of truth.
  static Map<String, dynamic> mergeLayoutSources({
    required Map<String, dynamic> baseLayout,
    required Map<String, dynamic> normalizedFloors,
  }) {
    final normalizedBase = normalizeLayoutPayload(baseLayout);
    final normalizedFloorMaps = normalizedFloors.map<String, dynamic>((
      key,
      value,
    ) {
      if (value is! Map) return MapEntry(key.toString(), value);
      return MapEntry(key.toString(), Map<String, dynamic>.from(value));
    });
    final legacyFloors = _legacyFloorsFromLayout(
      normalizedBase,
      preferredFloorKey: normalizedFloorMaps.keys.isEmpty
          ? null
          : normalizedFloorMaps.keys.first,
    );

    final floorKeys = <String>{
      ...legacyFloors.keys,
      ...normalizedFloorMaps.keys,
    };
    final mergedFloors = <String, dynamic>{};

    for (final floorKey in floorKeys) {
      final legacyFloor = _asStringMap(legacyFloors[floorKey]);
      final normalizedFloor = _asStringMap(normalizedFloorMaps[floorKey]);
      final legacyTables = _asStringMap(legacyFloor['table_layout']);
      final normalizedTables = _asStringMap(normalizedFloor['table_layout']);

      final mergedTables = <String, dynamic>{...legacyTables};
      for (final entry in normalizedTables.entries) {
        final legacyTable = _asStringMap(mergedTables[entry.key]);
        final normalizedTable = _asStringMap(entry.value);
        mergedTables[entry.key] = <String, dynamic>{
          ...legacyTable,
          ...normalizedTable,
        };
      }

      final legacyWalls = _asStringMap(legacyFloor['walls']);
      final normalizedWalls = _asStringMap(normalizedFloor['walls']);
      mergedFloors[floorKey] = <String, dynamic>{
        ...legacyFloor,
        ...normalizedFloor,
        'table_layout': mergedTables,
        'walls': normalizedWalls.isNotEmpty ? normalizedWalls : legacyWalls,
      };
    }

    return <String, dynamic>{
      ...normalizedBase,
      'floors': mergedFloors,
      '_layout_inventory': <String, int>{
        'legacy_tables': _countFloorTables(legacyFloors),
        'normalized_tables': _countFloorTables(normalizedFloorMaps),
        'merged_tables': _countFloorTables(mergedFloors),
      },
    };
  }

  static Future<Map<String, dynamic>> toggleTableReservation({
    required String venueId,
    required String date,
    required String tableId,
    required String userId,
    required String floorId,
  }) async {
    final dynamic response = await client.rpc(
      'toggle_table_reservation',
      params: <String, dynamic>{
        'p_venue_id': venueId,
        'p_date': date,
        'p_table_id': tableId,
        'p_user_id': userId,
        'p_floor_id': floorId,
      },
    );

    if (response is Map) {
      final result = Map<String, dynamic>.from(response);
      if (result['success'] == false) {
        throw StateError(
          (result['error'] ?? result['message'] ?? 'Reservation update failed')
              .toString(),
        );
      }
      return result;
    }
    return <String, dynamic>{'success': true, 'data': response};
  }

  static Future<Map<String, dynamic>?> getActiveReservation({
    required String venueId,
    required String date,
    required String userId,
  }) async {
    final dynamic response = await client
        .from('active_reservations')
        .select()
        .eq('venue_id', venueId)
        .eq('date', date)
        .eq('user_id', userId)
        .inFilter('status', const ['pending', 'payment_pending'])
        .order('updated_at', ascending: false)
        .limit(1);
    if (response is! List || response.isEmpty || response.first is! Map) {
      return null;
    }
    return Map<String, dynamic>.from(response.first as Map);
  }

  static Future<Map<String, dynamic>> getReservationPaymentQuote({
    required String venueId,
    required String date,
  }) async {
    final dynamic response = await client.rpc(
      'get_reservation_payment_quote',
      params: <String, dynamic>{'p_venue_id': venueId, 'p_date': date},
    );
    if (response is! Map) {
      throw StateError('Invalid reservation quote response');
    }
    final result = Map<String, dynamic>.from(response);
    if (result['success'] != true) {
      throw StateError(
        (result['error'] ?? result['message'] ?? 'Reservation quote failed')
            .toString(),
      );
    }
    return result;
  }

  static Future<Map<String, dynamic>> submitReservationPayment({
    required String venueId,
    required String date,
    required List<String> tableIds,
    required int partySize,
    required String slipPath,
  }) async {
    final dynamic response = await client.rpc(
      'submit_reservation_payment',
      params: <String, dynamic>{
        'p_venue_id': venueId,
        'p_date': date,
        'p_table_ids': tableIds,
        'p_party_size': partySize,
        'p_slip_path': slipPath,
      },
    );
    if (response is! Map) {
      throw StateError('Invalid payment response');
    }
    final result = Map<String, dynamic>.from(response);
    if (result['success'] != true) {
      throw StateError(
        (result['error'] ?? result['message'] ?? 'Payment submission failed')
            .toString(),
      );
    }
    return result;
  }

  static Map<String, dynamic> _tableForPreview(
    Map<String, dynamic> row,
    String tableKey,
  ) {
    final meta = _asStringMap(row['meta']);
    final statusFromMeta = _asStringMap(meta['status']);
    final statusExtra = _asStringMap(row['status_extra']);
    final color = row['color'] ?? meta['color'];
    final price = row['price'] ?? meta['price'];
    final minSeat = row['min_capacity'] ?? meta['min_seat'];
    final maxSeat = row['max_capacity'] ?? meta['max_seat'];
    final status = <String, dynamic>{
      ...statusFromMeta,
      ...statusExtra,
      'status_code':
          row['status_code'] ?? statusFromMeta['status_code'] ?? 'available',
      'customer_uid':
          row['customer_uid'] ?? statusFromMeta['customer_uid'] ?? '',
      'staff_bill_id':
          row['staff_bill_id'] ?? statusFromMeta['staff_bill_id'] ?? '',
      'booking_id': row['booking_id'] ?? statusFromMeta['booking_id'] ?? '',
      'customer_name':
          row['customer_name'] ?? statusFromMeta['customer_name'] ?? '',
      'status_action_timestamp':
          row['status_action_timestamp'] ??
          statusFromMeta['status_action_timestamp'] ??
          0,
    };

    return <String, dynamic>{
      ...meta,
      'xi': row['xi'] ?? meta['xi'] ?? const [0, 0],
      'yi': row['yi'] ?? meta['yi'] ?? const [0, 0],
      'type': row['shape_type'] ?? row['type'] ?? meta['type'] ?? 'table',
      'table_name':
          row['display_name'] ??
          row['table_name'] ??
          meta['table_name'] ??
          tableKey,
      if (color != null) 'color': color,
      if (price != null) 'price': price,
      if (minSeat != null) 'min_seat': minSeat,
      if (maxSeat != null) 'max_seat': maxSeat,
      'status': status,
    };
  }

  /// Normalizes legacy geometry/meta into the preview contract. Public so the
  /// contract can be covered by fixture tests without a live Supabase client.
  static Map<String, dynamic> normalizeLayoutPayload(
    Map<String, dynamic> layout,
  ) {
    final normalized = Map<String, dynamic>.from(layout);
    for (final key in const ['floors', 'other_data']) {
      final value = normalized[key];
      if (value is Map) {
        normalized[key] = _normalizeLegacyContainer(
          Map<String, dynamic>.from(value),
        );
      }
    }
    final directTables = normalized['table_layout'];
    if (directTables is Map) {
      normalized['table_layout'] = _normalizeLegacyTables(directTables);
    }
    return normalized;
  }

  static Map<String, dynamic> _normalizeLegacyContainer(
    Map<String, dynamic> container,
  ) {
    final result = Map<String, dynamic>.from(container);
    final directTables = result['table_layout'];
    if (directTables is Map) {
      result['table_layout'] = _normalizeLegacyTables(directTables);
    }
    final floors = result['floors'];
    if (floors is Map) {
      result['floors'] = floors.map<String, dynamic>((key, value) {
        if (value is! Map) return MapEntry(key.toString(), value);
        return MapEntry(
          key.toString(),
          _normalizeLegacyContainer(Map<String, dynamic>.from(value)),
        );
      });
    } else {
      for (final entry in result.entries.toList()) {
        if (entry.value is! Map) continue;
        final floor = Map<String, dynamic>.from(entry.value as Map);
        if (floor['table_layout'] is Map) {
          result[entry.key] = _normalizeLegacyContainer(floor);
        }
      }
    }
    return result;
  }

  static Map<String, dynamic> _normalizeLegacyTables(
    Map<dynamic, dynamic> raw,
  ) {
    return raw.map<String, dynamic>((key, value) {
      if (value is! Map) return MapEntry(key.toString(), value);
      final table = Map<String, dynamic>.from(value);
      final meta = _asStringMap(table['meta']);
      final merged = <String, dynamic>{...meta, ...table};
      final x = _asDouble(merged['x']);
      final y = _asDouble(merged['y']);
      final width = _asDouble(merged['width']);
      final height = _asDouble(merged['height']);
      merged['xi'] ??= x == null ? const [0, 0] : [x, x + (width ?? 0)];
      merged['yi'] ??= y == null ? const [0, 0] : [y, y + (height ?? 0)];
      merged['type'] ??= merged['shape_type'] ?? 'table';
      merged['table_name'] ??= merged['display_name'] ?? key.toString();
      merged['price'] ??= 0;
      merged['min_seat'] ??= merged['min_capacity'] ?? 0;
      merged['max_seat'] ??= merged['max_capacity'] ?? 0;
      return MapEntry(key.toString(), merged);
    });
  }

  static Map<String, dynamic> _legacyFloorsFromLayout(
    Map<String, dynamic> layout, {
    String? preferredFloorKey,
  }) {
    final floors = <String, dynamic>{};

    void addFloorMap(Object? rawFloors) {
      if (rawFloors is! Map) return;
      for (final entry in rawFloors.entries) {
        if (entry.value is! Map) continue;
        final floor = Map<String, dynamic>.from(entry.value as Map);
        if (floor['table_layout'] is! Map &&
            floor['walls'] is! Map &&
            floor['bounds'] == null) {
          continue;
        }
        floors[entry.key.toString()] = _normalizeLegacyContainer(floor);
      }
    }

    addFloorMap(layout['floors']);

    final otherData = _asStringMap(layout['other_data']);
    if (otherData['floors'] is Map) {
      addFloorMap(otherData['floors']);
    } else {
      addFloorMap(otherData);
    }

    final directTables = layout['table_layout'] is Map
        ? layout['table_layout']
        : otherData['table_layout'];
    if (directTables is Map) {
      final targetFloor = floors.isNotEmpty
          ? floors.keys.first
          : (preferredFloorKey ?? 'F1');
      final existingFloor = _asStringMap(floors[targetFloor]);
      final existingTables = _asStringMap(existingFloor['table_layout']);
      floors[targetFloor] = <String, dynamic>{
        ...existingFloor,
        'table_layout': <String, dynamic>{
          ..._normalizeLegacyTables(directTables),
          ...existingTables,
        },
      };
    }

    return floors;
  }

  static int _countFloorTables(Map<String, dynamic> floors) {
    var count = 0;
    for (final floor in floors.values) {
      if (floor is! Map) continue;
      final tables = floor['table_layout'];
      if (tables is Map) count += tables.length;
    }
    return count;
  }

  static double? _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  static Map<String, dynamic> _asStringMap(Object? value) {
    if (value is! Map) return const <String, dynamic>{};
    return Map<String, dynamic>.from(value);
  }

  static bool _isMissingNormalizedSchema(PostgrestException error) {
    return error.code == '42P01' ||
        error.code == '42703' ||
        error.code == 'PGRST204' ||
        error.code == 'PGRST205';
  }
}
