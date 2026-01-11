// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DatapageroomStruct extends FFSupabaseStruct {
  DatapageroomStruct({
    SupabaseDocRef? userinstore,
    int? view,
    String? photoprofile,
    bool? online,
    String? name,
    String? caption,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _userinstore = userinstore,
        _view = view,
        _photoprofile = photoprofile,
        _online = online,
        _name = name,
        _caption = caption,
        super(supabaseUtilData);

  // "userinstore" field.
  SupabaseDocRef? _userinstore;
  SupabaseDocRef? get userinstore => _userinstore;
  set userinstore(SupabaseDocRef? val) => _userinstore = val;

  bool hasUserinstore() => _userinstore != null;

  // "view" field.
  int? _view;
  int get view => _view ?? 0;
  set view(int? val) => _view = val;

  void incrementView(int amount) => view = view + amount;

  bool hasView() => _view != null;

  // "photoprofile" field.
  String? _photoprofile;
  String get photoprofile => _photoprofile ?? '';
  set photoprofile(String? val) => _photoprofile = val;

  bool hasPhotoprofile() => _photoprofile != null;

  // "online" field.
  bool? _online;
  bool get online => _online ?? false;
  set online(bool? val) => _online = val;

  bool hasOnline() => _online != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "caption" field.
  String? _caption;
  String get caption => _caption ?? '';
  set caption(String? val) => _caption = val;

  bool hasCaption() => _caption != null;

  static DatapageroomStruct fromMap(Map<String, dynamic> data) =>
      DatapageroomStruct(
        userinstore: data['userinstore'] as SupabaseDocRef?,
        view: castToType<int>(data['view']),
        photoprofile: data['photoprofile'] as String?,
        online: data['online'] as bool?,
        name: data['name'] as String?,
        caption: data['caption'] as String?,
      );

  static DatapageroomStruct? maybeFromMap(dynamic data) => data is Map
      ? DatapageroomStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userinstore': _userinstore,
        'view': _view,
        'photoprofile': _photoprofile,
        'online': _online,
        'name': _name,
        'caption': _caption,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userinstore': serializeParam(
          _userinstore,
          ParamType.SupabaseDocRef,
        ),
        'view': serializeParam(
          _view,
          ParamType.int,
        ),
        'photoprofile': serializeParam(
          _photoprofile,
          ParamType.String,
        ),
        'online': serializeParam(
          _online,
          ParamType.bool,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'caption': serializeParam(
          _caption,
          ParamType.String,
        ),
      }.withoutNulls;

  static DatapageroomStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatapageroomStruct(
        userinstore: deserializeParam(
          data['userinstore'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        view: deserializeParam(
          data['view'],
          ParamType.int,
          false,
        ),
        photoprofile: deserializeParam(
          data['photoprofile'],
          ParamType.String,
          false,
        ),
        online: deserializeParam(
          data['online'],
          ParamType.bool,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        caption: deserializeParam(
          data['caption'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DatapageroomStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatapageroomStruct &&
        userinstore == other.userinstore &&
        view == other.view &&
        photoprofile == other.photoprofile &&
        online == other.online &&
        name == other.name &&
        caption == other.caption;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userinstore, view, photoprofile, online, name, caption]);
}

DatapageroomStruct createDatapageroomStruct({
  SupabaseDocRef? userinstore,
  int? view,
  String? photoprofile,
  bool? online,
  String? name,
  String? caption,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DatapageroomStruct(
      userinstore: userinstore,
      view: view,
      photoprofile: photoprofile,
      online: online,
      name: name,
      caption: caption,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DatapageroomStruct? updateDatapageroomStruct(
  DatapageroomStruct? datapageroom, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    datapageroom
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDatapageroomStructData(
  Map<String, dynamic> supabaseData,
  DatapageroomStruct? datapageroom,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (datapageroom == null) {
    return;
  }
  if (datapageroom.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && datapageroom.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final datapageroomData =
      getDatapageroomFirestoreData(datapageroom, forFieldValue);
  final nestedData =
      datapageroomData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = datapageroom.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDatapageroomFirestoreData(
  DatapageroomStruct? datapageroom, [
  bool forFieldValue = false,
]) {
  if (datapageroom == null) {
    return {};
  }
  final supabaseData = mapToSupabase(datapageroom.toMap());

  // Add any Firestore field values
  datapageroom.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDatapageroomListFirestoreData(
  List<DatapageroomStruct>? datapagerooms,
) =>
    datapagerooms?.map((e) => getDatapageroomFirestoreData(e, true)).toList() ??
    [];
