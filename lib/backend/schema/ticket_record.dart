import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TicketRecord extends SupabaseRecord {
  TicketRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "NameEvent" field.
  String? _nameEvent;
  String get nameEvent => _nameEvent ?? '';
  bool hasNameEvent() => _nameEvent != null;

  // "EventOrNormal" field.
  bool? _eventOrNormal;
  bool get eventOrNormal => _eventOrNormal ?? false;
  bool hasEventOrNormal() => _eventOrNormal != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  bool hasPrice() => _price != null;

  // "zone" field.
  String? _zone;
  String get zone => _zone ?? '';
  bool hasZone() => _zone != null;

  // "SeatCode" field.
  String? _seatCode;
  String get seatCode => _seatCode ?? '';
  bool hasSeatCode() => _seatCode != null;

  // "BG" field.
  String? _bg;
  String get bg => _bg ?? '';
  bool hasBg() => _bg != null;

  // "Id_Venues" field.
  SupabaseDocRef? _idVenues;
  SupabaseDocRef? get idVenues => _idVenues;
  bool hasIdVenues() => _idVenues != null;

  // "scan_amont" field.
  int? _scanAmont;
  int get scanAmont => _scanAmont ?? 0;
  bool hasScanAmont() => _scanAmont != null;

  // "time_event" field.
  String? _timeEvent;
  String get timeEvent => _timeEvent ?? '';
  bool hasTimeEvent() => _timeEvent != null;

  // "scanned_amont" field.
  int? _scannedAmont;
  int get scannedAmont => _scannedAmont ?? 0;
  bool hasScannedAmont() => _scannedAmont != null;

  // "Poster" field.
  String? _poster;
  String get poster => _poster ?? '';
  bool hasPoster() => _poster != null;

  // "IDticket" field.
  SupabaseDocRef? _iDticket;
  SupabaseDocRef? get iDticket => _iDticket;
  bool hasIDticket() => _iDticket != null;

  // "NameVenues" field.
  String? _nameVenues;
  String get nameVenues => _nameVenues ?? '';
  bool hasNameVenues() => _nameVenues != null;

  // "date_Event" field.
  DateTime? _dateEvent;
  DateTime? get dateEvent => _dateEvent;
  bool hasDateEvent() => _dateEvent != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  void _initializeFields() {
    _nameEvent = snapshotData['NameEvent'] as String?;
    _eventOrNormal = snapshotData['EventOrNormal'] as bool?;
    _price = snapshotData['price'] as String?;
    _zone = snapshotData['zone'] as String?;
    _seatCode = snapshotData['SeatCode'] as String?;
    _bg = snapshotData['BG'] as String?;
    _idVenues = snapshotData['Id_Venues'] as SupabaseDocRef?;
    _scanAmont = castToType<int>(snapshotData['scan_amont']);
    _timeEvent = snapshotData['time_event'] as String?;
    _scannedAmont = castToType<int>(snapshotData['scanned_amont']);
    _poster = snapshotData['Poster'] as String?;
    _iDticket = snapshotData['IDticket'] as SupabaseDocRef?;
    _nameVenues = snapshotData['NameVenues'] as String?;
    _dateEvent = snapshotData['date_Event'] as DateTime?;
    _location = snapshotData['location'] as LatLng?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Ticket');

  static Stream<TicketRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => TicketRecord.fromSnapshot(s));

  static Future<TicketRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => TicketRecord.fromSnapshot(s));

  static TicketRecord fromSnapshot(SupabaseDocSnapshot snapshot) => TicketRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static TicketRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      TicketRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'TicketRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TicketRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTicketRecordData({
  String? nameEvent,
  bool? eventOrNormal,
  String? price,
  String? zone,
  String? seatCode,
  String? bg,
  SupabaseDocRef? idVenues,
  int? scanAmont,
  String? timeEvent,
  int? scannedAmont,
  String? poster,
  SupabaseDocRef? iDticket,
  String? nameVenues,
  DateTime? dateEvent,
  LatLng? location,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'NameEvent': nameEvent,
      'EventOrNormal': eventOrNormal,
      'price': price,
      'zone': zone,
      'SeatCode': seatCode,
      'BG': bg,
      'Id_Venues': idVenues,
      'scan_amont': scanAmont,
      'time_event': timeEvent,
      'scanned_amont': scannedAmont,
      'Poster': poster,
      'IDticket': iDticket,
      'NameVenues': nameVenues,
      'date_Event': dateEvent,
      'location': location,
    }.withoutNulls,
  );

  return supabaseData;
}

class TicketRecordDocumentEquality implements Equality<TicketRecord> {
  const TicketRecordDocumentEquality();

  @override
  bool equals(TicketRecord? e1, TicketRecord? e2) {
    return e1?.nameEvent == e2?.nameEvent &&
        e1?.eventOrNormal == e2?.eventOrNormal &&
        e1?.price == e2?.price &&
        e1?.zone == e2?.zone &&
        e1?.seatCode == e2?.seatCode &&
        e1?.bg == e2?.bg &&
        e1?.idVenues == e2?.idVenues &&
        e1?.scanAmont == e2?.scanAmont &&
        e1?.timeEvent == e2?.timeEvent &&
        e1?.scannedAmont == e2?.scannedAmont &&
        e1?.poster == e2?.poster &&
        e1?.iDticket == e2?.iDticket &&
        e1?.nameVenues == e2?.nameVenues &&
        e1?.dateEvent == e2?.dateEvent &&
        e1?.location == e2?.location;
  }

  @override
  int hash(TicketRecord? e) => const ListEquality().hash([
        e?.nameEvent,
        e?.eventOrNormal,
        e?.price,
        e?.zone,
        e?.seatCode,
        e?.bg,
        e?.idVenues,
        e?.scanAmont,
        e?.timeEvent,
        e?.scannedAmont,
        e?.poster,
        e?.iDticket,
        e?.nameVenues,
        e?.dateEvent,
        e?.location
      ]);

  @override
  bool isValidKey(Object? o) => o is TicketRecord;
}
