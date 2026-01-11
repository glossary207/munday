// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ContactStruct extends FFSupabaseStruct {
  ContactStruct({
    String? phone,
    String? ig,
    String? facebook,
    String? line,
    String? tiktok,
    String? name,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _phone = phone,
        _ig = ig,
        _facebook = facebook,
        _line = line,
        _tiktok = tiktok,
        _name = name,
        super(supabaseUtilData);

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  set phone(String? val) => _phone = val;

  bool hasPhone() => _phone != null;

  // "IG" field.
  String? _ig;
  String get ig => _ig ?? '';
  set ig(String? val) => _ig = val;

  bool hasIg() => _ig != null;

  // "facebook" field.
  String? _facebook;
  String get facebook => _facebook ?? '';
  set facebook(String? val) => _facebook = val;

  bool hasFacebook() => _facebook != null;

  // "line" field.
  String? _line;
  String get line => _line ?? '';
  set line(String? val) => _line = val;

  bool hasLine() => _line != null;

  // "Tiktok" field.
  String? _tiktok;
  String get tiktok => _tiktok ?? '';
  set tiktok(String? val) => _tiktok = val;

  bool hasTiktok() => _tiktok != null;

  // "Name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static ContactStruct fromMap(Map<String, dynamic> data) => ContactStruct(
        phone: data['phone'] as String?,
        ig: data['IG'] as String?,
        facebook: data['facebook'] as String?,
        line: data['line'] as String?,
        tiktok: data['Tiktok'] as String?,
        name: data['Name'] as String?,
      );

  static ContactStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContactStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'phone': _phone,
        'IG': _ig,
        'facebook': _facebook,
        'line': _line,
        'Tiktok': _tiktok,
        'Name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'phone': serializeParam(
          _phone,
          ParamType.String,
        ),
        'IG': serializeParam(
          _ig,
          ParamType.String,
        ),
        'facebook': serializeParam(
          _facebook,
          ParamType.String,
        ),
        'line': serializeParam(
          _line,
          ParamType.String,
        ),
        'Tiktok': serializeParam(
          _tiktok,
          ParamType.String,
        ),
        'Name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static ContactStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContactStruct(
        phone: deserializeParam(
          data['phone'],
          ParamType.String,
          false,
        ),
        ig: deserializeParam(
          data['IG'],
          ParamType.String,
          false,
        ),
        facebook: deserializeParam(
          data['facebook'],
          ParamType.String,
          false,
        ),
        line: deserializeParam(
          data['line'],
          ParamType.String,
          false,
        ),
        tiktok: deserializeParam(
          data['Tiktok'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['Name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ContactStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContactStruct &&
        phone == other.phone &&
        ig == other.ig &&
        facebook == other.facebook &&
        line == other.line &&
        tiktok == other.tiktok &&
        name == other.name;
  }

  @override
  int get hashCode =>
      ListEquality().hash([phone, ig, facebook, line, tiktok, name]);
}

ContactStruct createContactStruct({
  String? phone,
  String? ig,
  String? facebook,
  String? line,
  String? tiktok,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ContactStruct(
      phone: phone,
      ig: ig,
      facebook: facebook,
      line: line,
      tiktok: tiktok,
      name: name,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ContactStruct? updateContactStruct(
  ContactStruct? contact, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    contact
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addContactStructData(
  Map<String, dynamic> supabaseData,
  ContactStruct? contact,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (contact == null) {
    return;
  }
  if (contact.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && contact.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final contactData = getContactFirestoreData(contact, forFieldValue);
  final nestedData = contactData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = contact.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getContactFirestoreData(
  ContactStruct? contact, [
  bool forFieldValue = false,
]) {
  if (contact == null) {
    return {};
  }
  final supabaseData = mapToSupabase(contact.toMap());

  // Add any Firestore field values
  contact.supabaseUtilData.fieldValues.forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getContactListFirestoreData(
  List<ContactStruct>? contacts,
) =>
    contacts?.map((e) => getContactFirestoreData(e, true)).toList() ?? [];
