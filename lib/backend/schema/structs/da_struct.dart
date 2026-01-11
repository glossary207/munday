// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DaStruct extends FFSupabaseStruct {
  DaStruct({
    DateTime? date,
    DatauserStruct? user,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _date = date,
        _user = user,
        super(supabaseUtilData);

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "user" field.
  DatauserStruct? _user;
  DatauserStruct get user => _user ?? DatauserStruct();
  set user(DatauserStruct? val) => _user = val;

  void updateUser(Function(DatauserStruct) updateFn) {
    updateFn(_user ??= DatauserStruct());
  }

  bool hasUser() => _user != null;

  static DaStruct fromMap(Map<String, dynamic> data) => DaStruct(
        date: data['date'] as DateTime?,
        user: data['user'] is DatauserStruct
            ? data['user']
            : DatauserStruct.maybeFromMap(data['user']),
      );

  static DaStruct? maybeFromMap(dynamic data) =>
      data is Map ? DaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'user': _user?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'user': serializeParam(
          _user,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static DaStruct fromSerializableMap(Map<String, dynamic> data) => DaStruct(
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        user: deserializeStructParam(
          data['user'],
          ParamType.DataStruct,
          false,
          structBuilder: DatauserStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DaStruct && date == other.date && user == other.user;
  }

  @override
  int get hashCode => ListEquality().hash([date, user]);
}

DaStruct createDaStruct({
  DateTime? date,
  DatauserStruct? user,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DaStruct(
      date: date,
      user: user ?? (clearUnsetFields ? DatauserStruct() : null),
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DaStruct? updateDaStruct(
  DaStruct? da, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    da
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDaStructData(
  Map<String, dynamic> supabaseData,
  DaStruct? da,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (da == null) {
    return;
  }
  if (da.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && da.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final daData = getDaSupabaseData(da, forFieldValue);
  final nestedData = daData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = da.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDaSupabaseData(
  DaStruct? da, [
  bool forFieldValue = false,
]) {
  if (da == null) {
    return {};
  }
  final supabaseData = mapToSupabase(da.toMap());

  // Handle nested data for "user" field.
  addDatauserStructData(
    supabaseData,
    da.hasUser() ? da.user : null,
    'user',
    forFieldValue,
  );

  // Add any Firestore field values
  da.supabaseUtilData.fieldValues.forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDaListSupabaseData(
  List<DaStruct>? das,
) =>
    das?.map((e) => getDaSupabaseData(e, true)).toList() ?? [];
