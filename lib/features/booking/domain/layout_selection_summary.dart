class LayoutSelectionSummary {
  const LayoutSelectionSummary({
    this.tableIds = const [],
    this.displayNames = const [],
    this.totalPrice = 0,
    this.minimumPartySize = 0,
  });

  final List<String> tableIds;
  final List<String> displayNames;
  final double totalPrice;
  final int minimumPartySize;
}

LayoutSelectionSummary summarizeOwnedLayoutSelection(
  Map<String, dynamic>? layout,
  String currentUserId,
) {
  if (layout == null || currentUserId.isEmpty) {
    return const LayoutSelectionSummary();
  }

  final selectedIds = <String>[];
  final selectedNames = <String>[];
  var totalPrice = 0.0;
  var minimumPartySize = 0;

  void collectTables(Object? rawTables) {
    if (rawTables is! Map) return;
    for (final entry in rawTables.entries) {
      if (entry.value is! Map) continue;
      final table = Map<String, dynamic>.from(entry.value as Map);
      final status = table['status'];
      if (status is! Map) continue;
      final statusMap = Map<String, dynamic>.from(status);
      final code = (statusMap['status_code'] ?? 'available').toString();
      final owner = (statusMap['customer_uid'] ?? '').toString();
      if (owner != currentUserId ||
          !const {'pending', 'payment_pending'}.contains(code)) {
        continue;
      }
      selectedIds.add(entry.key.toString());
      selectedNames.add((table['table_name'] ?? entry.key).toString());
      totalPrice += (table['price'] as num?)?.toDouble() ?? 0;
      minimumPartySize += (table['min_seat'] as num?)?.toInt() ?? 0;
    }
  }

  void collectContainer(Object? rawContainer) {
    if (rawContainer is! Map) return;
    final container = Map<String, dynamic>.from(rawContainer);
    collectTables(container['table_layout']);
    final floors = container['floors'];
    if (floors is Map) {
      for (final floor in floors.values) {
        collectContainer(floor);
      }
      return;
    }
    for (final value in container.values) {
      if (value is Map && value['table_layout'] is Map) {
        collectContainer(value);
      }
    }
  }

  final floors = layout['floors'];
  if (floors is Map && floors.isNotEmpty) {
    collectContainer(floors);
  } else if (layout['other_data'] is Map) {
    collectContainer(layout['other_data']);
  } else {
    collectTables(layout['table_layout']);
  }

  return LayoutSelectionSummary(
    tableIds: List.unmodifiable(selectedIds),
    displayNames: List.unmodifiable(selectedNames),
    totalPrice: totalPrice,
    minimumPartySize: minimumPartySize,
  );
}
