// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TableLayoutStruct extends FFSupabaseStruct {
  TableLayoutStruct({
    DateTime? date,
    List<TableDataStruct>? tableData,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _date = date,
        _tableData = tableData,
        super(supabaseUtilData);

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "table_data" field.
  List<TableDataStruct>? _tableData;
  List<TableDataStruct> get tableData => _tableData ?? const [];
  set tableData(List<TableDataStruct>? val) => _tableData = val;

  void updateTableData(Function(List<TableDataStruct>) updateFn) {
    updateFn(_tableData ??= []);
  }

  bool hasTableData() => _tableData != null;

  static TableLayoutStruct fromMap(Map<String, dynamic> data) =>
      TableLayoutStruct(
        date: data['date'] as DateTime?,
        tableData: getStructList(
          data['table_data'],
          TableDataStruct.fromMap,
        ),
      );

  static TableLayoutStruct? maybeFromMap(dynamic data) => data is Map
      ? TableLayoutStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'table_data': _tableData?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'table_data': serializeParam(
          _tableData,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TableLayoutStruct fromSerializableMap(Map<String, dynamic> data) =>
      TableLayoutStruct(
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        tableData: deserializeStructParam<TableDataStruct>(
          data['table_data'],
          ParamType.DataStruct,
          true,
          structBuilder: TableDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TableLayoutStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TableLayoutStruct &&
        date == other.date &&
        listEquality.equals(tableData, other.tableData);
  }

  @override
  int get hashCode => ListEquality().hash([date, tableData]);
}

TableLayoutStruct createTableLayoutStruct({
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TableLayoutStruct(
      date: date,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TableLayoutStruct? updateTableLayoutStruct(
  TableLayoutStruct? tableLayout, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tableLayout
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTableLayoutStructData(
  Map<String, dynamic> supabaseData,
  TableLayoutStruct? tableLayout,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (tableLayout == null) {
    return;
  }
  if (tableLayout.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tableLayout.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final tableLayoutData =
      getTableLayoutFirestoreData(tableLayout, forFieldValue);
  final nestedData =
      tableLayoutData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tableLayout.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTableLayoutFirestoreData(
  TableLayoutStruct? tableLayout, [
  bool forFieldValue = false,
]) {
  if (tableLayout == null) {
    return {};
  }
  final supabaseData = mapToSupabase(tableLayout.toMap());

  // Add any Firestore field values
  tableLayout.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getTableLayoutListFirestoreData(
  List<TableLayoutStruct>? tableLayouts,
) =>
    tableLayouts?.map((e) => getTableLayoutFirestoreData(e, true)).toList() ??
    [];
