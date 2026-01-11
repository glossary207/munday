// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ChatElementLivechatStruct extends FFSupabaseStruct {
  ChatElementLivechatStruct({
    SupabaseDocRef? id,
    String? name,
    String? message,
    String? photo,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _id = id,
        _name = name,
        _message = message,
        _photo = photo,
        super(supabaseUtilData);

  // "id" field.
  SupabaseDocRef? _id;
  SupabaseDocRef? get id => _id;
  set id(SupabaseDocRef? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  set photo(String? val) => _photo = val;

  bool hasPhoto() => _photo != null;

  static ChatElementLivechatStruct fromMap(Map<String, dynamic> data) =>
      ChatElementLivechatStruct(
        id: data['id'] as SupabaseDocRef?,
        name: data['name'] as String?,
        message: data['message'] as String?,
        photo: data['photo'] as String?,
      );

  static ChatElementLivechatStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatElementLivechatStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'message': _message,
        'photo': _photo,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.SupabaseDocRef,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'photo': serializeParam(
          _photo,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatElementLivechatStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ChatElementLivechatStruct(
        id: deserializeParam(
          data['id'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        photo: deserializeParam(
          data['photo'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatElementLivechatStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatElementLivechatStruct &&
        id == other.id &&
        name == other.name &&
        message == other.message &&
        photo == other.photo;
  }

  @override
  int get hashCode => ListEquality().hash([id, name, message, photo]);
}

ChatElementLivechatStruct createChatElementLivechatStruct({
  SupabaseDocRef? id,
  String? name,
  String? message,
  String? photo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatElementLivechatStruct(
      id: id,
      name: name,
      message: message,
      photo: photo,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatElementLivechatStruct? updateChatElementLivechatStruct(
  ChatElementLivechatStruct? chatElementLivechat, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatElementLivechat
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatElementLivechatStructData(
  Map<String, dynamic> supabaseData,
  ChatElementLivechatStruct? chatElementLivechat,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (chatElementLivechat == null) {
    return;
  }
  if (chatElementLivechat.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatElementLivechat.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final chatElementLivechatData =
      getChatElementLivechatFirestoreData(chatElementLivechat, forFieldValue);
  final nestedData =
      chatElementLivechatData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      chatElementLivechat.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatElementLivechatFirestoreData(
  ChatElementLivechatStruct? chatElementLivechat, [
  bool forFieldValue = false,
]) {
  if (chatElementLivechat == null) {
    return {};
  }
  final supabaseData = mapToSupabase(chatElementLivechat.toMap());

  // Add any Firestore field values
  chatElementLivechat.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getChatElementLivechatListFirestoreData(
  List<ChatElementLivechatStruct>? chatElementLivechats,
) =>
    chatElementLivechats
        ?.map((e) => getChatElementLivechatFirestoreData(e, true))
        .toList() ??
    [];
