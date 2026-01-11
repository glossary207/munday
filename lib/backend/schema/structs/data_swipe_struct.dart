// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataSwipeStruct extends FFSupabaseStruct {
  DataSwipeStruct({
    SupabaseDocRef? iDuserSW,
    String? photoprofileSW,
    UserphotoshowStruct? userphotoshowSW,
    String? captionSW,
    String? idIgSw,
    String? iDFacebookSW,
    String? nameSW,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _iDuserSW = iDuserSW,
        _photoprofileSW = photoprofileSW,
        _userphotoshowSW = userphotoshowSW,
        _captionSW = captionSW,
        _idIgSw = idIgSw,
        _iDFacebookSW = iDFacebookSW,
        _nameSW = nameSW,
        super(supabaseUtilData);

  // "IDuser_SW" field.
  SupabaseDocRef? _iDuserSW;
  SupabaseDocRef? get iDuserSW => _iDuserSW;
  set iDuserSW(SupabaseDocRef? val) => _iDuserSW = val;

  bool hasIDuserSW() => _iDuserSW != null;

  // "photoprofile_SW" field.
  String? _photoprofileSW;
  String get photoprofileSW => _photoprofileSW ?? '';
  set photoprofileSW(String? val) => _photoprofileSW = val;

  bool hasPhotoprofileSW() => _photoprofileSW != null;

  // "userphotoshow_SW" field.
  UserphotoshowStruct? _userphotoshowSW;
  UserphotoshowStruct get userphotoshowSW =>
      _userphotoshowSW ?? UserphotoshowStruct();
  set userphotoshowSW(UserphotoshowStruct? val) => _userphotoshowSW = val;

  void updateUserphotoshowSW(Function(UserphotoshowStruct) updateFn) {
    updateFn(_userphotoshowSW ??= UserphotoshowStruct());
  }

  bool hasUserphotoshowSW() => _userphotoshowSW != null;

  // "Caption_SW" field.
  String? _captionSW;
  String get captionSW => _captionSW ?? '';
  set captionSW(String? val) => _captionSW = val;

  bool hasCaptionSW() => _captionSW != null;

  // "ID_IG_SW" field.
  String? _idIgSw;
  String get idIgSw => _idIgSw ?? '';
  set idIgSw(String? val) => _idIgSw = val;

  bool hasIdIgSw() => _idIgSw != null;

  // "ID_Facebook_SW" field.
  String? _iDFacebookSW;
  String get iDFacebookSW => _iDFacebookSW ?? '';
  set iDFacebookSW(String? val) => _iDFacebookSW = val;

  bool hasIDFacebookSW() => _iDFacebookSW != null;

  // "Name_SW" field.
  String? _nameSW;
  String get nameSW => _nameSW ?? '';
  set nameSW(String? val) => _nameSW = val;

  bool hasNameSW() => _nameSW != null;

  static DataSwipeStruct fromMap(Map<String, dynamic> data) => DataSwipeStruct(
        iDuserSW: data['IDuser_SW'] as SupabaseDocRef?,
        photoprofileSW: data['photoprofile_SW'] as String?,
        userphotoshowSW: data['userphotoshow_SW'] is UserphotoshowStruct
            ? data['userphotoshow_SW']
            : UserphotoshowStruct.maybeFromMap(data['userphotoshow_SW']),
        captionSW: data['Caption_SW'] as String?,
        idIgSw: data['ID_IG_SW'] as String?,
        iDFacebookSW: data['ID_Facebook_SW'] as String?,
        nameSW: data['Name_SW'] as String?,
      );

  static DataSwipeStruct? maybeFromMap(dynamic data) => data is Map
      ? DataSwipeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'IDuser_SW': _iDuserSW,
        'photoprofile_SW': _photoprofileSW,
        'userphotoshow_SW': _userphotoshowSW?.toMap(),
        'Caption_SW': _captionSW,
        'ID_IG_SW': _idIgSw,
        'ID_Facebook_SW': _iDFacebookSW,
        'Name_SW': _nameSW,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'IDuser_SW': serializeParam(
          _iDuserSW,
          ParamType.SupabaseDocRef,
        ),
        'photoprofile_SW': serializeParam(
          _photoprofileSW,
          ParamType.String,
        ),
        'userphotoshow_SW': serializeParam(
          _userphotoshowSW,
          ParamType.DataStruct,
        ),
        'Caption_SW': serializeParam(
          _captionSW,
          ParamType.String,
        ),
        'ID_IG_SW': serializeParam(
          _idIgSw,
          ParamType.String,
        ),
        'ID_Facebook_SW': serializeParam(
          _iDFacebookSW,
          ParamType.String,
        ),
        'Name_SW': serializeParam(
          _nameSW,
          ParamType.String,
        ),
      }.withoutNulls;

  static DataSwipeStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataSwipeStruct(
        iDuserSW: deserializeParam(
          data['IDuser_SW'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        photoprofileSW: deserializeParam(
          data['photoprofile_SW'],
          ParamType.String,
          false,
        ),
        userphotoshowSW: deserializeStructParam(
          data['userphotoshow_SW'],
          ParamType.DataStruct,
          false,
          structBuilder: UserphotoshowStruct.fromSerializableMap,
        ),
        captionSW: deserializeParam(
          data['Caption_SW'],
          ParamType.String,
          false,
        ),
        idIgSw: deserializeParam(
          data['ID_IG_SW'],
          ParamType.String,
          false,
        ),
        iDFacebookSW: deserializeParam(
          data['ID_Facebook_SW'],
          ParamType.String,
          false,
        ),
        nameSW: deserializeParam(
          data['Name_SW'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DataSwipeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DataSwipeStruct &&
        iDuserSW == other.iDuserSW &&
        photoprofileSW == other.photoprofileSW &&
        userphotoshowSW == other.userphotoshowSW &&
        captionSW == other.captionSW &&
        idIgSw == other.idIgSw &&
        iDFacebookSW == other.iDFacebookSW &&
        nameSW == other.nameSW;
  }

  @override
  int get hashCode => ListEquality().hash([
        iDuserSW,
        photoprofileSW,
        userphotoshowSW,
        captionSW,
        idIgSw,
        iDFacebookSW,
        nameSW
      ]);
}

DataSwipeStruct createDataSwipeStruct({
  SupabaseDocRef? iDuserSW,
  String? photoprofileSW,
  UserphotoshowStruct? userphotoshowSW,
  String? captionSW,
  String? idIgSw,
  String? iDFacebookSW,
  String? nameSW,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataSwipeStruct(
      iDuserSW: iDuserSW,
      photoprofileSW: photoprofileSW,
      userphotoshowSW:
          userphotoshowSW ?? (clearUnsetFields ? UserphotoshowStruct() : null),
      captionSW: captionSW,
      idIgSw: idIgSw,
      iDFacebookSW: iDFacebookSW,
      nameSW: nameSW,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataSwipeStruct? updateDataSwipeStruct(
  DataSwipeStruct? dataSwipe, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataSwipe
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataSwipeStructData(
  Map<String, dynamic> supabaseData,
  DataSwipeStruct? dataSwipe,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (dataSwipe == null) {
    return;
  }
  if (dataSwipe.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataSwipe.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final dataSwipeData = getDataSwipeFirestoreData(dataSwipe, forFieldValue);
  final nestedData = dataSwipeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataSwipe.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataSwipeFirestoreData(
  DataSwipeStruct? dataSwipe, [
  bool forFieldValue = false,
]) {
  if (dataSwipe == null) {
    return {};
  }
  final supabaseData = mapToSupabase(dataSwipe.toMap());

  // Handle nested data for "userphotoshow_SW" field.
  addUserphotoshowStructData(
    supabaseData,
    dataSwipe.hasUserphotoshowSW() ? dataSwipe.userphotoshowSW : null,
    'userphotoshow_SW',
    forFieldValue,
  );

  // Add any Firestore field values
  dataSwipe.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDataSwipeListFirestoreData(
  List<DataSwipeStruct>? dataSwipes,
) =>
    dataSwipes?.map((e) => getDataSwipeFirestoreData(e, true)).toList() ?? [];
