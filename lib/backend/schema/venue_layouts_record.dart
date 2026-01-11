import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// data of booking table
class VenueLayoutsRecord extends SupabaseRecord {
  VenueLayoutsRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "venue_ref" field.
  SupabaseDocRef? _venueRef;
  SupabaseDocRef? get venueRef => _venueRef;
  bool hasVenueRef() => _venueRef != null;

  // "table_layout" field.
  List<TableLayoutStruct>? _tableLayout;
  List<TableLayoutStruct> get tableLayout => _tableLayout ?? const [];
  bool hasTableLayout() => _tableLayout != null;

  void _initializeFields() {
    _venueRef = snapshotData['venue_ref'] as SupabaseDocRef?;
    _tableLayout = getStructList(
      snapshotData['table_layout'],
      TableLayoutStruct.fromMap,
    );
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Venue_Layouts');

  static Stream<VenueLayoutsRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => VenueLayoutsRecord.fromSnapshot(s));

  static Future<VenueLayoutsRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => VenueLayoutsRecord.fromSnapshot(s));

  static VenueLayoutsRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      VenueLayoutsRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static VenueLayoutsRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      VenueLayoutsRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'VenueLayoutsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VenueLayoutsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVenueLayoutsRecordData({
  SupabaseDocRef? venueRef,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'venue_ref': venueRef,
    }.withoutNulls,
  );

  return supabaseData;
}

class VenueLayoutsRecordDocumentEquality
    implements Equality<VenueLayoutsRecord> {
  const VenueLayoutsRecordDocumentEquality();

  @override
  bool equals(VenueLayoutsRecord? e1, VenueLayoutsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.venueRef == e2?.venueRef &&
        listEquality.equals(e1?.tableLayout, e2?.tableLayout);
  }

  @override
  int hash(VenueLayoutsRecord? e) =>
      const ListEquality().hash([e?.venueRef, e?.tableLayout]);

  @override
  bool isValidKey(Object? o) => o is VenueLayoutsRecord;
}
