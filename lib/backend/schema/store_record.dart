import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StoreRecord extends SupabaseRecord {
  StoreRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "namestore" field.
  String? _namestore;
  String get namestore => _namestore ?? '';
  bool hasNamestore() => _namestore != null;

  // "AD" field.
  List<String>? _ad;
  List<String> get ad => _ad ?? const [];
  bool hasAd() => _ad != null;

  // "position" field.
  LatLng? _position;
  LatLng? get position => _position;
  bool hasPosition() => _position != null;

  // "INIcheers" field.
  int? _iNIcheers;
  int get iNIcheers => _iNIcheers ?? 0;
  bool hasINIcheers() => _iNIcheers != null;

  // "user" field.
  List<DatauserStruct>? _user;
  List<DatauserStruct> get user => _user ?? const [];
  bool hasUser() => _user != null;

  // "logo" field.
  String? _logo;
  String get logo => _logo ?? '';
  bool hasLogo() => _logo != null;

  // "IDroom" field.
  SupabaseDocRef? _iDroom;
  SupabaseDocRef? get iDroom => _iDroom;
  bool hasIDroom() => _iDroom != null;

  // "goodprofile" field.
  List<SupabaseDocRef>? _goodprofile;
  List<SupabaseDocRef> get goodprofile => _goodprofile ?? const [];
  bool hasGoodprofile() => _goodprofile != null;

  // "qr" field.
  String? _qr;
  String get qr => _qr ?? '';
  bool hasQr() => _qr != null;

  // "BGshow1" field.
  String? _bGshow1;
  String get bGshow1 => _bGshow1 ?? '';
  bool hasBGshow1() => _bGshow1 != null;

  // "Events" field.
  List<SupabaseDocRef>? _events;
  List<SupabaseDocRef> get events => _events ?? const [];
  bool hasEvents() => _events != null;

  // "table_id" field.
  String? _tableId;
  String get tableId => _tableId ?? '';
  bool hasTableId() => _tableId != null;

  void _initializeFields() {
    _namestore = snapshotData['namestore'] as String?;
    _ad = getDataList(snapshotData['AD']);
    _position = snapshotData['position'] as LatLng?;
    _iNIcheers = castToType<int>(snapshotData['INIcheers']);
    _user = getStructList(
      snapshotData['user'],
      DatauserStruct.fromMap,
    );
    _logo = snapshotData['logo'] as String?;
    _iDroom = snapshotData['IDroom'] as SupabaseDocRef?;
    _goodprofile = getDataList(snapshotData['goodprofile']);
    _qr = snapshotData['qr'] as String?;
    _bGshow1 = snapshotData['BGshow1'] as String?;
    _events = getDataList(snapshotData['Events']);
    _tableId = snapshotData['table_id'] as String?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('store');

  static Stream<StoreRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => StoreRecord.fromSnapshot(s));

  static Future<StoreRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => StoreRecord.fromSnapshot(s));

  static StoreRecord fromSnapshot(SupabaseDocSnapshot snapshot) => StoreRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static StoreRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      StoreRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'StoreRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StoreRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStoreRecordData({
  String? namestore,
  LatLng? position,
  int? iNIcheers,
  String? logo,
  SupabaseDocRef? iDroom,
  String? qr,
  String? bGshow1,
  String? tableId,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'namestore': namestore,
      'position': position,
      'INIcheers': iNIcheers,
      'logo': logo,
      'IDroom': iDroom,
      'qr': qr,
      'BGshow1': bGshow1,
      'table_id': tableId,
    }.withoutNulls,
  );

  return supabaseData;
}

class StoreRecordDocumentEquality implements Equality<StoreRecord> {
  const StoreRecordDocumentEquality();

  @override
  bool equals(StoreRecord? e1, StoreRecord? e2) {
    const listEquality = ListEquality();
    return e1?.namestore == e2?.namestore &&
        listEquality.equals(e1?.ad, e2?.ad) &&
        e1?.position == e2?.position &&
        e1?.iNIcheers == e2?.iNIcheers &&
        listEquality.equals(e1?.user, e2?.user) &&
        e1?.logo == e2?.logo &&
        e1?.iDroom == e2?.iDroom &&
        listEquality.equals(e1?.goodprofile, e2?.goodprofile) &&
        e1?.qr == e2?.qr &&
        e1?.bGshow1 == e2?.bGshow1 &&
        listEquality.equals(e1?.events, e2?.events) &&
        e1?.tableId == e2?.tableId;
  }

  @override
  int hash(StoreRecord? e) => const ListEquality().hash([
        e?.namestore,
        e?.ad,
        e?.position,
        e?.iNIcheers,
        e?.user,
        e?.logo,
        e?.iDroom,
        e?.goodprofile,
        e?.qr,
        e?.bGshow1,
        e?.events,
        e?.tableId
      ]);

  @override
  bool isValidKey(Object? o) => o is StoreRecord;
}
