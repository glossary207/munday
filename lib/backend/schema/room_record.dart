import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomRecord extends SupabaseRecord {
  RoomRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "lastmassage" field.
  String? _lastmassage;
  String get lastmassage => _lastmassage ?? '';
  bool hasLastmassage() => _lastmassage != null;

  // "usersend" field.
  SupabaseDocRef? _usersend;
  SupabaseDocRef? get usersend => _usersend;
  bool hasUsersend() => _usersend != null;

  // "userrecive" field.
  SupabaseDocRef? _userrecive;
  SupabaseDocRef? get userrecive => _userrecive;
  bool hasUserrecive() => _userrecive != null;

  // "timeupdate" field.
  DateTime? _timeupdate;
  DateTime? get timeupdate => _timeupdate;
  bool hasTimeupdate() => _timeupdate != null;

  // "namesend" field.
  String? _namesend;
  String get namesend => _namesend ?? '';
  bool hasNamesend() => _namesend != null;

  // "namerecive" field.
  String? _namerecive;
  String get namerecive => _namerecive ?? '';
  bool hasNamerecive() => _namerecive != null;

  // "LastpersonUpdate" field.
  SupabaseDocRef? _lastpersonUpdate;
  SupabaseDocRef? get lastpersonUpdate => _lastpersonUpdate;
  bool hasLastpersonUpdate() => _lastpersonUpdate != null;

  // "startchat" field.
  bool? _startchat;
  bool get startchat => _startchat ?? false;
  bool hasStartchat() => _startchat != null;

  // "photosend" field.
  String? _photosend;
  String get photosend => _photosend ?? '';
  bool hasPhotosend() => _photosend != null;

  // "photorecive" field.
  String? _photorecive;
  String get photorecive => _photorecive ?? '';
  bool hasPhotorecive() => _photorecive != null;

  // "message" field.
  List<DatamassageStruct>? _message;
  List<DatamassageStruct> get message => _message ?? const [];
  bool hasMessage() => _message != null;

  // "onlinesend" field.
  bool? _onlinesend;
  bool get onlinesend => _onlinesend ?? false;
  bool hasOnlinesend() => _onlinesend != null;

  // "onlinerecive" field.
  bool? _onlinerecive;
  bool get onlinerecive => _onlinerecive ?? false;
  bool hasOnlinerecive() => _onlinerecive != null;

  void _initializeFields() {
    _lastmassage = snapshotData['lastmassage'] as String?;
    _usersend = snapshotData['usersend'] as SupabaseDocRef?;
    _userrecive = snapshotData['userrecive'] as SupabaseDocRef?;
    _timeupdate = snapshotData['timeupdate'] as DateTime?;
    _namesend = snapshotData['namesend'] as String?;
    _namerecive = snapshotData['namerecive'] as String?;
    _lastpersonUpdate = snapshotData['LastpersonUpdate'] as SupabaseDocRef?;
    _startchat = snapshotData['startchat'] as bool?;
    _photosend = snapshotData['photosend'] as String?;
    _photorecive = snapshotData['photorecive'] as String?;
    _message = getStructList(
      snapshotData['message'],
      DatamassageStruct.fromMap,
    );
    _onlinesend = snapshotData['onlinesend'] as bool?;
    _onlinerecive = snapshotData['onlinerecive'] as bool?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('room');

  static Stream<RoomRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => RoomRecord.fromSnapshot(s));

  static Future<RoomRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => RoomRecord.fromSnapshot(s));

  static RoomRecord fromSnapshot(SupabaseDocSnapshot snapshot) => RoomRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static RoomRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      RoomRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'RoomRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoomRecordData({
  String? lastmassage,
  SupabaseDocRef? usersend,
  SupabaseDocRef? userrecive,
  DateTime? timeupdate,
  String? namesend,
  String? namerecive,
  SupabaseDocRef? lastpersonUpdate,
  bool? startchat,
  String? photosend,
  String? photorecive,
  bool? onlinesend,
  bool? onlinerecive,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'lastmassage': lastmassage,
      'usersend': usersend,
      'userrecive': userrecive,
      'timeupdate': timeupdate,
      'namesend': namesend,
      'namerecive': namerecive,
      'LastpersonUpdate': lastpersonUpdate,
      'startchat': startchat,
      'photosend': photosend,
      'photorecive': photorecive,
      'onlinesend': onlinesend,
      'onlinerecive': onlinerecive,
    }.withoutNulls,
  );

  return supabaseData;
}

class RoomRecordDocumentEquality implements Equality<RoomRecord> {
  const RoomRecordDocumentEquality();

  @override
  bool equals(RoomRecord? e1, RoomRecord? e2) {
    const listEquality = ListEquality();
    return e1?.lastmassage == e2?.lastmassage &&
        e1?.usersend == e2?.usersend &&
        e1?.userrecive == e2?.userrecive &&
        e1?.timeupdate == e2?.timeupdate &&
        e1?.namesend == e2?.namesend &&
        e1?.namerecive == e2?.namerecive &&
        e1?.lastpersonUpdate == e2?.lastpersonUpdate &&
        e1?.startchat == e2?.startchat &&
        e1?.photosend == e2?.photosend &&
        e1?.photorecive == e2?.photorecive &&
        listEquality.equals(e1?.message, e2?.message) &&
        e1?.onlinesend == e2?.onlinesend &&
        e1?.onlinerecive == e2?.onlinerecive;
  }

  @override
  int hash(RoomRecord? e) => const ListEquality().hash([
        e?.lastmassage,
        e?.usersend,
        e?.userrecive,
        e?.timeupdate,
        e?.namesend,
        e?.namerecive,
        e?.lastpersonUpdate,
        e?.startchat,
        e?.photosend,
        e?.photorecive,
        e?.message,
        e?.onlinesend,
        e?.onlinerecive
      ]);

  @override
  bool isValidKey(Object? o) => o is RoomRecord;
}
