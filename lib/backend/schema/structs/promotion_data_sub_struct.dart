// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PromotionDataSubStruct extends FFSupabaseStruct {
  PromotionDataSubStruct({
    String? photo,
    DateTime? dateStart,
    DateTime? dateEnd,
    List<String>? day,
    bool? mon,
    bool? tue,
    bool? wed,
    bool? thu,
    bool? fri,
    bool? sat,
    bool? sun,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _photo = photo,
        _dateStart = dateStart,
        _dateEnd = dateEnd,
        _day = day,
        _mon = mon,
        _tue = tue,
        _wed = wed,
        _thu = thu,
        _fri = fri,
        _sat = sat,
        _sun = sun,
        super(supabaseUtilData);

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  set photo(String? val) => _photo = val;

  bool hasPhoto() => _photo != null;

  // "DateStart" field.
  DateTime? _dateStart;
  DateTime? get dateStart => _dateStart;
  set dateStart(DateTime? val) => _dateStart = val;

  bool hasDateStart() => _dateStart != null;

  // "DateEnd" field.
  DateTime? _dateEnd;
  DateTime? get dateEnd => _dateEnd;
  set dateEnd(DateTime? val) => _dateEnd = val;

  bool hasDateEnd() => _dateEnd != null;

  // "Day" field.
  List<String>? _day;
  List<String> get day => _day ?? const [];
  set day(List<String>? val) => _day = val;

  void updateDay(Function(List<String>) updateFn) {
    updateFn(_day ??= []);
  }

  bool hasDay() => _day != null;

  // "Mon" field.
  bool? _mon;
  bool get mon => _mon ?? false;
  set mon(bool? val) => _mon = val;

  bool hasMon() => _mon != null;

  // "Tue" field.
  bool? _tue;
  bool get tue => _tue ?? false;
  set tue(bool? val) => _tue = val;

  bool hasTue() => _tue != null;

  // "Wed" field.
  bool? _wed;
  bool get wed => _wed ?? false;
  set wed(bool? val) => _wed = val;

  bool hasWed() => _wed != null;

  // "Thu" field.
  bool? _thu;
  bool get thu => _thu ?? false;
  set thu(bool? val) => _thu = val;

  bool hasThu() => _thu != null;

  // "Fri" field.
  bool? _fri;
  bool get fri => _fri ?? false;
  set fri(bool? val) => _fri = val;

  bool hasFri() => _fri != null;

  // "Sat" field.
  bool? _sat;
  bool get sat => _sat ?? false;
  set sat(bool? val) => _sat = val;

  bool hasSat() => _sat != null;

  // "Sun" field.
  bool? _sun;
  bool get sun => _sun ?? false;
  set sun(bool? val) => _sun = val;

  bool hasSun() => _sun != null;

  static PromotionDataSubStruct fromMap(Map<String, dynamic> data) =>
      PromotionDataSubStruct(
        photo: data['photo'] as String?,
        dateStart: data['DateStart'] as DateTime?,
        dateEnd: data['DateEnd'] as DateTime?,
        day: getDataList(data['Day']),
        mon: data['Mon'] as bool?,
        tue: data['Tue'] as bool?,
        wed: data['Wed'] as bool?,
        thu: data['Thu'] as bool?,
        fri: data['Fri'] as bool?,
        sat: data['Sat'] as bool?,
        sun: data['Sun'] as bool?,
      );

  static PromotionDataSubStruct? maybeFromMap(dynamic data) => data is Map
      ? PromotionDataSubStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'photo': _photo,
        'DateStart': _dateStart,
        'DateEnd': _dateEnd,
        'Day': _day,
        'Mon': _mon,
        'Tue': _tue,
        'Wed': _wed,
        'Thu': _thu,
        'Fri': _fri,
        'Sat': _sat,
        'Sun': _sun,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'photo': serializeParam(
          _photo,
          ParamType.String,
        ),
        'DateStart': serializeParam(
          _dateStart,
          ParamType.DateTime,
        ),
        'DateEnd': serializeParam(
          _dateEnd,
          ParamType.DateTime,
        ),
        'Day': serializeParam(
          _day,
          ParamType.String,
          isList: true,
        ),
        'Mon': serializeParam(
          _mon,
          ParamType.bool,
        ),
        'Tue': serializeParam(
          _tue,
          ParamType.bool,
        ),
        'Wed': serializeParam(
          _wed,
          ParamType.bool,
        ),
        'Thu': serializeParam(
          _thu,
          ParamType.bool,
        ),
        'Fri': serializeParam(
          _fri,
          ParamType.bool,
        ),
        'Sat': serializeParam(
          _sat,
          ParamType.bool,
        ),
        'Sun': serializeParam(
          _sun,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PromotionDataSubStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PromotionDataSubStruct(
        photo: deserializeParam(
          data['photo'],
          ParamType.String,
          false,
        ),
        dateStart: deserializeParam(
          data['DateStart'],
          ParamType.DateTime,
          false,
        ),
        dateEnd: deserializeParam(
          data['DateEnd'],
          ParamType.DateTime,
          false,
        ),
        day: deserializeParam<String>(
          data['Day'],
          ParamType.String,
          true,
        ),
        mon: deserializeParam(
          data['Mon'],
          ParamType.bool,
          false,
        ),
        tue: deserializeParam(
          data['Tue'],
          ParamType.bool,
          false,
        ),
        wed: deserializeParam(
          data['Wed'],
          ParamType.bool,
          false,
        ),
        thu: deserializeParam(
          data['Thu'],
          ParamType.bool,
          false,
        ),
        fri: deserializeParam(
          data['Fri'],
          ParamType.bool,
          false,
        ),
        sat: deserializeParam(
          data['Sat'],
          ParamType.bool,
          false,
        ),
        sun: deserializeParam(
          data['Sun'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PromotionDataSubStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PromotionDataSubStruct &&
        photo == other.photo &&
        dateStart == other.dateStart &&
        dateEnd == other.dateEnd &&
        listEquality.equals(day, other.day) &&
        mon == other.mon &&
        tue == other.tue &&
        wed == other.wed &&
        thu == other.thu &&
        fri == other.fri &&
        sat == other.sat &&
        sun == other.sun;
  }

  @override
  int get hashCode => ListEquality().hash(
      [photo, dateStart, dateEnd, day, mon, tue, wed, thu, fri, sat, sun]);
}

PromotionDataSubStruct createPromotionDataSubStruct({
  String? photo,
  DateTime? dateStart,
  DateTime? dateEnd,
  bool? mon,
  bool? tue,
  bool? wed,
  bool? thu,
  bool? fri,
  bool? sat,
  bool? sun,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PromotionDataSubStruct(
      photo: photo,
      dateStart: dateStart,
      dateEnd: dateEnd,
      mon: mon,
      tue: tue,
      wed: wed,
      thu: thu,
      fri: fri,
      sat: sat,
      sun: sun,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PromotionDataSubStruct? updatePromotionDataSubStruct(
  PromotionDataSubStruct? promotionDataSub, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    promotionDataSub
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPromotionDataSubStructData(
  Map<String, dynamic> supabaseData,
  PromotionDataSubStruct? promotionDataSub,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (promotionDataSub == null) {
    return;
  }
  if (promotionDataSub.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && promotionDataSub.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final promotionDataSubData =
      getPromotionDataSubFirestoreData(promotionDataSub, forFieldValue);
  final nestedData =
      promotionDataSubData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = promotionDataSub.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPromotionDataSubFirestoreData(
  PromotionDataSubStruct? promotionDataSub, [
  bool forFieldValue = false,
]) {
  if (promotionDataSub == null) {
    return {};
  }
  final supabaseData = mapToSupabase(promotionDataSub.toMap());

  // Add any Firestore field values
  promotionDataSub.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getPromotionDataSubListFirestoreData(
  List<PromotionDataSubStruct>? promotionDataSubs,
) =>
    promotionDataSubs
        ?.map((e) => getPromotionDataSubFirestoreData(e, true))
        .toList() ??
    [];
