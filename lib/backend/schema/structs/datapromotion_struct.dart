// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DatapromotionStruct extends FFSupabaseStruct {
  DatapromotionStruct({
    String? namevenuse,
    double? distance,
    SupabaseDocRef? iDvenuse,
    String? logo,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _namevenuse = namevenuse,
        _distance = distance,
        _iDvenuse = iDvenuse,
        _logo = logo,
        super(supabaseUtilData);

  // "namevenuse" field.
  String? _namevenuse;
  String get namevenuse => _namevenuse ?? '';
  set namevenuse(String? val) => _namevenuse = val;

  bool hasNamevenuse() => _namevenuse != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "IDvenuse" field.
  SupabaseDocRef? _iDvenuse;
  SupabaseDocRef? get iDvenuse => _iDvenuse;
  set iDvenuse(SupabaseDocRef? val) => _iDvenuse = val;

  bool hasIDvenuse() => _iDvenuse != null;

  // "logo" field.
  String? _logo;
  String get logo => _logo ?? '';
  set logo(String? val) => _logo = val;

  bool hasLogo() => _logo != null;

  static DatapromotionStruct fromMap(Map<String, dynamic> data) =>
      DatapromotionStruct(
        namevenuse: data['namevenuse'] as String?,
        distance: castToType<double>(data['distance']),
        iDvenuse: data['IDvenuse'] as SupabaseDocRef?,
        logo: data['logo'] as String?,
      );

  static DatapromotionStruct? maybeFromMap(dynamic data) => data is Map
      ? DatapromotionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'namevenuse': _namevenuse,
        'distance': _distance,
        'IDvenuse': _iDvenuse,
        'logo': _logo,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'namevenuse': serializeParam(
          _namevenuse,
          ParamType.String,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'IDvenuse': serializeParam(
          _iDvenuse,
          ParamType.SupabaseDocRef,
        ),
        'logo': serializeParam(
          _logo,
          ParamType.String,
        ),
      }.withoutNulls;

  static DatapromotionStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatapromotionStruct(
        namevenuse: deserializeParam(
          data['namevenuse'],
          ParamType.String,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        iDvenuse: deserializeParam(
          data['IDvenuse'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['Venues'],
        ),
        logo: deserializeParam(
          data['logo'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DatapromotionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatapromotionStruct &&
        namevenuse == other.namevenuse &&
        distance == other.distance &&
        iDvenuse == other.iDvenuse &&
        logo == other.logo;
  }

  @override
  int get hashCode =>
      ListEquality().hash([namevenuse, distance, iDvenuse, logo]);
}

DatapromotionStruct createDatapromotionStruct({
  String? namevenuse,
  double? distance,
  SupabaseDocRef? iDvenuse,
  String? logo,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DatapromotionStruct(
      namevenuse: namevenuse,
      distance: distance,
      iDvenuse: iDvenuse,
      logo: logo,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DatapromotionStruct? updateDatapromotionStruct(
  DatapromotionStruct? datapromotion, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    datapromotion
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDatapromotionStructData(
  Map<String, dynamic> supabaseData,
  DatapromotionStruct? datapromotion,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (datapromotion == null) {
    return;
  }
  if (datapromotion.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && datapromotion.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final datapromotionData =
      getDatapromotionFirestoreData(datapromotion, forFieldValue);
  final nestedData =
      datapromotionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = datapromotion.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDatapromotionFirestoreData(
  DatapromotionStruct? datapromotion, [
  bool forFieldValue = false,
]) {
  if (datapromotion == null) {
    return {};
  }
  final supabaseData = mapToSupabase(datapromotion.toMap());

  // Add any Firestore field values
  datapromotion.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDatapromotionListFirestoreData(
  List<DatapromotionStruct>? datapromotions,
) =>
    datapromotions
        ?.map((e) => getDatapromotionFirestoreData(e, true))
        .toList() ??
    [];
