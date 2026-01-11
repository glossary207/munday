// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ListpayStruct extends FFSupabaseStruct {
  ListpayStruct({
    List<String>? pack,
    List<DateTime>? timepay,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _pack = pack,
        _timepay = timepay,
        super(supabaseUtilData);

  // "pack" field.
  List<String>? _pack;
  List<String> get pack => _pack ?? const [];
  set pack(List<String>? val) => _pack = val;

  void updatePack(Function(List<String>) updateFn) {
    updateFn(_pack ??= []);
  }

  bool hasPack() => _pack != null;

  // "timepay" field.
  List<DateTime>? _timepay;
  List<DateTime> get timepay => _timepay ?? const [];
  set timepay(List<DateTime>? val) => _timepay = val;

  void updateTimepay(Function(List<DateTime>) updateFn) {
    updateFn(_timepay ??= []);
  }

  bool hasTimepay() => _timepay != null;

  static ListpayStruct fromMap(Map<String, dynamic> data) => ListpayStruct(
        pack: getDataList(data['pack']),
        timepay: getDataList(data['timepay']),
      );

  static ListpayStruct? maybeFromMap(dynamic data) =>
      data is Map ? ListpayStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'pack': _pack,
        'timepay': _timepay,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'pack': serializeParam(
          _pack,
          ParamType.String,
          isList: true,
        ),
        'timepay': serializeParam(
          _timepay,
          ParamType.DateTime,
          isList: true,
        ),
      }.withoutNulls;

  static ListpayStruct fromSerializableMap(Map<String, dynamic> data) =>
      ListpayStruct(
        pack: deserializeParam<String>(
          data['pack'],
          ParamType.String,
          true,
        ),
        timepay: deserializeParam<DateTime>(
          data['timepay'],
          ParamType.DateTime,
          true,
        ),
      );

  @override
  String toString() => 'ListpayStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ListpayStruct &&
        listEquality.equals(pack, other.pack) &&
        listEquality.equals(timepay, other.timepay);
  }

  @override
  int get hashCode => ListEquality().hash([pack, timepay]);
}

ListpayStruct createListpayStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ListpayStruct(
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ListpayStruct? updateListpayStruct(
  ListpayStruct? listpay, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    listpay
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addListpayStructData(
  Map<String, dynamic> supabaseData,
  ListpayStruct? listpay,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (listpay == null) {
    return;
  }
  if (listpay.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && listpay.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final listpayData = getListpayFirestoreData(listpay, forFieldValue);
  final nestedData = listpayData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = listpay.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getListpayFirestoreData(
  ListpayStruct? listpay, [
  bool forFieldValue = false,
]) {
  if (listpay == null) {
    return {};
  }
  final supabaseData = mapToSupabase(listpay.toMap());

  // Add any Firestore field values
  listpay.supabaseUtilData.fieldValues.forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getListpayListFirestoreData(
  List<ListpayStruct>? listpays,
) =>
    listpays?.map((e) => getListpayFirestoreData(e, true)).toList() ?? [];
