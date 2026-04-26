import re

with open('lib/features/social/presentation/home_page/home_page_widget.dart', 'r') as f:
    content = f.read()

# Replace RoomRecord with ChatRoomsRecord
content = content.replace('RoomRecord', 'ChatRoomsRecord')
content = content.replace('queryRoomRecord', 'queryChatRoomsRecord')

# Fix UI properties
# lastmassage -> last_message
content = content.replace('lastmassage', 'lastMessage')
# timeupdate -> last_message_time
content = content.replace('timeupdate', 'lastMessageTime')
# createRoomRecordData(timeupdate: -> createChatRoomsRecordData(lastMessageTime:
content = content.replace('createChatRoomsRecordData(timeupdate:', 'createChatRoomsRecordData(lastMessageTime:')

# message.lastOrNull?.name -> message no longer exists on ChatRoomRecord
# For the UI logic around 'LastpersonUpdate', we need to check group_chat or last_message_sender_id
content = re.sub(
    r"containerChatRoomsRecord.lastpersonUpdate == currentUserReference \? 'คุณ' : valueOrDefault<String>\(containerChatRoomsRecord\.message\.lastOrNull\?.name, 'ไม่ระบุ'\)",
    "containerChatRoomsRecord.lastMessageSenderId == currentUserDocument?.id ? 'คุณ' : 'ผู้อื่น'", 
    content
)

# Fix queryBuilder for queryChatRoomsRecord
old_query = """queryBuilder: (roomRecord) => roomRecord
                        .where(Filter.or(
                          Filter('usersend', isEqualTo: currentUserReference),
                          Filter('userrecive', isEqualTo: currentUserReference),
                        ))
                        .orderBy('timeupdate', descending: true)"""
new_query = """queryBuilder: (chatRoomsRecord) => chatRoomsRecord
                        .where('user_ids', arrayContains: currentUserReference)
                        .orderBy('last_message_time', descending: true)"""
content = content.replace(old_query, new_query)

# Change RoomListSnapshot loop variables to match what FlutterFlow might generate or simple dart
content = content.replace('containerChatRoomsRecord.namesend', 'containerChatRoomsRecord.name')
content = content.replace('containerChatRoomsRecord.namerecive', 'containerChatRoomsRecord.name')
content = content.replace('containerChatRoomsRecord.photosend', 'containerChatRoomsRecord.imageUrl')
content = content.replace('containerChatRoomsRecord.photorecive', 'containerChatRoomsRecord.imageUrl')

# usersend -> senderId logic?
content = content.replace('containerChatRoomsRecord.usersend', 'containerChatRoomsRecord.userIds.first')

with open('lib/features/social/presentation/home_page/home_page_widget.dart', 'w') as f:
    f.write(content)
