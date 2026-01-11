// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserdataStruct extends FFSupabaseStruct {
  UserdataStruct({
    SupabaseDocRef? iduser,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _iduser = iduser,
        super(supabaseUtilData);

  // "iduser" field.
  SupabaseDocRef? _iduser;
  SupabaseDocRef? get iduser => _iduser;
  set iduser(SupabaseDocRef? val) => _iduser = val;

  bool hasIduser() => _iduser != null;

  static UserdataStruct fromMap(Map<String, dynamic> data) => UserdataStruct(
        iduser: data['iduser'] as SupabaseDocRef?,
      );

  static UserdataStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserdataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'iduser': _iduser,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'iduser': serializeParam(
          _iduser,
          ParamType.SupabaseDocRef,
        ),
      }.withoutNulls;

  static UserdataStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserdataStruct(
        iduser: deserializeParam(
          data['iduser'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
      );

  @override
  String toString() => 'UserdataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserdataStruct && iduser == other.iduser;
  }

  @override
  int get hashCode => ListEquality().hash([iduser]);
}

UserdataStruct createUserdataStruct({
  SupabaseDocRef? iduser,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserdataStruct(
      iduser: iduser,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserdataStruct? updateUserdataStruct(
  UserdataStruct? userdata, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userdata
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserdataStructData(
  Map<String, dynamic> supabaseData,
  UserdataStruct? userdata,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (userdata == null) {
    return;
  }
  if (userdata.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userdata.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final userdataData = getUserdataFirestoreData(userdata, forFieldValue);
  final nestedData = userdataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userdata.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserdataFirestoreData(
  UserdataStruct? userdata, [
  bool forFieldValue = false,
]) {
  if (userdata == null) {
    return {};
  }
  final supabaseData = mapToSupabase(userdata.toMap());

  // Add any Firestore field values
  userdata.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getUserdataListFirestoreData(
  List<UserdataStruct>? userdatas,
) =>
    userdatas?.map((e) => getUserdataFirestoreData(e, true)).toList() ?? [];
