import 'dart:async';

import 'package:collection/collection.dart';
import '/backend/schema/util/supabase_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRoomsRecord extends SupabaseRecord {
  ChatRoomsRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "user_ids" field.
  List<String>? _userIds;
  List<String> get userIds => _userIds ?? const [];
  bool hasUserIds() => _userIds != null;

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "last_message_sender_id" field.
  String? _lastMessageSenderId;
  String get lastMessageSenderId => _lastMessageSenderId ?? '';
  bool hasLastMessageSenderId() => _lastMessageSenderId != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "group_chat" field.
  bool? _groupChat;
  bool get groupChat => _groupChat ?? false;
  bool hasGroupChat() => _groupChat != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _userIds = getDataList(snapshotData['user_ids']);
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _lastMessageSenderId = snapshotData['last_message_sender_id']?.toString();
    _createdTime = snapshotData['created_time'] as DateTime?;
    _groupChat = snapshotData['group_chat'] as bool?;
    _imageUrl = snapshotData['image_url'] as String?;
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('chat_rooms');

  static Stream<ChatRoomsRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => ChatRoomsRecord.fromSnapshot(s));

  static Future<ChatRoomsRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => ChatRoomsRecord.fromSnapshot(s));

  static ChatRoomsRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      ChatRoomsRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>? ?? {}),
      );

  static ChatRoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      ChatRoomsRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'ChatRoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(dynamic other) =>
      other is ChatRoomsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRoomsRecordData({
  String? name,
  String? lastMessage,
  DateTime? lastMessageTime,
  String? lastMessageSenderId,
  DateTime? createdTime,
  bool? groupChat,
  String? imageUrl,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'name': name,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'last_message_sender_id': lastMessageSenderId,
      'created_time': createdTime,
      'group_chat': groupChat,
      'image_url': imageUrl,
    }.withoutNulls,
  );

  return supabaseData;
}

class ChatRoomsRecordDocumentEquality implements Equality<ChatRoomsRecord> {
  const ChatRoomsRecordDocumentEquality();

  @override
  bool equals(ChatRoomsRecord? e1, ChatRoomsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        listEquality.equals(e1?.userIds, e2?.userIds) &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.lastMessageSenderId == e2?.lastMessageSenderId &&
        e1?.createdTime == e2?.createdTime &&
        e1?.groupChat == e2?.groupChat &&
        e1?.imageUrl == e2?.imageUrl;
  }

  @override
  int hash(ChatRoomsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.userIds,
        e?.lastMessage,
        e?.lastMessageTime,
        e?.lastMessageSenderId,
        e?.createdTime,
        e?.groupChat,
        e?.imageUrl,
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatRoomsRecord;
}
