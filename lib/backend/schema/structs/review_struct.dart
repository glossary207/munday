// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class ReviewStruct extends FFSupabaseStruct {
  ReviewStruct({
    String? profilePhoto,
    String? comment,
    int? rate,
    DateTime? dateupdate,
    String? nameuser,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _profilePhoto = profilePhoto,
        _comment = comment,
        _rate = rate,
        _dateupdate = dateupdate,
        _nameuser = nameuser,
        super(supabaseUtilData);

  // "ProfilePhoto" field.
  String? _profilePhoto;
  String get profilePhoto => _profilePhoto ?? '';
  set profilePhoto(String? val) => _profilePhoto = val;

  bool hasProfilePhoto() => _profilePhoto != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "rate" field.
  int? _rate;
  int get rate => _rate ?? 0;
  set rate(int? val) => _rate = val;

  void incrementRate(int amount) => rate = rate + amount;

  bool hasRate() => _rate != null;

  // "dateupdate" field.
  DateTime? _dateupdate;
  DateTime? get dateupdate => _dateupdate;
  set dateupdate(DateTime? val) => _dateupdate = val;

  bool hasDateupdate() => _dateupdate != null;

  // "nameuser" field.
  String? _nameuser;
  String get nameuser => _nameuser ?? '';
  set nameuser(String? val) => _nameuser = val;

  bool hasNameuser() => _nameuser != null;

  static ReviewStruct fromMap(Map<String, dynamic> data) => ReviewStruct(
        profilePhoto: data['ProfilePhoto'] as String?,
        comment: data['comment'] as String?,
        rate: castToType<int>(data['rate']),
        dateupdate: data['dateupdate'] as DateTime?,
        nameuser: data['nameuser'] as String?,
      );

  static ReviewStruct? maybeFromMap(dynamic data) =>
      data is Map ? ReviewStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'ProfilePhoto': _profilePhoto,
        'comment': _comment,
        'rate': _rate,
        'dateupdate': _dateupdate,
        'nameuser': _nameuser,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ProfilePhoto': serializeParam(
          _profilePhoto,
          ParamType.String,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'rate': serializeParam(
          _rate,
          ParamType.int,
        ),
        'dateupdate': serializeParam(
          _dateupdate,
          ParamType.DateTime,
        ),
        'nameuser': serializeParam(
          _nameuser,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReviewStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReviewStruct(
        profilePhoto: deserializeParam(
          data['ProfilePhoto'],
          ParamType.String,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        rate: deserializeParam(
          data['rate'],
          ParamType.int,
          false,
        ),
        dateupdate: deserializeParam(
          data['dateupdate'],
          ParamType.DateTime,
          false,
        ),
        nameuser: deserializeParam(
          data['nameuser'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReviewStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReviewStruct &&
        profilePhoto == other.profilePhoto &&
        comment == other.comment &&
        rate == other.rate &&
        dateupdate == other.dateupdate &&
        nameuser == other.nameuser;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([profilePhoto, comment, rate, dateupdate, nameuser]);
}

ReviewStruct createReviewStruct({
  String? profilePhoto,
  String? comment,
  int? rate,
  DateTime? dateupdate,
  String? nameuser,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReviewStruct(
      profilePhoto: profilePhoto,
      comment: comment,
      rate: rate,
      dateupdate: dateupdate,
      nameuser: nameuser,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReviewStruct? updateReviewStruct(
  ReviewStruct? review, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    review
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReviewStructData(
  Map<String, dynamic> supabaseData,
  ReviewStruct? review,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (review == null) {
    return;
  }
  if (review.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && review.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final reviewData = getReviewFirestoreData(review, forFieldValue);
  final nestedData = reviewData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = review.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReviewFirestoreData(
  ReviewStruct? review, [
  bool forFieldValue = false,
]) {
  if (review == null) {
    return {};
  }
  final supabaseData = mapToSupabase(review.toMap());

  // Add any Firestore field values
  review.supabaseUtilData.fieldValues.forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getReviewListFirestoreData(
  List<ReviewStruct>? reviews,
) =>
    reviews?.map((e) => getReviewFirestoreData(e, true)).toList() ?? [];
