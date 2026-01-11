// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataVenuesStruct extends FFSupabaseStruct {
  DataVenuesStruct({
    String? nameVenuse,
    String? bg,
    int? capacity,
    int? maxCapacity,
    LatLng? position,
    String? openCloseTime,
    List<String>? styleVenuse,
    List<String>? styleMusic,
    double? distance,
    String? logo,
    SupabaseDocRef? iDVenuse,
    List<SupabaseDocRef>? eventID,
    double? rating,
    List<String>? promotion,
    List<PromotionDataSubStruct>? listpromotion,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _nameVenuse = nameVenuse,
        _bg = bg,
        _capacity = capacity,
        _maxCapacity = maxCapacity,
        _position = position,
        _openCloseTime = openCloseTime,
        _styleVenuse = styleVenuse,
        _styleMusic = styleMusic,
        _distance = distance,
        _logo = logo,
        _iDVenuse = iDVenuse,
        _eventID = eventID,
        _rating = rating,
        _promotion = promotion,
        _listpromotion = listpromotion,
        super(supabaseUtilData);

  // "Name_Venuse" field.
  String? _nameVenuse;
  String get nameVenuse => _nameVenuse ?? '';
  set nameVenuse(String? val) => _nameVenuse = val;

  bool hasNameVenuse() => _nameVenuse != null;

  // "BG" field.
  String? _bg;
  String get bg => _bg ?? '';
  set bg(String? val) => _bg = val;

  bool hasBg() => _bg != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  set capacity(int? val) => _capacity = val;

  void incrementCapacity(int amount) => capacity = capacity + amount;

  bool hasCapacity() => _capacity != null;

  // "max_capacity" field.
  int? _maxCapacity;
  int get maxCapacity => _maxCapacity ?? 0;
  set maxCapacity(int? val) => _maxCapacity = val;

  void incrementMaxCapacity(int amount) => maxCapacity = maxCapacity + amount;

  bool hasMaxCapacity() => _maxCapacity != null;

  // "Position" field.
  LatLng? _position;
  LatLng? get position => _position;
  set position(LatLng? val) => _position = val;

  bool hasPosition() => _position != null;

  // "Open_Close_time" field.
  String? _openCloseTime;
  String get openCloseTime => _openCloseTime ?? '';
  set openCloseTime(String? val) => _openCloseTime = val;

  bool hasOpenCloseTime() => _openCloseTime != null;

  // "styleVenuse" field.
  List<String>? _styleVenuse;
  List<String> get styleVenuse => _styleVenuse ?? const [];
  set styleVenuse(List<String>? val) => _styleVenuse = val;

  void updateStyleVenuse(Function(List<String>) updateFn) {
    updateFn(_styleVenuse ??= []);
  }

  bool hasStyleVenuse() => _styleVenuse != null;

  // "styleMusic" field.
  List<String>? _styleMusic;
  List<String> get styleMusic => _styleMusic ?? const [];
  set styleMusic(List<String>? val) => _styleMusic = val;

  void updateStyleMusic(Function(List<String>) updateFn) {
    updateFn(_styleMusic ??= []);
  }

  bool hasStyleMusic() => _styleMusic != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "Logo" field.
  String? _logo;
  String get logo => _logo ?? '';
  set logo(String? val) => _logo = val;

  bool hasLogo() => _logo != null;

  // "iDVenuse" field.
  SupabaseDocRef? _iDVenuse;
  SupabaseDocRef? get iDVenuse => _iDVenuse;
  set iDVenuse(SupabaseDocRef? val) => _iDVenuse = val;

  bool hasIDVenuse() => _iDVenuse != null;

  // "EventID" field.
  List<SupabaseDocRef>? _eventID;
  List<SupabaseDocRef> get eventID => _eventID ?? const [];
  set eventID(List<SupabaseDocRef>? val) => _eventID = val;

  void updateEventID(Function(List<SupabaseDocRef>) updateFn) {
    updateFn(_eventID ??= []);
  }

  bool hasEventID() => _eventID != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  set rating(double? val) => _rating = val;

  void incrementRating(double amount) => rating = rating + amount;

  bool hasRating() => _rating != null;

  // "promotion" field.
  List<String>? _promotion;
  List<String> get promotion => _promotion ?? const [];
  set promotion(List<String>? val) => _promotion = val;

  void updatePromotion(Function(List<String>) updateFn) {
    updateFn(_promotion ??= []);
  }

  bool hasPromotion() => _promotion != null;

  // "listpromotion" field.
  List<PromotionDataSubStruct>? _listpromotion;
  List<PromotionDataSubStruct> get listpromotion => _listpromotion ?? const [];
  set listpromotion(List<PromotionDataSubStruct>? val) => _listpromotion = val;

  void updateListpromotion(Function(List<PromotionDataSubStruct>) updateFn) {
    updateFn(_listpromotion ??= []);
  }

  bool hasListpromotion() => _listpromotion != null;

  static DataVenuesStruct fromMap(Map<String, dynamic> data) =>
      DataVenuesStruct(
        nameVenuse: data['Name_Venuse'] as String?,
        bg: data['BG'] as String?,
        capacity: castToType<int>(data['capacity']),
        maxCapacity: castToType<int>(data['max_capacity']),
        position: data['Position'] as LatLng?,
        openCloseTime: data['Open_Close_time'] as String?,
        styleVenuse: getDataList(data['styleVenuse']),
        styleMusic: getDataList(data['styleMusic']),
        distance: castToType<double>(data['distance']),
        logo: data['Logo'] as String?,
        iDVenuse: data['iDVenuse'] as SupabaseDocRef?,
        eventID: getDataList(data['EventID']),
        rating: castToType<double>(data['rating']),
        promotion: getDataList(data['promotion']),
        listpromotion: getStructList(
          data['listpromotion'],
          PromotionDataSubStruct.fromMap,
        ),
      );

  static DataVenuesStruct? maybeFromMap(dynamic data) => data is Map
      ? DataVenuesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Name_Venuse': _nameVenuse,
        'BG': _bg,
        'capacity': _capacity,
        'max_capacity': _maxCapacity,
        'Position': _position,
        'Open_Close_time': _openCloseTime,
        'styleVenuse': _styleVenuse,
        'styleMusic': _styleMusic,
        'distance': _distance,
        'Logo': _logo,
        'iDVenuse': _iDVenuse,
        'EventID': _eventID,
        'rating': _rating,
        'promotion': _promotion,
        'listpromotion': _listpromotion?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name_Venuse': serializeParam(
          _nameVenuse,
          ParamType.String,
        ),
        'BG': serializeParam(
          _bg,
          ParamType.String,
        ),
        'capacity': serializeParam(
          _capacity,
          ParamType.int,
        ),
        'max_capacity': serializeParam(
          _maxCapacity,
          ParamType.int,
        ),
        'Position': serializeParam(
          _position,
          ParamType.LatLng,
        ),
        'Open_Close_time': serializeParam(
          _openCloseTime,
          ParamType.String,
        ),
        'styleVenuse': serializeParam(
          _styleVenuse,
          ParamType.String,
          isList: true,
        ),
        'styleMusic': serializeParam(
          _styleMusic,
          ParamType.String,
          isList: true,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'Logo': serializeParam(
          _logo,
          ParamType.String,
        ),
        'iDVenuse': serializeParam(
          _iDVenuse,
          ParamType.SupabaseDocRef,
        ),
        'EventID': serializeParam(
          _eventID,
          ParamType.SupabaseDocRef,
          isList: true,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.double,
        ),
        'promotion': serializeParam(
          _promotion,
          ParamType.String,
          isList: true,
        ),
        'listpromotion': serializeParam(
          _listpromotion,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static DataVenuesStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataVenuesStruct(
        nameVenuse: deserializeParam(
          data['Name_Venuse'],
          ParamType.String,
          false,
        ),
        bg: deserializeParam(
          data['BG'],
          ParamType.String,
          false,
        ),
        capacity: deserializeParam(
          data['capacity'],
          ParamType.int,
          false,
        ),
        maxCapacity: deserializeParam(
          data['max_capacity'],
          ParamType.int,
          false,
        ),
        position: deserializeParam(
          data['Position'],
          ParamType.LatLng,
          false,
        ),
        openCloseTime: deserializeParam(
          data['Open_Close_time'],
          ParamType.String,
          false,
        ),
        styleVenuse: deserializeParam<String>(
          data['styleVenuse'],
          ParamType.String,
          true,
        ),
        styleMusic: deserializeParam<String>(
          data['styleMusic'],
          ParamType.String,
          true,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        logo: deserializeParam(
          data['Logo'],
          ParamType.String,
          false,
        ),
        iDVenuse: deserializeParam(
          data['iDVenuse'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['Venues'],
        ),
        eventID: deserializeParam<SupabaseDocRef>(
          data['EventID'],
          ParamType.SupabaseDocRef,
          true,
          collectionNamePath: ['EVENTS'],
        ),
        rating: deserializeParam(
          data['rating'],
          ParamType.double,
          false,
        ),
        promotion: deserializeParam<String>(
          data['promotion'],
          ParamType.String,
          true,
        ),
        listpromotion: deserializeStructParam<PromotionDataSubStruct>(
          data['listpromotion'],
          ParamType.DataStruct,
          true,
          structBuilder: PromotionDataSubStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DataVenuesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DataVenuesStruct &&
        nameVenuse == other.nameVenuse &&
        bg == other.bg &&
        capacity == other.capacity &&
        maxCapacity == other.maxCapacity &&
        position == other.position &&
        openCloseTime == other.openCloseTime &&
        listEquality.equals(styleVenuse, other.styleVenuse) &&
        listEquality.equals(styleMusic, other.styleMusic) &&
        distance == other.distance &&
        logo == other.logo &&
        iDVenuse == other.iDVenuse &&
        listEquality.equals(eventID, other.eventID) &&
        rating == other.rating &&
        listEquality.equals(promotion, other.promotion) &&
        listEquality.equals(listpromotion, other.listpromotion);
  }

  @override
  int get hashCode => ListEquality().hash([
        nameVenuse,
        bg,
        capacity,
        maxCapacity,
        position,
        openCloseTime,
        styleVenuse,
        styleMusic,
        distance,
        logo,
        iDVenuse,
        eventID,
        rating,
        promotion,
        listpromotion
      ]);
}

DataVenuesStruct createDataVenuesStruct({
  String? nameVenuse,
  String? bg,
  int? capacity,
  int? maxCapacity,
  LatLng? position,
  String? openCloseTime,
  double? distance,
  String? logo,
  SupabaseDocRef? iDVenuse,
  double? rating,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataVenuesStruct(
      nameVenuse: nameVenuse,
      bg: bg,
      capacity: capacity,
      maxCapacity: maxCapacity,
      position: position,
      openCloseTime: openCloseTime,
      distance: distance,
      logo: logo,
      iDVenuse: iDVenuse,
      rating: rating,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataVenuesStruct? updateDataVenuesStruct(
  DataVenuesStruct? dataVenues, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataVenues
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataVenuesStructData(
  Map<String, dynamic> supabaseData,
  DataVenuesStruct? dataVenues,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (dataVenues == null) {
    return;
  }
  if (dataVenues.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataVenues.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final dataVenuesData = getDataVenuesFirestoreData(dataVenues, forFieldValue);
  final nestedData = dataVenuesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataVenues.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataVenuesFirestoreData(
  DataVenuesStruct? dataVenues, [
  bool forFieldValue = false,
]) {
  if (dataVenues == null) {
    return {};
  }
  final supabaseData = mapToSupabase(dataVenues.toMap());

  // Add any Firestore field values
  dataVenues.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDataVenuesListFirestoreData(
  List<DataVenuesStruct>? dataVenuess,
) =>
    dataVenuess?.map((e) => getDataVenuesFirestoreData(e, true)).toList() ?? [];
