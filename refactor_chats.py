import re

with open('lib/features/social/presentation/chats/chats_widget.dart', 'r') as f:
    content = f.read()

# Replace RoomRecord with ChatRoomsRecord globally where appropriate
content = content.replace('RoomRecord', 'ChatRoomsRecord')

# Fix UI properties
content = content.replace('.messagephoto', '.imageUrl')
content = content.replace('.who?.id', '.senderId')
content = content.replace('.who', '.senderId') # In case there's direct comparison
content = content.replace('.massage', '.text')
content = content.replace('.time', '.timestamp')

# 1. Update the stream builder list view
# The builder iterates `datachat = stackChatRoomsRecord.message.toList()`
old_builder = """                                                final datachat = stackChatRoomsRecord
                                                    .message
                                                    .toList();

                                                return ListView.builder("""

new_builder = """                                                return StreamBuilder<List<MessagesRecord>>(
                                                  stream: queryMessagesRecord(
                                                    queryBuilder: (query) => query
                                                        .where('chat_room_id', isEqualTo: widget.roomref!.id)
                                                        .orderBy('timestamp', descending: false),
                                                  ),
                                                  builder: (context, messagesSnapshot) {
                                                    if (!messagesSnapshot.hasData) return const SizedBox();
                                                    final datachat = messagesSnapshot.data!;

                                                    return ListView.builder("""

content = content.replace(old_builder, new_builder)

# close the StreamBuilder inside the widget tree (This is very risky using naive replace. Let's see if we can do something else).
