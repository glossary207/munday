import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoomVenuesLiveChatRecord extends SupabaseRecord {
  RoomVenuesLiveChatRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "id_venue" field.
  SupabaseDocRef? _idVenue;
  SupabaseDocRef? get idVenue => _idVenue;
  bool hasIdVenue() => _idVenue != null;

  // "chat" field.
  List<ChatElementLivechatStruct>? _chat;
  List<ChatElementLivechatStruct> get chat => _chat ?? const [];
  bool hasChat() => _chat != null;

  void _initializeFields() {
    _idVenue = snapshotData['id_venue'] as SupabaseDocRef?;
    _chat = getStructList(
      snapshotData['chat'],
      ChatElementLivechatStruct.fromMap,
    );
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Room_venues_liveChat');

  static Stream<RoomVenuesLiveChatRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => RoomVenuesLiveChatRecord.fromSnapshot(s));

  static Future<RoomVenuesLiveChatRecord> getDocumentOnce(
          SupabaseDocRef ref) =>
      ref.get().then((s) => RoomVenuesLiveChatRecord.fromSnapshot(s));

  static RoomVenuesLiveChatRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      RoomVenuesLiveChatRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static RoomVenuesLiveChatRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      RoomVenuesLiveChatRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'RoomVenuesLiveChatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoomVenuesLiveChatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoomVenuesLiveChatRecordData({
  SupabaseDocRef? idVenue,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'id_venue': idVenue,
    }.withoutNulls,
  );

  return supabaseData;
}

class RoomVenuesLiveChatRecordDocumentEquality
    implements Equality<RoomVenuesLiveChatRecord> {
  const RoomVenuesLiveChatRecordDocumentEquality();

  @override
  bool equals(RoomVenuesLiveChatRecord? e1, RoomVenuesLiveChatRecord? e2) {
    const listEquality = ListEquality();
    return e1?.idVenue == e2?.idVenue &&
        listEquality.equals(e1?.chat, e2?.chat);
  }

  @override
  int hash(RoomVenuesLiveChatRecord? e) =>
      const ListEquality().hash([e?.idVenue, e?.chat]);

  @override
  bool isValidKey(Object? o) => o is RoomVenuesLiveChatRecord;
}
