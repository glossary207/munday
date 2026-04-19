import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/schema_util.dart';
import '/flutter_flow/flutter_flow_util.dart';

typedef RecordBuilder<T> = T Function(SupabaseDocSnapshot snapshot);

abstract class SupabaseRecord {
  SupabaseRecord(this.reference, this.snapshotData);
  Map<String, dynamic> snapshotData;
  SupabaseDocRef reference;
}

abstract class FFSupabaseStruct extends BaseStruct {
  FFSupabaseStruct(this.supabaseUtilData);

  /// Utility class for Supabase updates
  SupabaseUtilData supabaseUtilData = SupabaseUtilData();
}

class SupabaseUtilData {
  const SupabaseUtilData({
    this.fieldValues = const {},
    this.clearUnsetFields = true,
    this.create = false,
    this.delete = false,
  });
  final Map<String, dynamic> fieldValues;
  final bool clearUnsetFields;
  final bool create;
  final bool delete;
  static String get name => 'supabaseUtilData';
}

Map<String, dynamic> mapFromSupabase(Map<String, dynamic> data) =>
    mergeNestedFields(data)
        .where((k, _) => k != SupabaseUtilData.name)
        .map((key, value) {
      // Handle Timestamp
      if (value is Timestamp) {
        value = value.toDate();
      }
      // Handle list of Timestamp
      if (value is Iterable && value.isNotEmpty && value.first is Timestamp) {
        value = value.map((v) => (v as Timestamp).toDate()).toList();
      }
      // Handle GeoPoint
      if (value is GeoPoint) {
        value = value.toLatLng();
      }
      // Handle list of GeoPoint
      if (value is Iterable && value.isNotEmpty && value.first is GeoPoint) {
        value = value.map((v) => (v as GeoPoint).toLatLng()).toList();
      }
      // Handle nested data.
      if (value is Map) {
        final dataMap = getDataMap(value);
        if (dataMap != null) {
          value = mapFromSupabase(dataMap);
        }
      }
      // Handle list of nested data.
      if (value is Iterable && value.isNotEmpty && value.first is Map) {
        value = value.map((v) {
          final dataMap = getDataMap(v);
          return dataMap != null ? mapFromSupabase(dataMap) : v;
        }).toList();
      }
      return MapEntry(key, value);
    });

SupabaseDocRef? getSupabaseDocRef(
  dynamic value,
  String collectionPath,
) {
  if (value is SupabaseDocRef) {
    return value;
  }
  if (value is String && value.isNotEmpty) {
    return SupabaseFirestore.instance.collection(collectionPath).doc(value);
  }
  return null;
}

List<SupabaseDocRef>? getSupabaseDocRefList(
  dynamic value,
  String collectionPath,
) {
  if (value is! List) {
    return null;
  }
  return value
      .map((item) => getSupabaseDocRef(item, collectionPath))
      .whereType<SupabaseDocRef>()
      .toList();
}

Map<String, dynamic> mapToSupabase(Map<String, dynamic> data) =>
    data.where((k, v) => k != SupabaseUtilData.name).map((key, value) {
      if (value is SupabaseDocRef) {
        value = value.id;
      }
      if (value is Iterable &&
          value.isNotEmpty &&
          value.first is SupabaseDocRef) {
        value = value.map((v) => (v as SupabaseDocRef).id).toList();
      }
      // Handle GeoPoint
      if (value is LatLng) {
        value = value.toGeoPoint();
      }
      // Handle list of GeoPoint
      if (value is Iterable && value.isNotEmpty && value.first is LatLng) {
        value = value.map((v) => (v as LatLng).toGeoPoint()).toList();
      }
      // Handle Color
      if (value is Color) {
        value = value.toCssString();
      }
      // Handle list of Color
      if (value is Iterable && value.isNotEmpty && value.first is Color) {
        value = value.map((v) => (v as Color).toCssString()).toList();
      } // Handle Enums.
      if (value is Enum) {
        value = value.serialize();
      }
      // Handle list of Enums.
      if (value is Iterable && value.isNotEmpty && value.first is Enum) {
        value = value.map((v) => (v as Enum).serialize()).toList();
      }
      // Handle nested data.
      if (value is Map) {
        final dataMap = getDataMap(value);
        if (dataMap != null) {
          value = mapToSupabase(dataMap);
        }
      }
      // Handle list of nested data.
      if (value is Iterable && value.isNotEmpty && value.first is Map) {
        value = value.map((v) {
          final dataMap = getDataMap(v);
          return dataMap != null ? mapToSupabase(dataMap) : v;
        }).toList();
      }
      return MapEntry(key, value);
    });

List<GeoPoint>? convertToGeoPointList(List<LatLng>? list) =>
    list?.map((e) => e.toGeoPoint()).toList();

extension GeoPointExtension on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude, longitude);
}

extension LatLngExtension on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

SupabaseDocRef toRef(String ref) => SupabaseFirestore.instance.doc(ref);

T? safeGet<T>(T Function() func, [Function(dynamic)? reportError]) {
  try {
    return func();
  } catch (e) {
    reportError?.call(e);
  }
  return null;
}

Map<String, dynamic> mergeNestedFields(Map<String, dynamic> data) {
  final nestedData = data.where((k, _) => k.contains('.'));
  final fieldNames = nestedData.keys.map((k) => k.split('.').first).toSet();
  // Remove nested values (e.g. 'foo.bar') and merge them into a map.
  data.removeWhere((k, _) => k.contains('.'));
  fieldNames.forEach((name) {
    final mergedValues = mergeNestedFields(
      nestedData
          .where((k, _) => k.split('.').first == name)
          .map((k, v) => MapEntry(k.split('.').skip(1).join('.'), v)),
    );
    final existingValue = getDataMap(data[name]);
    data[name] = {
      if (existingValue != null) ...existingValue,
      ...mergedValues,
    };
  });
  // Merge any nested maps inside any of the fields as well.
  data.where((_, v) => v is Map).forEach((k, v) {
    final dataMap = getDataMap(v);
    if (dataMap != null) {
      data[k] = mergeNestedFields(dataMap);
    }
  });

  return data;
}

extension _WhereMapExtension<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K, V) test) =>
      Map.fromEntries(entries.where((e) => test(e.key, e.value)));
}
