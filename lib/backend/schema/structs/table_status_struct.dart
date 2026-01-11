// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class TableStatusStruct extends FFSupabaseStruct {
  TableStatusStruct({
    String? statusCode,
    String? statusReserveId,
    DateTime? statusActionTimestamp,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _statusCode = statusCode,
        _statusReserveId = statusReserveId,
        _statusActionTimestamp = statusActionTimestamp,
        super(supabaseUtilData);

  // "status_code" field.
  String? _statusCode;
  String get statusCode => _statusCode ?? '';
  set statusCode(String? val) => _statusCode = val;

  bool hasStatusCode() => _statusCode != null;

  // "status_reserve_Id" field.
  String? _statusReserveId;
  String get statusReserveId => _statusReserveId ?? '';
  set statusReserveId(String? val) => _statusReserveId = val;

  bool hasStatusReserveId() => _statusReserveId != null;

  // "status_action_timestamp" field.
  DateTime? _statusActionTimestamp;
  DateTime? get statusActionTimestamp => _statusActionTimestamp;
  set statusActionTimestamp(DateTime? val) => _statusActionTimestamp = val;

  bool hasStatusActionTimestamp() => _statusActionTimestamp != null;

  static TableStatusStruct fromMap(Map<String, dynamic> data) =>
      TableStatusStruct(
        statusCode: data['status_code'] as String?,
        statusReserveId: data['status_reserve_Id'] as String?,
        statusActionTimestamp: data['status_action_timestamp'] as DateTime?,
      );

  static TableStatusStruct? maybeFromMap(dynamic data) => data is Map
      ? TableStatusStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status_code': _statusCode,
        'status_reserve_Id': _statusReserveId,
        'status_action_timestamp': _statusActionTimestamp,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status_code': serializeParam(
          _statusCode,
          ParamType.String,
        ),
        'status_reserve_Id': serializeParam(
          _statusReserveId,
          ParamType.String,
        ),
        'status_action_timestamp': serializeParam(
          _statusActionTimestamp,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static TableStatusStruct fromSerializableMap(Map<String, dynamic> data) =>
      TableStatusStruct(
        statusCode: deserializeParam(
          data['status_code'],
          ParamType.String,
          false,
        ),
        statusReserveId: deserializeParam(
          data['status_reserve_Id'],
          ParamType.String,
          false,
        ),
        statusActionTimestamp: deserializeParam(
          data['status_action_timestamp'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'TableStatusStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TableStatusStruct &&
        statusCode == other.statusCode &&
        statusReserveId == other.statusReserveId &&
        statusActionTimestamp == other.statusActionTimestamp;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([statusCode, statusReserveId, statusActionTimestamp]);
}

TableStatusStruct createTableStatusStruct({
  String? statusCode,
  String? statusReserveId,
  DateTime? statusActionTimestamp,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TableStatusStruct(
      statusCode: statusCode,
      statusReserveId: statusReserveId,
      statusActionTimestamp: statusActionTimestamp,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TableStatusStruct? updateTableStatusStruct(
  TableStatusStruct? tableStatus, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tableStatus
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTableStatusStructData(
  Map<String, dynamic> supabaseData,
  TableStatusStruct? tableStatus,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (tableStatus == null) {
    return;
  }
  if (tableStatus.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tableStatus.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final tableStatusData =
      getTableStatusFirestoreData(tableStatus, forFieldValue);
  final nestedData =
      tableStatusData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tableStatus.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTableStatusFirestoreData(
  TableStatusStruct? tableStatus, [
  bool forFieldValue = false,
]) {
  if (tableStatus == null) {
    return {};
  }
  final supabaseData = mapToSupabase(tableStatus.toMap());

  // Add any Firestore field values
  tableStatus.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getTableStatusListFirestoreData(
  List<TableStatusStruct>? tableStatuss,
) =>
    tableStatuss?.map((e) => getTableStatusFirestoreData(e, true)).toList() ??
    [];
