// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ReservedUserDataStruct extends FFSupabaseStruct {
  ReservedUserDataStruct({
    String? username,
    SupabaseDocRef? uid,
    String? photoPath,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _username = username,
        _uid = uid,
        _photoPath = photoPath,
        super(supabaseUtilData);

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  set username(String? val) => _username = val;

  bool hasUsername() => _username != null;

  // "uid" field.
  SupabaseDocRef? _uid;
  SupabaseDocRef? get uid => _uid;
  set uid(SupabaseDocRef? val) => _uid = val;

  bool hasUid() => _uid != null;

  // "photo_path" field.
  String? _photoPath;
  String get photoPath => _photoPath ?? '';
  set photoPath(String? val) => _photoPath = val;

  bool hasPhotoPath() => _photoPath != null;

  static ReservedUserDataStruct fromMap(Map<String, dynamic> data) =>
      ReservedUserDataStruct(
        username: data['username'] as String?,
        uid: data['uid'] as SupabaseDocRef?,
        photoPath: data['photo_path'] as String?,
      );

  static ReservedUserDataStruct? maybeFromMap(dynamic data) => data is Map
      ? ReservedUserDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'username': _username,
        'uid': _uid,
        'photo_path': _photoPath,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'username': serializeParam(
          _username,
          ParamType.String,
        ),
        'uid': serializeParam(
          _uid,
          ParamType.SupabaseDocRef,
        ),
        'photo_path': serializeParam(
          _photoPath,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReservedUserDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ReservedUserDataStruct(
        username: deserializeParam(
          data['username'],
          ParamType.String,
          false,
        ),
        uid: deserializeParam(
          data['uid'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        photoPath: deserializeParam(
          data['photo_path'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReservedUserDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReservedUserDataStruct &&
        username == other.username &&
        uid == other.uid &&
        photoPath == other.photoPath;
  }

  @override
  int get hashCode => ListEquality().hash([username, uid, photoPath]);
}

ReservedUserDataStruct createReservedUserDataStruct({
  String? username,
  SupabaseDocRef? uid,
  String? photoPath,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReservedUserDataStruct(
      username: username,
      uid: uid,
      photoPath: photoPath,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReservedUserDataStruct? updateReservedUserDataStruct(
  ReservedUserDataStruct? reservedUserData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reservedUserData
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReservedUserDataStructData(
  Map<String, dynamic> supabaseData,
  ReservedUserDataStruct? reservedUserData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (reservedUserData == null) {
    return;
  }
  if (reservedUserData.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && reservedUserData.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final reservedUserDataData =
      getReservedUserDataFirestoreData(reservedUserData, forFieldValue);
  final nestedData =
      reservedUserDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = reservedUserData.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReservedUserDataFirestoreData(
  ReservedUserDataStruct? reservedUserData, [
  bool forFieldValue = false,
]) {
  if (reservedUserData == null) {
    return {};
  }
  final supabaseData = mapToSupabase(reservedUserData.toMap());

  // Add any Firestore field values
  reservedUserData.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getReservedUserDataListFirestoreData(
  List<ReservedUserDataStruct>? reservedUserDatas,
) =>
    reservedUserDatas
        ?.map((e) => getReservedUserDataFirestoreData(e, true))
        .toList() ??
    [];
