// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DatauserStruct extends FFSupabaseStruct {
  DatauserStruct({
    SupabaseDocRef? userinstore,
    String? photoprofile,
    String? name,
    bool? online,
    int? view,
    String? caption,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _userinstore = userinstore,
        _photoprofile = photoprofile,
        _name = name,
        _online = online,
        _view = view,
        _caption = caption,
        super(supabaseUtilData);

  // "userinstore" field.
  SupabaseDocRef? _userinstore;
  SupabaseDocRef? get userinstore => _userinstore;
  set userinstore(SupabaseDocRef? val) => _userinstore = val;

  bool hasUserinstore() => _userinstore != null;

  // "photoprofile" field.
  String? _photoprofile;
  String get photoprofile => _photoprofile ?? '';
  set photoprofile(String? val) => _photoprofile = val;

  bool hasPhotoprofile() => _photoprofile != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "online" field.
  bool? _online;
  bool get online => _online ?? false;
  set online(bool? val) => _online = val;

  bool hasOnline() => _online != null;

  // "view" field.
  int? _view;
  int get view => _view ?? 0;
  set view(int? val) => _view = val;

  void incrementView(int amount) => view = view + amount;

  bool hasView() => _view != null;

  // "caption" field.
  String? _caption;
  String get caption => _caption ?? '';
  set caption(String? val) => _caption = val;

  bool hasCaption() => _caption != null;

  static DatauserStruct fromMap(Map<String, dynamic> data) => DatauserStruct(
        userinstore: data['userinstore'] as SupabaseDocRef?,
        photoprofile: data['photoprofile'] as String?,
        name: data['name'] as String?,
        online: data['online'] as bool?,
        view: castToType<int>(data['view']),
        caption: data['caption'] as String?,
      );

  static DatauserStruct? maybeFromMap(dynamic data) =>
      data is Map ? DatauserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'userinstore': _userinstore,
        'photoprofile': _photoprofile,
        'name': _name,
        'online': _online,
        'view': _view,
        'caption': _caption,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userinstore': serializeParam(
          _userinstore,
          ParamType.SupabaseDocRef,
        ),
        'photoprofile': serializeParam(
          _photoprofile,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'online': serializeParam(
          _online,
          ParamType.bool,
        ),
        'view': serializeParam(
          _view,
          ParamType.int,
        ),
        'caption': serializeParam(
          _caption,
          ParamType.String,
        ),
      }.withoutNulls;

  static DatauserStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatauserStruct(
        userinstore: deserializeParam(
          data['userinstore'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        photoprofile: deserializeParam(
          data['photoprofile'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        online: deserializeParam(
          data['online'],
          ParamType.bool,
          false,
        ),
        view: deserializeParam(
          data['view'],
          ParamType.int,
          false,
        ),
        caption: deserializeParam(
          data['caption'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DatauserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatauserStruct &&
        userinstore == other.userinstore &&
        photoprofile == other.photoprofile &&
        name == other.name &&
        online == other.online &&
        view == other.view &&
        caption == other.caption;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userinstore, photoprofile, name, online, view, caption]);
}

DatauserStruct createDatauserStruct({
  SupabaseDocRef? userinstore,
  String? photoprofile,
  String? name,
  bool? online,
  int? view,
  String? caption,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DatauserStruct(
      userinstore: userinstore,
      photoprofile: photoprofile,
      name: name,
      online: online,
      view: view,
      caption: caption,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DatauserStruct? updateDatauserStruct(
  DatauserStruct? datauser, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    datauser
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDatauserStructData(
  Map<String, dynamic> supabaseData,
  DatauserStruct? datauser,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (datauser == null) {
    return;
  }
  if (datauser.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && datauser.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final datauserData = getDatauserFirestoreData(datauser, forFieldValue);
  final nestedData = datauserData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = datauser.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDatauserFirestoreData(
  DatauserStruct? datauser, [
  bool forFieldValue = false,
]) {
  if (datauser == null) {
    return {};
  }
  final supabaseData = mapToSupabase(datauser.toMap());

  // Add any Firestore field values
  datauser.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDatauserListFirestoreData(
  List<DatauserStruct>? datausers,
) =>
    datausers?.map((e) => getDatauserFirestoreData(e, true)).toList() ?? [];
