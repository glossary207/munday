// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DatainstoreStruct extends FFSupabaseStruct {
  DatainstoreStruct({
    SupabaseDocRef? roomRef,
    SupabaseDocRef? userRef,
    String? photoprofile,
    DateTime? timeupdate,
    String? lastmassage,
    bool? online,
    String? name,
    bool? startchat,
    SupabaseDocRef? lastpersonUpdate,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _roomRef = roomRef,
        _userRef = userRef,
        _photoprofile = photoprofile,
        _timeupdate = timeupdate,
        _lastmassage = lastmassage,
        _online = online,
        _name = name,
        _startchat = startchat,
        _lastpersonUpdate = lastpersonUpdate,
        super(supabaseUtilData);

  // "room_ref" field.
  SupabaseDocRef? _roomRef;
  SupabaseDocRef? get roomRef => _roomRef;
  set roomRef(SupabaseDocRef? val) => _roomRef = val;

  bool hasRoomRef() => _roomRef != null;

  // "user_ref" field.
  SupabaseDocRef? _userRef;
  SupabaseDocRef? get userRef => _userRef;
  set userRef(SupabaseDocRef? val) => _userRef = val;

  bool hasUserRef() => _userRef != null;

  // "photoprofile" field.
  String? _photoprofile;
  String get photoprofile => _photoprofile ?? '';
  set photoprofile(String? val) => _photoprofile = val;

  bool hasPhotoprofile() => _photoprofile != null;

  // "timeupdate" field.
  DateTime? _timeupdate;
  DateTime? get timeupdate => _timeupdate;
  set timeupdate(DateTime? val) => _timeupdate = val;

  bool hasTimeupdate() => _timeupdate != null;

  // "lastmassage" field.
  String? _lastmassage;
  String get lastmassage => _lastmassage ?? '';
  set lastmassage(String? val) => _lastmassage = val;

  bool hasLastmassage() => _lastmassage != null;

  // "online" field.
  bool? _online;
  bool get online => _online ?? false;
  set online(bool? val) => _online = val;

  bool hasOnline() => _online != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "startchat" field.
  bool? _startchat;
  bool get startchat => _startchat ?? false;
  set startchat(bool? val) => _startchat = val;

  bool hasStartchat() => _startchat != null;

  // "LastpersonUpdate" field.
  SupabaseDocRef? _lastpersonUpdate;
  SupabaseDocRef? get lastpersonUpdate => _lastpersonUpdate;
  set lastpersonUpdate(SupabaseDocRef? val) => _lastpersonUpdate = val;

  bool hasLastpersonUpdate() => _lastpersonUpdate != null;

  static DatainstoreStruct fromMap(Map<String, dynamic> data) =>
      DatainstoreStruct(
        roomRef: data['room_ref'] as SupabaseDocRef?,
        userRef: data['user_ref'] as SupabaseDocRef?,
        photoprofile: data['photoprofile'] as String?,
        timeupdate: data['timeupdate'] as DateTime?,
        lastmassage: data['lastmassage'] as String?,
        online: data['online'] as bool?,
        name: data['name'] as String?,
        startchat: data['startchat'] as bool?,
        lastpersonUpdate: data['LastpersonUpdate'] as SupabaseDocRef?,
      );

  static DatainstoreStruct? maybeFromMap(dynamic data) => data is Map
      ? DatainstoreStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'room_ref': _roomRef,
        'user_ref': _userRef,
        'photoprofile': _photoprofile,
        'timeupdate': _timeupdate,
        'lastmassage': _lastmassage,
        'online': _online,
        'name': _name,
        'startchat': _startchat,
        'LastpersonUpdate': _lastpersonUpdate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'room_ref': serializeParam(
          _roomRef,
          ParamType.SupabaseDocRef,
        ),
        'user_ref': serializeParam(
          _userRef,
          ParamType.SupabaseDocRef,
        ),
        'photoprofile': serializeParam(
          _photoprofile,
          ParamType.String,
        ),
        'timeupdate': serializeParam(
          _timeupdate,
          ParamType.DateTime,
        ),
        'lastmassage': serializeParam(
          _lastmassage,
          ParamType.String,
        ),
        'online': serializeParam(
          _online,
          ParamType.bool,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'startchat': serializeParam(
          _startchat,
          ParamType.bool,
        ),
        'LastpersonUpdate': serializeParam(
          _lastpersonUpdate,
          ParamType.SupabaseDocRef,
        ),
      }.withoutNulls;

  static DatainstoreStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatainstoreStruct(
        roomRef: deserializeParam(
          data['room_ref'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['room'],
        ),
        userRef: deserializeParam(
          data['user_ref'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        photoprofile: deserializeParam(
          data['photoprofile'],
          ParamType.String,
          false,
        ),
        timeupdate: deserializeParam(
          data['timeupdate'],
          ParamType.DateTime,
          false,
        ),
        lastmassage: deserializeParam(
          data['lastmassage'],
          ParamType.String,
          false,
        ),
        online: deserializeParam(
          data['online'],
          ParamType.bool,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        startchat: deserializeParam(
          data['startchat'],
          ParamType.bool,
          false,
        ),
        lastpersonUpdate: deserializeParam(
          data['LastpersonUpdate'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
      );

  @override
  String toString() => 'DatainstoreStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatainstoreStruct &&
        roomRef == other.roomRef &&
        userRef == other.userRef &&
        photoprofile == other.photoprofile &&
        timeupdate == other.timeupdate &&
        lastmassage == other.lastmassage &&
        online == other.online &&
        name == other.name &&
        startchat == other.startchat &&
        lastpersonUpdate == other.lastpersonUpdate;
  }

  @override
  int get hashCode => ListEquality().hash([
        roomRef,
        userRef,
        photoprofile,
        timeupdate,
        lastmassage,
        online,
        name,
        startchat,
        lastpersonUpdate
      ]);
}

DatainstoreStruct createDatainstoreStruct({
  SupabaseDocRef? roomRef,
  SupabaseDocRef? userRef,
  String? photoprofile,
  DateTime? timeupdate,
  String? lastmassage,
  bool? online,
  String? name,
  bool? startchat,
  SupabaseDocRef? lastpersonUpdate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DatainstoreStruct(
      roomRef: roomRef,
      userRef: userRef,
      photoprofile: photoprofile,
      timeupdate: timeupdate,
      lastmassage: lastmassage,
      online: online,
      name: name,
      startchat: startchat,
      lastpersonUpdate: lastpersonUpdate,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DatainstoreStruct? updateDatainstoreStruct(
  DatainstoreStruct? datainstore, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    datainstore
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDatainstoreStructData(
  Map<String, dynamic> supabaseData,
  DatainstoreStruct? datainstore,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (datainstore == null) {
    return;
  }
  if (datainstore.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && datainstore.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final datainstoreData =
      getDatainstoreFirestoreData(datainstore, forFieldValue);
  final nestedData =
      datainstoreData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = datainstore.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDatainstoreFirestoreData(
  DatainstoreStruct? datainstore, [
  bool forFieldValue = false,
]) {
  if (datainstore == null) {
    return {};
  }
  final supabaseData = mapToSupabase(datainstore.toMap());

  // Add any Firestore field values
  datainstore.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDatainstoreListFirestoreData(
  List<DatainstoreStruct>? datainstores,
) =>
    datainstores?.map((e) => getDatainstoreFirestoreData(e, true)).toList() ??
    [];
