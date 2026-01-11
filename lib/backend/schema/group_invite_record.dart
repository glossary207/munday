import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/supabase_util.dart';


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupInviteRecord extends SupabaseRecord {
  GroupInviteRecord._(
    SupabaseDocRef reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Name_group" field.
  String? _nameGroup;
  String get nameGroup => _nameGroup ?? '';
  bool hasNameGroup() => _nameGroup != null;

  // "User_in_group" field.
  List<UserInGroupInviteStruct>? _userInGroup;
  List<UserInGroupInviteStruct> get userInGroup => _userInGroup ?? const [];
  bool hasUserInGroup() => _userInGroup != null;

  // "ID_venues" field.
  SupabaseDocRef? _iDVenues;
  SupabaseDocRef? get iDVenues => _iDVenues;
  bool hasIDVenues() => _iDVenues != null;

  // "chat_room" field.
  List<ChatElementLivechatStruct>? _chatRoom;
  List<ChatElementLivechatStruct> get chatRoom => _chatRoom ?? const [];
  bool hasChatRoom() => _chatRoom != null;

  void _initializeFields() {
    _nameGroup = snapshotData['Name_group'] as String?;
    _userInGroup = getStructList(
      snapshotData['User_in_group'],
      UserInGroupInviteStruct.fromMap,
    );
    _iDVenues = snapshotData['ID_venues'] as SupabaseDocRef?;
    _chatRoom = getStructList(
      snapshotData['chat_room'],
      ChatElementLivechatStruct.fromMap,
    );
  }

  static SupabaseCollectionRef get collection =>
      SupabaseFirestore.instance.collection('Group_invite');

  static Stream<GroupInviteRecord> getDocument(SupabaseDocRef ref) =>
      ref.snapshots().map((s) => GroupInviteRecord.fromSnapshot(s));

  static Future<GroupInviteRecord> getDocumentOnce(SupabaseDocRef ref) =>
      ref.get().then((s) => GroupInviteRecord.fromSnapshot(s));

  static GroupInviteRecord fromSnapshot(SupabaseDocSnapshot snapshot) =>
      GroupInviteRecord._(
        snapshot.reference,
        mapFromSupabase(snapshot.data() as Map<String, dynamic>),
      );

  static GroupInviteRecord getDocumentFromData(
    Map<String, dynamic> data,
    SupabaseDocRef reference,
  ) =>
      GroupInviteRecord._(reference, mapFromSupabase(data));

  @override
  String toString() =>
      'GroupInviteRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupInviteRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupInviteRecordData({
  String? nameGroup,
  SupabaseDocRef? iDVenues,
}) {
  final supabaseData = mapToSupabase(
    <String, dynamic>{
      'Name_group': nameGroup,
      'ID_venues': iDVenues,
    }.withoutNulls,
  );

  return supabaseData;
}

class GroupInviteRecordDocumentEquality implements Equality<GroupInviteRecord> {
  const GroupInviteRecordDocumentEquality();

  @override
  bool equals(GroupInviteRecord? e1, GroupInviteRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nameGroup == e2?.nameGroup &&
        listEquality.equals(e1?.userInGroup, e2?.userInGroup) &&
        e1?.iDVenues == e2?.iDVenues &&
        listEquality.equals(e1?.chatRoom, e2?.chatRoom);
  }

  @override
  int hash(GroupInviteRecord? e) => const ListEquality()
      .hash([e?.nameGroup, e?.userInGroup, e?.iDVenues, e?.chatRoom]);

  @override
  bool isValidKey(Object? o) => o is GroupInviteRecord;
}
