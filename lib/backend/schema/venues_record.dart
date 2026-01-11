import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VenuesRecord extends SupabaseRecord {
  VenuesRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name_Venuse" field.
  String? _nameVenuse;
  String get nameVenuse => _nameVenuse ?? '';
  bool hasNameVenuse() => _nameVenuse != null;

  // "BG" field.
  String? _bg;
  String get bg => _bg ?? '';
  bool hasBg() => _bg != null;

  // "capacity" field.
  int? _capacity;
  int get capacity => _capacity ?? 0;
  bool hasCapacity() => _capacity != null;

  // "max_capacity" field.
  int? _maxCapacity;
  int get maxCapacity => _maxCapacity ?? 0;
  bool hasMaxCapacity() => _maxCapacity != null;

  // "Position" field.
  LatLng? _position;
  LatLng? get position => _position;
  bool hasPosition() => _position != null;

  // "Open_Close_time" field.
  String? _openCloseTime;
  String get openCloseTime => _openCloseTime ?? '';
  bool hasOpenCloseTime() => _openCloseTime != null;

  // "styleVenuse" field.
  List<String>? _styleVenuse;
  List<String> get styleVenuse => _styleVenuse ?? const [];
  bool hasStyleVenuse() => _styleVenuse != null;

  // "StyleMusic" field.
  List<String>? _styleMusic;
  List<String> get styleMusic => _styleMusic ?? const [];
  bool hasStyleMusic() => _styleMusic != null;

  // "Logo" field.
  String? _logo;
  String get logo => _logo ?? '';
  bool hasLogo() => _logo != null;

  // "Events" field.
  List<SupabaseDocRef>? _events;
  List<SupabaseDocRef> get events => _events ?? const [];
  bool hasEvents() => _events != null;

  // "DateEvents" field.
  List<DateTime>? _dateEvents;
  List<DateTime> get dateEvents => _dateEvents ?? const [];
  bool hasDateEvents() => _dateEvents != null;

  // "promotion" field.
  List<String>? _promotion;
  List<String> get promotion => _promotion ?? const [];
  bool hasPromotion() => _promotion != null;

  // "photos" field.
  List<String>? _photos;
  List<String> get photos => _photos ?? const [];
  bool hasPhotos() => _photos != null;

  // "LinkContact" field.
  ContactStruct? _linkContact;
  ContactStruct get linkContact => _linkContact ?? ContactStruct();
  bool hasLinkContact() => _linkContact != null;

  // "user_review" field.
  List<ReviewStruct>? _userReview;
  List<ReviewStruct> get userReview => _userReview ?? const [];
  bool hasUserReview() => _userReview != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "RefUserInVenues" field.
  SupabaseDocRef? _refUserInVenues;
  SupabaseDocRef? get refUserInVenues => _refUserInVenues;
  bool hasRefUserInVenues() => _refUserInVenues != null;

  // "Video" field.
  List<String>? _video;
  List<String> get video => _video ?? const [];
  bool hasVideo() => _video != null;

  // "listpromotion" field.
  List<PromotionDataSubStruct>? _listpromotion;
  List<PromotionDataSubStruct> get listpromotion => _listpromotion ?? const [];
  bool hasListpromotion() => _listpromotion != null;

  // "table_id" field.
  List<String>? _tableId;
  List<String> get tableId => _tableId ?? const [];
  bool hasTableId() => _tableId != null;

  // "id_liveChat" field.
  SupabaseDocRef? _idLiveChat;
  SupabaseDocRef? get idLiveChat => _idLiveChat;
  bool hasIdLiveChat() => _idLiveChat != null;

  void _initializeFields() {
    _nameVenuse = snapshotData['Name_Venuse'] as String?;
    _bg = snapshotData['BG'] as String?;
    _capacity = castToType<int>(snapshotData['capacity']);
    _maxCapacity = castToType<int>(snapshotData['max_capacity']);
    _position = snapshotData['Position'] as LatLng?;
    _openCloseTime = snapshotData['Open_Close_time'] as String?;
    _styleVenuse = getDataList(snapshotData['styleVenuse']);
    _styleMusic = getDataList(snapshotData['StyleMusic']);
    _logo = snapshotData['Logo'] as String?;
    _events = getDataList(snapshotData['Events']);
    _dateEvents = getDataList(snapshotData['DateEvents']);
    _promotion = getDataList(snapshotData['promotion']);
    _photos = getDataList(snapshotData['photos']);
    _linkContact = snapshotData['LinkContact'] is ContactStruct
        ? snapshotData['LinkContact']
        : ContactStruct.maybeFromMap(snapshotData['LinkContact']);
    _userReview = getStructList(
      snapshotData['user_review'],
      ReviewStruct.fromMap,
    );
    _rating = castToType<double>(snapshotData['rating']);
    _refUserInVenues = snapshotData['RefUserInVenues'] as SupabaseDocRef?;
    _video = getDataList(snapshotData['Video']);
    _listpromotion = getStructList(
      snapshotData['listpromotion'],
      PromotionDataSubStruct.fromMap,
    );
    _tableId = getDataList(snapshotData['table_id']);
    _idLiveChat = snapshotData['id_liveChat'] as SupabaseDocRef?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Venues');

  static Stream<VenuesRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => VenuesRecord.fromSnapshot(s));

  static Future<VenuesRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => VenuesRecord.fromSnapshot(s));

  static VenuesRecord fromSnapshot(SupabaseDocSnapshot snapshot) => VenuesRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static VenuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      VenuesRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'VenuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VenuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVenuesRecordData({
  String? nameVenuse,
  String? bg,
  int? capacity,
  int? maxCapacity,
  LatLng? position,
  String? openCloseTime,
  String? logo,
  ContactStruct? linkContact,
  double? rating,
  SupabaseDocRef? refUserInVenues,
  SupabaseDocRef? idLiveChat,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'Name_Venuse': nameVenuse,
      'BG': bg,
      'capacity': capacity,
      'max_capacity': maxCapacity,
      'Position': position,
      'Open_Close_time': openCloseTime,
      'Logo': logo,
      'LinkContact': ContactStruct().toMap(),
      'rating': rating,
      'RefUserInVenues': refUserInVenues,
      'id_liveChat': idLiveChat,
    }.withoutNulls,
  );

  // Handle nested data for "LinkContact" field.
  addContactStructData(supabaseData, linkContact, 'LinkContact');

  return supabaseData;
}

