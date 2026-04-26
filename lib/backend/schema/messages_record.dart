import 'dart:async';

import 'package:collection/collection.dart';
import '/backend/schema/util/supabase_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessagesRecord extends SupabaseRecord {
  MessagesRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "chat_room_id" field.
  String? _chatRoomId;
  String get chatRoomId => _chatRoomId ?? '';
  bool hasChatRoomId() => _chatRoomId != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "sender_id" field.
  String? _senderId;
  String get senderId => _senderId ?? '';
  bool hasSenderId() => _senderId != null;

  // "sender_name" field.
  String? _senderName;
  String get senderName => _senderName ?? '';
  bool hasSenderName() => _senderName != null;

  // "sender_photo" field.
  String? _senderPhoto;
  String get senderPhoto => _senderPhoto ?? '';
  bool hasSenderPhoto() => _senderPhoto != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "read_by_ids" field.
  List<String>? _readByIds;
  List<String> get readByIds => _readByIds ?? const [];
  bool hasReadByIds() => _readByIds != null;

  void _initializeFields() {
    _chatRoomId = snapshotData['chat_room_id']?.toString();
    _text = snapshotData['text'] as String?;
    _senderId = snapshotData['sender_id']?.toString();
    _senderName = snapshotData['sender_name'] as String?;
    _senderPhoto = snapshotData['sender_photo'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _imageUrl = snapshotData['image_url'] as String?;
    _readByIds = getDataList(snapshotData['read_by_ids']);
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('messages');

  static Stream<MessagesRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => MessagesRecord.fromSnapshot(s));

  static Future<MessagesRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => MessagesRecord.fromSnapshot(s));

  static MessagesRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      MessagesRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>? ?? {}),
      );

  static MessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      MessagesRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'MessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(dynamic other) =>
      other is MessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMessagesRecordData({
  String? chatRoomId,
  String? text,
  String? senderId,
  String? senderName,
  String? senderPhoto,
  DateTime? timestamp,
  String? imageUrl,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'chat_room_id': chatRoomId,
      'text': text,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_photo': senderPhoto,
      'timestamp': timestamp,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return supabaseData;
}

class MessagesRecordDocumentEquality implements Equality<MessagesRecord> {
  const MessagesRecordDocumentEquality();

  @override
  bool equals(MessagesRecord? e1, MessagesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.chatRoomId == e2?.chatRoomId &&
        e1?.text == e2?.text &&
        e1?.senderId == e2?.senderId &&
        e1?.senderName == e2?.senderName &&
        e1?.senderPhoto == e2?.senderPhoto &&
        e1?.timestamp == e2?.timestamp &&
        e1?.imageUrl == e2?.imageUrl &&
        listEquality.equals(e1?.readByIds, e2?.readByIds);
  }

  @override
  int hash(MessagesRecord? e) => const ListEquality().hash([
        e?.chatRoomId,
        e?.text,
        e?.senderId,
        e?.senderName,
        e?.senderPhoto,
        e?.timestamp,
        e?.imageUrl,
        e?.readByIds,
      ]);

  @override
  bool isValidKey(Object? o) => o is MessagesRecord;
}
