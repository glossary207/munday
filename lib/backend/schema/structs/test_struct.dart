// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TestStruct extends FFSupabaseStruct {
  TestStruct({
    DateTime? time,
    List<ContactStruct>? data,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _time = time,
        _data = data,
        super(supabaseUtilData);

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  set time(DateTime? val) => _time = val;

  bool hasTime() => _time != null;

  // "data" field.
  List<ContactStruct>? _data;
  List<ContactStruct> get data => _data ?? const [];
  set data(List<ContactStruct>? val) => _data = val;

  void updateData(Function(List<ContactStruct>) updateFn) {
    updateFn(_data ??= []);
  }

  bool hasData() => _data != null;

  static TestStruct fromMap(Map<String, dynamic> data) => TestStruct(
        time: data['time'] as DateTime?,
        data: getStructList(
          data['data'],
          ContactStruct.fromMap,
        ),
      );

  static TestStruct? maybeFromMap(dynamic data) =>
      data is Map ? TestStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'time': _time,
        'data': _data?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'time': serializeParam(
          _time,
          ParamType.DateTime,
        ),
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static TestStruct fromSerializableMap(Map<String, dynamic> data) =>
      TestStruct(
        time: deserializeParam(
          data['time'],
          ParamType.DateTime,
          false,
        ),
        data: deserializeStructParam<ContactStruct>(
          data['data'],
          ParamType.DataStruct,
          true,
          structBuilder: ContactStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TestStruct &&
        time == other.time &&
        listEquality.equals(data, other.data);
  }

  @override
  int get hashCode => ListEquality().hash([time, data]);
}

TestStruct createTestStruct({
  DateTime? time,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TestStruct(
      time: time,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TestStruct? updateTestStruct(
  TestStruct? test, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    test
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTestStructData(
  Map<String, dynamic> supabaseData,
  TestStruct? test,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (test == null) {
    return;
  }
  if (test.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && test.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final testData = getTestFirestoreData(test, forFieldValue);
  final nestedData = testData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = test.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTestFirestoreData(
  TestStruct? test, [
  bool forFieldValue = false,
]) {
  if (test == null) {
    return {};
  }
  final supabaseData = mapToSupabase(test.toMap());

  // Add any Firestore field values
  test.supabaseUtilData.fieldValues.forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getTestListFirestoreData(
  List<TestStruct>? tests,
) =>
    tests?.map((e) => getTestFirestoreData(e, true)).toList() ?? [];