class VenuesRecordDocumentEquality implements Equality<VenuesRecord> {
  const VenuesRecordDocumentEquality();

  @override
  bool equals(VenuesRecord? e1, VenuesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nameVenuse == e2?.nameVenuse &&
        e1?.bg == e2?.bg &&
        e1?.capacity == e2?.capacity &&
        e1?.maxCapacity == e2?.maxCapacity &&
        e1?.position == e2?.position &&
        e1?.openCloseTime == e2?.openCloseTime &&
        listEquality.equals(e1?.styleVenuse, e2?.styleVenuse) &&
        listEquality.equals(e1?.styleMusic, e2?.styleMusic) &&
        e1?.logo == e2?.logo &&
        listEquality.equals(e1?.events, e2?.events) &&
        listEquality.equals(e1?.dateEvents, e2?.dateEvents) &&
        listEquality.equals(e1?.promotion, e2?.promotion) &&
        listEquality.equals(e1?.photos, e2?.photos) &&
        e1?.linkContact == e2?.linkContact &&
        listEquality.equals(e1?.userReview, e2?.userReview) &&
        e1?.rating == e2?.rating &&
        e1?.refUserInVenues == e2?.refUserInVenues &&
        listEquality.equals(e1?.video, e2?.video) &&
        listEquality.equals(e1?.listpromotion, e2?.listpromotion) &&
        listEquality.equals(e1?.tableId, e2?.tableId) &&
        e1?.idLiveChat == e2?.idLiveChat;
  }

  @override
  int hash(VenuesRecord? e) => const ListEquality().hash([
        e?.nameVenuse,
        e?.bg,
        e?.capacity,
        e?.maxCapacity,
        e?.position,
        e?.openCloseTime,
        e?.styleVenuse,
        e?.styleMusic,
        e?.logo,
        e?.events,
        e?.dateEvents,
        e?.promotion,
        e?.photos,
        e?.linkContact,
        e?.userReview,
        e?.rating,
        e?.refUserInVenues,
        e?.video,
        e?.listpromotion,
        e?.tableId,
        e?.idLiveChat
      ]);

  @override
  bool isValidKey(Object? o) => o is VenuesRecord;
}
