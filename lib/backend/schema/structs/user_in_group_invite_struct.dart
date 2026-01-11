// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserInGroupInviteStruct extends FFSupabaseStruct {
  UserInGroupInviteStruct({
    String? username,
    SupabaseDocRef? uid,
    String? photoPath,

    /// 1=going
    /// 2=Maybe
    /// 3=NotGoing
    /// none= show select
    int? status,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _username = username,
        _uid = uid,
        _photoPath = photoPath,
        _status = status,
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

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  set status(int? val) => _status = val;

  void incrementStatus(int amount) => status = status + amount;

  bool hasStatus() => _status != null;

  static UserInGroupInviteStruct fromMap(Map<String, dynamic> data) =>
      UserInGroupInviteStruct(
        username: data['username'] as String?,
        uid: data['uid'] as SupabaseDocRef?,
        photoPath: data['photo_path'] as String?,
        status: castToType<int>(data['status']),
      );

  static UserInGroupInviteStruct? maybeFromMap(dynamic data) => data is Map
      ? UserInGroupInviteStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'username': _username,
        'uid': _uid,
        'photo_path': _photoPath,
        'status': _status,
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
        'status': serializeParam(
          _status,
          ParamType.int,
        ),
      }.withoutNulls;

  static UserInGroupInviteStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UserInGroupInviteStruct(
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
        status: deserializeParam(
          data['status'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'UserInGroupInviteStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserInGroupInviteStruct &&
        username == other.username &&
        uid == other.uid &&
        photoPath == other.photoPath &&
        status == other.status;
  }

  @override
  int get hashCode =>
      ListEquality().hash([username, uid, photoPath, status]);
}

UserInGroupInviteStruct createUserInGroupInviteStruct({
  String? username,
  SupabaseDocRef? uid,
  String? photoPath,
  int? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserInGroupInviteStruct(
      username: username,
      uid: uid,
      photoPath: photoPath,
      status: status,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserInGroupInviteStruct? updateUserInGroupInviteStruct(
  UserInGroupInviteStruct? userInGroupInvite, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userInGroupInvite
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserInGroupInviteStructData(
  Map<String, dynamic> supabaseData,
  UserInGroupInviteStruct? userInGroupInvite,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (userInGroupInvite == null) {
    return;
  }
  if (userInGroupInvite.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userInGroupInvite.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final userInGroupInviteData =
      getUserInGroupInviteFirestoreData(userInGroupInvite, forFieldValue);
  final nestedData =
      userInGroupInviteData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userInGroupInvite.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserInGroupInviteFirestoreData(
  UserInGroupInviteStruct? userInGroupInvite, [
  bool forFieldValue = false,
]) {
  if (userInGroupInvite == null) {
    return {};
  }
  final supabaseData = mapToSupabase(userInGroupInvite.toMap());

  // Add any Firestore field values
  userInGroupInvite.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getUserInGroupInviteListFirestoreData(
  List<UserInGroupInviteStruct>? userInGroupInvites,
) =>
    userInGroupInvites
        ?.map((e) => getUserInGroupInviteFirestoreData(e, true))
        .toList() ??
    [];
