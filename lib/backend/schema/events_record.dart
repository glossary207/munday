import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends SupabaseRecord {
  EventsRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name_store" field.
  String? _nameStore;
  String get nameStore => _nameStore ?? '';
  bool hasNameStore() => _nameStore != null;

  // "Name_artise" field.
  List<String>? _nameArtise;
  List<String> get nameArtise => _nameArtise ?? const [];
  bool hasNameArtise() => _nameArtise != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "Date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "Poster" field.
  String? _poster;
  String get poster => _poster ?? '';
  bool hasPoster() => _poster != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  bool hasCapacity() => _capacity != null;

  // "max_capacity" field.
  int? _maxCapacity;
  int get maxCapacity => _maxCapacity ?? 0;
  bool hasMaxCapacity() => _maxCapacity != null;

  // "musicstyle" field.
  String? _musicstyle;
  String get musicstyle => _musicstyle ?? '';
  bool hasMusicstyle() => _musicstyle != null;

  // "ID_Venues" field.
  SupabaseDocRef? _iDVenues;
  SupabaseDocRef? get iDVenues => _iDVenues;
  bool hasIDVenues() => _iDVenues != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  bool hasDetail() => _detail != null;

  // "styleVenues" field.
  List<String>? _styleVenues;
  List<String> get styleVenues => _styleVenues ?? const [];
  bool hasStyleVenues() => _styleVenues != null;

  // "FREE" field.
  bool? _free;
  bool get free => _free ?? false;
  bool hasFree() => _free != null;

  // "PriceDetail" field.
  String? _priceDetail;
  String get priceDetail => _priceDetail ?? '';
  bool hasPriceDetail() => _priceDetail != null;

  void _initializeFields() {
    _nameStore = snapshotData['Name_store'] as String?;
    _nameArtise = getDataList(snapshotData['Name_artise']);
    _location = snapshotData['location'] as LatLng?;
    _date = snapshotData['Date'] as DateTime?;
    _poster = snapshotData['Poster'] as String?;
    _capacity = castToType<int>(snapshotData['capacity']);
    _maxCapacity = castToType<int>(snapshotData['max_capacity']);
    _musicstyle = snapshotData['musicstyle'] as String?;
    _iDVenues = snapshotData['ID_Venues'] as SupabaseDocRef?;
    _detail = snapshotData['detail'] as String?;
    _styleVenues = getDataList(snapshotData['styleVenues']);
    _free = snapshotData['FREE'] as bool?;
    _priceDetail = snapshotData['PriceDetail'] as String?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('EVENTS');

  static Stream<EventsRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(SupabaseDocSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      EventsRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? nameStore,
  LatLng? location,
  DateTime? date,
  String? poster,
  int? capacity,
  int? maxCapacity,
  String? musicstyle,
  SupabaseDocRef? iDVenues,
  String? detail,
  bool? free,
  String? priceDetail,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'Name_store': nameStore,
      'location': location,
      'Date': date,
      'Poster': poster,
      'capacity': capacity,
      'max_capacity': maxCapacity,
      'musicstyle': musicstyle,
      'ID_Venues': iDVenues,
      'detail': detail,
      'FREE': free,
      'PriceDetail': priceDetail,
    }.withoutNulls,
  );

  return supabaseData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nameStore == e2?.nameStore &&
        listEquality.equals(e1?.nameArtise, e2?.nameArtise) &&
        e1?.location == e2?.location &&
        e1?.date == e2?.date &&
        e1?.poster == e2?.poster &&
        e1?.capacity == e2?.capacity &&
        e1?.maxCapacity == e2?.maxCapacity &&
        e1?.musicstyle == e2?.musicstyle &&
        e1?.iDVenues == e2?.iDVenues &&
        e1?.detail == e2?.detail &&
        listEquality.equals(e1?.styleVenues, e2?.styleVenues) &&
        e1?.free == e2?.free &&
        e1?.priceDetail == e2?.priceDetail;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.nameStore,
        e?.nameArtise,
        e?.location,
        e?.date,
        e?.poster,
        e?.capacity,
        e?.maxCapacity,
        e?.musicstyle,
        e?.iDVenues,
        e?.detail,
        e?.styleVenues,
        e?.free,
        e?.priceDetail
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
