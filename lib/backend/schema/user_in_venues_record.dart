import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserInVenuesRecord extends SupabaseRecord {
  UserInVenuesRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "IDVenues" field.
  SupabaseDocRef? _iDVenues;
  SupabaseDocRef? get iDVenues => _iDVenues;
  bool hasIDVenues() => _iDVenues != null;

  // "user" field.
  List<DaStruct>? _user;
  List<DaStruct> get user => _user ?? const [];
  bool hasUser() => _user != null;

  // "NameVenues" field.
  String? _nameVenues;
  String get nameVenues => _nameVenues ?? '';
  bool hasNameVenues() => _nameVenues != null;

  void _initializeFields() {
    _iDVenues = snapshotData['IDVenues'] as SupabaseDocRef?;
    _user = getStructList(
      snapshotData['user'],
      DaStruct.fromMap,
    );
    _nameVenues = snapshotData['NameVenues'] as String?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('UserInVenues');

  static Stream<UserInVenuesRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => UserInVenuesRecord.fromSnapshot(s));

  static Future<UserInVenuesRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => UserInVenuesRecord.fromSnapshot(s));

  static UserInVenuesRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      UserInVenuesRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static UserInVenuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      UserInVenuesRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'UserInVenuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserInVenuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserInVenuesRecordData({
  SupabaseDocRef? iDVenues,
  String? nameVenues,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'IDVenues': iDVenues,
      'NameVenues': nameVenues,
    }.withoutNulls,
  );

  return supabaseData;
}

class UserInVenuesRecordDocumentEquality
    implements Equality<UserInVenuesRecord> {
  const UserInVenuesRecordDocumentEquality();

  @override
  bool equals(UserInVenuesRecord? e1, UserInVenuesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.iDVenues == e2?.iDVenues &&
        listEquality.equals(e1?.user, e2?.user) &&
        e1?.nameVenues == e2?.nameVenues;
  }

  @override
  int hash(UserInVenuesRecord? e) =>
      const ListEquality().hash([e?.iDVenues, e?.user, e?.nameVenues]);

  @override
  bool isValidKey(Object? o) => o is UserInVenuesRecord;
}
