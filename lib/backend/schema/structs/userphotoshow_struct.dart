// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserphotoshowStruct extends FFSupabaseStruct {
  UserphotoshowStruct({
    String? photo1,
    String? photo2,
    String? photo3,
    String? photo4,
    String? photo5,
    String? photo6,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _photo1 = photo1,
        _photo2 = photo2,
        _photo3 = photo3,
        _photo4 = photo4,
        _photo5 = photo5,
        _photo6 = photo6,
        super(supabaseUtilData);

  // "photo1" field.
  String? _photo1;
  String get photo1 => _photo1 ?? '';
  set photo1(String? val) => _photo1 = val;

  bool hasPhoto1() => _photo1 != null;

  // "photo2" field.
  String? _photo2;
  String get photo2 => _photo2 ?? '';
  set photo2(String? val) => _photo2 = val;

  bool hasPhoto2() => _photo2 != null;

  // "photo3" field.
  String? _photo3;
  String get photo3 => _photo3 ?? '';
  set photo3(String? val) => _photo3 = val;

  bool hasPhoto3() => _photo3 != null;

  // "photo4" field.
  String? _photo4;
  String get photo4 => _photo4 ?? '';
  set photo4(String? val) => _photo4 = val;

  bool hasPhoto4() => _photo4 != null;

  // "photo5" field.
  String? _photo5;
  String get photo5 => _photo5 ?? '';
  set photo5(String? val) => _photo5 = val;

  bool hasPhoto5() => _photo5 != null;

  // "photo6" field.
  String? _photo6;
  String get photo6 => _photo6 ?? '';
  set photo6(String? val) => _photo6 = val;

  bool hasPhoto6() => _photo6 != null;

  static UserphotoshowStruct fromMap(Map<String, dynamic> data) =>
      UserphotoshowStruct(
        photo1: data['photo1'] as String?,
        photo2: data['photo2'] as String?,
        photo3: data['photo3'] as String?,
        photo4: data['photo4'] as String?,
        photo5: data['photo5'] as String?,
        photo6: data['photo6'] as String?,
      );

  static UserphotoshowStruct? maybeFromMap(dynamic data) => data is Map
      ? UserphotoshowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'photo1': _photo1,
        'photo2': _photo2,
        'photo3': _photo3,
        'photo4': _photo4,
        'photo5': _photo5,
        'photo6': _photo6,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'photo1': serializeParam(
          _photo1,
          ParamType.String,
        ),
        'photo2': serializeParam(
          _photo2,
          ParamType.String,
        ),
        'photo3': serializeParam(
          _photo3,
          ParamType.String,
        ),
        'photo4': serializeParam(
          _photo4,
          ParamType.String,
        ),
        'photo5': serializeParam(
          _photo5,
          ParamType.String,
        ),
        'photo6': serializeParam(
          _photo6,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserphotoshowStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserphotoshowStruct(
        photo1: deserializeParam(
          data['photo1'],
          ParamType.String,
          false,
        ),
        photo2: deserializeParam(
          data['photo2'],
          ParamType.String,
          false,
        ),
        photo3: deserializeParam(
          data['photo3'],
          ParamType.String,
          false,
        ),
        photo4: deserializeParam(
          data['photo4'],
          ParamType.String,
          false,
        ),
        photo5: deserializeParam(
          data['photo5'],
          ParamType.String,
          false,
        ),
        photo6: deserializeParam(
          data['photo6'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserphotoshowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserphotoshowStruct &&
        photo1 == other.photo1 &&
        photo2 == other.photo2 &&
        photo3 == other.photo3 &&
        photo4 == other.photo4 &&
        photo5 == other.photo5 &&
        photo6 == other.photo6;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([photo1, photo2, photo3, photo4, photo5, photo6]);
}

UserphotoshowStruct createUserphotoshowStruct({
  String? photo1,
  String? photo2,
  String? photo3,
  String? photo4,
  String? photo5,
  String? photo6,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserphotoshowStruct(
      photo1: photo1,
      photo2: photo2,
      photo3: photo3,
      photo4: photo4,
      photo5: photo5,
      photo6: photo6,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserphotoshowStruct? updateUserphotoshowStruct(
  UserphotoshowStruct? userphotoshow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userphotoshow
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserphotoshowStructData(
  Map<String, dynamic> supabaseData,
  UserphotoshowStruct? userphotoshow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (userphotoshow == null) {
    return;
  }
  if (userphotoshow.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userphotoshow.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final userphotoshowData =
      getUserphotoshowFirestoreData(userphotoshow, forFieldValue);
  final nestedData =
      userphotoshowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userphotoshow.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserphotoshowFirestoreData(
  UserphotoshowStruct? userphotoshow, [
  bool forFieldValue = false,
]) {
  if (userphotoshow == null) {
    return {};
  }
  final supabaseData = mapToSupabase(userphotoshow.toMap());

  // Add any Firestore field values
  userphotoshow.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getUserphotoshowListFirestoreData(
  List<UserphotoshowStruct>? userphotoshows,
) =>
    userphotoshows
        ?.map((e) => getUserphotoshowFirestoreData(e, true))
        .toList() ??
    [];
