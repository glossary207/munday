// ignore_for_file: unnecessary_getters_setters

import '/backend/supabase/supabase_shim.dart';

import '/backend/schema/util/supabase_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataEventsStruct extends FFSupabaseStruct {
  DataEventsStruct({
    List<String>? nameArtise,
    String? nameStore,
    String? poster,
    int? capacity,
    double? distance,
    int? maxCapacity,
    String? musicstyle,
    DateTime? date,
    SupabaseDocRef? docRef,
    LatLng? position,
    SupabaseDocRef? iDVenuse,
    bool? free,
    String? priceDetail,
    SupabaseUtilData supabaseUtilData = const SupabaseUtilData(),
  })  : _nameArtise = nameArtise,
        _nameStore = nameStore,
        _poster = poster,
        _capacity = capacity,
        _distance = distance,
        _maxCapacity = maxCapacity,
        _musicstyle = musicstyle,
        _date = date,
        _docRef = docRef,
        _position = position,
        _iDVenuse = iDVenuse,
        _free = free,
        _priceDetail = priceDetail,
        super(supabaseUtilData);

  // "Name_artise" field.
  List<String>? _nameArtise;
  List<String> get nameArtise => _nameArtise ?? const [];
  set nameArtise(List<String>? val) => _nameArtise = val;

  void updateNameArtise(Function(List<String>) updateFn) {
    updateFn(_nameArtise ??= []);
  }

  bool hasNameArtise() => _nameArtise != null;

  // "Name_store" field.
  String? _nameStore;
  String get nameStore => _nameStore ?? '';
  set nameStore(String? val) => _nameStore = val;

  bool hasNameStore() => _nameStore != null;

  // "Poster" field.
  String? _poster;
  String get poster => _poster ?? '';
  set poster(String? val) => _poster = val;

  bool hasPoster() => _poster != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  set capacity(int? val) => _capacity = val;

  void incrementCapacity(int amount) => capacity = capacity + amount;

  bool hasCapacity() => _capacity != null;

  // "distance" field.
  double? _distance;
  double get distance => _distance ?? 0.0;
  set distance(double? val) => _distance = val;

  void incrementDistance(double amount) => distance = distance + amount;

  bool hasDistance() => _distance != null;

  // "max_capacity" field.
  int? _maxCapacity;
  int get maxCapacity => _maxCapacity ?? 0;
  set maxCapacity(int? val) => _maxCapacity = val;

  void incrementMaxCapacity(int amount) => maxCapacity = maxCapacity + amount;

  bool hasMaxCapacity() => _maxCapacity != null;

  // "musicstyle" field.
  String? _musicstyle;
  String get musicstyle => _musicstyle ?? '';
  set musicstyle(String? val) => _musicstyle = val;

  bool hasMusicstyle() => _musicstyle != null;

  // "Date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "doc_ref" field.
  SupabaseDocRef? _docRef;
  SupabaseDocRef? get docRef => _docRef;
  set docRef(SupabaseDocRef? val) => _docRef = val;

  bool hasDocRef() => _docRef != null;

  // "position" field.
  LatLng? _position;
  LatLng? get position => _position;
  set position(LatLng? val) => _position = val;

  bool hasPosition() => _position != null;

  // "iDVenuse" field.
  SupabaseDocRef? _iDVenuse;
  SupabaseDocRef? get iDVenuse => _iDVenuse;
  set iDVenuse(SupabaseDocRef? val) => _iDVenuse = val;

  bool hasIDVenuse() => _iDVenuse != null;

  // "FREE" field.
  bool? _free;
  bool get free => _free ?? false;
  set free(bool? val) => _free = val;

  bool hasFree() => _free != null;

  // "PriceDetail" field.
  String? _priceDetail;
  String get priceDetail => _priceDetail ?? '';
  set priceDetail(String? val) => _priceDetail = val;

  bool hasPriceDetail() => _priceDetail != null;

  static DataEventsStruct fromMap(Map<String, dynamic> data) =>
      DataEventsStruct(
        nameArtise: getDataList(data['Name_artise']),
        nameStore: data['Name_store'] as String?,
        poster: data['Poster'] as String?,
        capacity: castToType<int>(data['capacity']),
        distance: castToType<double>(data['distance']),
        maxCapacity: castToType<int>(data['max_capacity']),
        musicstyle: data['musicstyle'] as String?,
        date: data['Date'] as DateTime?,
        docRef: data['doc_ref'] as SupabaseDocRef?,
        position: data['position'] as LatLng?,
        iDVenuse: data['iDVenuse'] as SupabaseDocRef?,
        free: data['FREE'] as bool?,
        priceDetail: data['PriceDetail'] as String?,
      );

  static DataEventsStruct? maybeFromMap(dynamic data) => data is Map
      ? DataEventsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Name_artise': _nameArtise,
        'Name_store': _nameStore,
        'Poster': _poster,
        'capacity': _capacity,
        'distance': _distance,
        'max_capacity': _maxCapacity,
        'musicstyle': _musicstyle,
        'Date': _date,
        'doc_ref': _docRef,
        'position': _position,
        'iDVenuse': _iDVenuse,
        'FREE': _free,
        'PriceDetail': _priceDetail,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Name_artise': serializeParam(
          _nameArtise,
          ParamType.String,
          isList: true,
        ),
        'Name_store': serializeParam(
          _nameStore,
          ParamType.String,
        ),
        'Poster': serializeParam(
          _poster,
          ParamType.String,
        ),
        'capacity': serializeParam(
          _capacity,
          ParamType.int,
        ),
        'distance': serializeParam(
          _distance,
          ParamType.double,
        ),
        'max_capacity': serializeParam(
          _maxCapacity,
          ParamType.int,
        ),
        'musicstyle': serializeParam(
          _musicstyle,
          ParamType.String,
        ),
        'Date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'doc_ref': serializeParam(
          _docRef,
          ParamType.SupabaseDocRef,
        ),
        'position': serializeParam(
          _position,
          ParamType.LatLng,
        ),
        'iDVenuse': serializeParam(
          _iDVenuse,
          ParamType.SupabaseDocRef,
        ),
        'FREE': serializeParam(
          _free,
          ParamType.bool,
        ),
        'PriceDetail': serializeParam(
          _priceDetail,
          ParamType.String,
        ),
      }.withoutNulls;

  static DataEventsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataEventsStruct(
        nameArtise: deserializeParam<String>(
          data['Name_artise'],
          ParamType.String,
          true,
        ),
        nameStore: deserializeParam(
          data['Name_store'],
          ParamType.String,
          false,
        ),
        poster: deserializeParam(
          data['Poster'],
          ParamType.String,
          false,
        ),
        capacity: deserializeParam(
          data['capacity'],
          ParamType.int,
          false,
        ),
        distance: deserializeParam(
          data['distance'],
          ParamType.double,
          false,
        ),
        maxCapacity: deserializeParam(
          data['max_capacity'],
          ParamType.int,
          false,
        ),
        musicstyle: deserializeParam(
          data['musicstyle'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['Date'],
          ParamType.DateTime,
          false,
        ),
        docRef: deserializeParam(
          data['doc_ref'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['EVENTS'],
        ),
        position: deserializeParam(
          data['position'],
          ParamType.LatLng,
          false,
        ),
        iDVenuse: deserializeParam(
          data['iDVenuse'],
          ParamType.SupabaseDocRef,
          false,
          collectionNamePath: ['Venues'],
        ),
        free: deserializeParam(
          data['FREE'],
          ParamType.bool,
          false,
        ),
        priceDetail: deserializeParam(
          data['PriceDetail'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DataEventsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DataEventsStruct &&
        listEquality.equals(nameArtise, other.nameArtise) &&
        nameStore == other.nameStore &&
        poster == other.poster &&
        capacity == other.capacity &&
        distance == other.distance &&
        maxCapacity == other.maxCapacity &&
        musicstyle == other.musicstyle &&
        date == other.date &&
        docRef == other.docRef &&
        position == other.position &&
        iDVenuse == other.iDVenuse &&
        free == other.free &&
        priceDetail == other.priceDetail;
  }

  @override
  int get hashCode => ListEquality().hash([
        nameArtise,
        nameStore,
        poster,
        capacity,
        distance,
        maxCapacity,
        musicstyle,
        date,
        docRef,
        position,
        iDVenuse,
        free,
        priceDetail
      ]);
}

DataEventsStruct createDataEventsStruct({
  String? nameStore,
  String? poster,
  int? capacity,
  double? distance,
  int? maxCapacity,
  String? musicstyle,
  DateTime? date,
  SupabaseDocRef? docRef,
  LatLng? position,
  SupabaseDocRef? iDVenuse,
  bool? free,
  String? priceDetail,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataEventsStruct(
      nameStore: nameStore,
      poster: poster,
      capacity: capacity,
      distance: distance,
      maxCapacity: maxCapacity,
      musicstyle: musicstyle,
      date: date,
      docRef: docRef,
      position: position,
      iDVenuse: iDVenuse,
      free: free,
      priceDetail: priceDetail,
      supabaseUtilData: SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataEventsStruct? updateDataEventsStruct(
  DataEventsStruct? dataEvents, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataEvents
      ?..supabaseUtilData = SupabaseUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataEventsStructData(
  Map<String, dynamic> supabaseData,
  DataEventsStruct? dataEvents,
  String fieldName, [
  bool forFieldValue = false,
]) {
  supabaseData.remove(fieldName);
  if (dataEvents == null) {
    return;
  }
  if (dataEvents.supabaseUtilData.delete) {
    supabaseData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataEvents.supabaseUtilData.clearUnsetFields;
  if (clearFields) {
    supabaseData[fieldName] = <String, dynamic>{};
  }
  final dataEventsData = getDataEventsFirestoreData(dataEvents, forFieldValue);
  final nestedData = dataEventsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataEvents.supabaseUtilData.create || clearFields;
  supabaseData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataEventsFirestoreData(
  DataEventsStruct? dataEvents, [
  bool forFieldValue = false,
]) {
  if (dataEvents == null) {
    return {};
  }
  final supabaseData = mapToSupabase(dataEvents.toMap());

  // Add any Firestore field values
  dataEvents.supabaseUtilData.fieldValues
      .forEach((k, v) => supabaseData[k] = v);

  return forFieldValue ? mergeNestedFields(supabaseData) : supabaseData;
}

List<Map<String, dynamic>> getDataEventsListFirestoreData(
  List<DataEventsStruct>? dataEventss,
) =>
    dataEventss?.map((e) => getDataEventsFirestoreData(e, true)).toList() ?? [];
