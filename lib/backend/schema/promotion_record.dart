import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PromotionRecord extends SupabaseRecord {
  PromotionRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  void _initializeFields() {
    _location = snapshotData['location'] as LatLng?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Promotion');

  static Stream<PromotionRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => PromotionRecord.fromSnapshot(s));

  static Future<PromotionRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => PromotionRecord.fromSnapshot(s));

  static PromotionRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      PromotionRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static PromotionRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      PromotionRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'PromotionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PromotionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPromotionRecordData({
  LatLng? location,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'location': location,
    }.withoutNulls,
  );

  return supabaseData;
}

class PromotionRecordDocumentEquality implements Equality<PromotionRecord> {
  const PromotionRecordDocumentEquality();

  @override
  bool equals(PromotionRecord? e1, PromotionRecord? e2) {
    return e1?.location == e2?.location;
  }

  @override
  int hash(PromotionRecord? e) => const ListEquality().hash([e?.location]);

  @override
  bool isValidKey(Object? o) => o is PromotionRecord;
}
