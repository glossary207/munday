// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageStruct extends FFSupabaseStruct {
  MessageStruct({
    List<DatamassageStruct>? message,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _message = message,
        super(supabaseUtilData);

  // "message" field.
  List<DatamassageStruct>? _message;
  List<DatamassageStruct> get message => _message ?? const [];
  set message(List<DatamassageStruct>? val) => _message = val;

  void updateMessage(Function(List<DatamassageStruct>) updateFn) {
    updateFn(_message ??= []);
  }

  bool hasMessage() => _message != null;

  static MessageStruct fromMap(Map<String, dynamic> data) => MessageStruct(
        message: getStructList(
          data['message'],
          DatamassageStruct.fromMap,
        ),
      );

  static MessageStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'message': _message?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'message': serializeParam(
          _message,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static MessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageStruct(
        message: deserializeStructParam<DatamassageStruct>(
          data['message'],
          ParamType.DataStruct,
          true,
          structBuilder: DatamassageStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'MessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MessageStruct &&
        listEquality.equals(message, other.message);
  }

  @override
  int get hashCode => ListEquality().hash([message]);
}

MessageStruct createMessageStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MessageStruct(
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MessageStruct? updateMessageStruct(
  MessageStruct? messageStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    messageStruct
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMessageStructData(
  Map<String, dynamic> supabaseData,
  MessageStruct? messageStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (messageStruct == null) {
    return;
  }
  if (messageStruct.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && messageStruct.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final messageStructData =
      getMessageFirestoreData(messageStruct, forFieldValue);
  final nestedData =
      messageStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = messageStruct.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMessageFirestoreData(
  MessageStruct? messageStruct, [
  bool forFieldValue = false,
]) {
  if (messageStruct == null) {
    return {};
  }
  final supabaseData = mapToSupabase(messageStruct.toMap());

  // Add any Firestore field values
  messageStruct.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getMessageListFirestoreData(
  List<MessageStruct>? messageStructs,
) =>
    messageStructs?.map((e) => getMessageFirestoreData(e, true)).toList() ?? [];
