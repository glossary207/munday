// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DatamassageStruct extends FFSupabaseStruct {
  DatamassageStruct({
    SupabaseDocRef? who,
    String? messagetext,
    String? messagephoto,
    DateTime? timeup,
    int? idchat,
    String? userphoto,
    String? name,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _who = who,
        _messagetext = messagetext,
        _messagephoto = messagephoto,
        _timeup = timeup,
        _idchat = idchat,
        _userphoto = userphoto,
        _name = name,
        super(supabaseUtilData);

  // "who" field.
  SupabaseDocRef? _who;
  SupabaseDocRef? get who => _who;
  set who(SupabaseDocRef? val) => _who = val;

  bool hasWho() => _who != null;

  // "messagetext" field.
  String? _messagetext;
  String get messagetext => _messagetext ?? '';
  set messagetext(String? val) => _messagetext = val;

  bool hasMessagetext() => _messagetext != null;

  // "messagephoto" field.
  String? _messagephoto;
  String get messagephoto => _messagephoto ?? '';
  set messagephoto(String? val) => _messagephoto = val;

  bool hasMessagephoto() => _messagephoto != null;

  // "timeup" field.
  DateTime? _timeup;
  DateTime? get timeup => _timeup;
  set timeup(DateTime? val) => _timeup = val;

  bool hasTimeup() => _timeup != null;

  // "idchat" field.
  int? _idchat;
  int get idchat => _idchat ?? 0;
  set idchat(int? val) => _idchat = val;

  void incrementIdchat(int amount) => idchat = idchat + amount;

  bool hasIdchat() => _idchat != null;

  // "userphoto" field.
  String? _userphoto;
  String get userphoto => _userphoto ?? '';
  set userphoto(String? val) => _userphoto = val;

  bool hasUserphoto() => _userphoto != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static DatamassageStruct fromMap(Map<String, dynamic> data) =>
      DatamassageStruct(
        who: data['who'] as SupabaseDocRef?,
        messagetext: data['messagetext'] as String?,
        messagephoto: data['messagephoto'] as String?,
        timeup: data['timeup'] as DateTime?,
        idchat: castToType<int>(data['idchat']),
        userphoto: data['userphoto'] as String?,
        name: data['name'] as String?,
      );

  static DatamassageStruct? maybeFromMap(dynamic data) => data is Map
      ? DatamassageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'who': _who,
        'messagetext': _messagetext,
        'messagephoto': _messagephoto,
        'timeup': _timeup,
        'idchat': _idchat,
        'userphoto': _userphoto,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'who': serializeParam(
          _who,
          ParamType.SupabaseDocRef,
        ),
        'messagetext': serializeParam(
          _messagetext,
          ParamType.String,
        ),
        'messagephoto': serializeParam(
          _messagephoto,
          ParamType.String,
        ),
        'timeup': serializeParam(
          _timeup,
          ParamType.DateTime,
        ),
        'idchat': serializeParam(
          _idchat,
          ParamType.int,
        ),
        'userphoto': serializeParam(
          _userphoto,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static DatamassageStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatamassageStruct(
        who: deserializeParam(
          data['who'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['users'],
        ),
        messagetext: deserializeParam(
          data['messagetext'],
          ParamType.String,
          false,
        ),
        messagephoto: deserializeParam(
          data['messagephoto'],
          ParamType.String,
          false,
        ),
        timeup: deserializeParam(
          data['timeup'],
          ParamType.DateTime,
          false,
        ),
        idchat: deserializeParam(
          data['idchat'],
          ParamType.int,
          false,
        ),
        userphoto: deserializeParam(
          data['userphoto'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DatamassageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatamassageStruct &&
        who == other.who &&
        messagetext == other.messagetext &&
        messagephoto == other.messagephoto &&
        timeup == other.timeup &&
        idchat == other.idchat &&
        userphoto == other.userphoto &&
        name == other.name;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([who, messagetext, messagephoto, timeup, idchat, userphoto, name]);
}

DatamassageStruct createDatamassageStruct({
  SupabaseDocRef? who,
  String? messagetext,
  String? messagephoto,
  DateTime? timeup,
  int? idchat,
  String? userphoto,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DatamassageStruct(
      who: who,
      messagetext: messagetext,
      messagephoto: messagephoto,
      timeup: timeup,
      idchat: idchat,
      userphoto: userphoto,
      name: name,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DatamassageStruct? updateDatamassageStruct(
  DatamassageStruct? datamassage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    datamassage
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDatamassageStructData(
  Map<String, dynamic> supabaseData,
  DatamassageStruct? datamassage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (datamassage == null) {
    return;
  }
  if (datamassage.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && datamassage.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final datamassageData =
      getDatamassageFirestoreData(datamassage, forFieldValue);
  final nestedData =
      datamassageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = datamassage.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDatamassageFirestoreData(
  DatamassageStruct? datamassage, [
  bool forFieldValue = false,
]) {
  if (datamassage == null) {
    return {};
  }
  final supabaseData = mapToSupabase(datamassage.toMap());

  // Add any Firestore field values
  datamassage.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDatamassageListFirestoreData(
  List<DatamassageStruct>? datamassages,
) =>
    datamassages?.map((e) => getDatamassageFirestoreData(e, true)).toList() ??
    [];
