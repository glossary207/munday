import re

with open("lib/features/social/presentation/chats/chats_widget.dart", "r") as f:
    text = f.read()

# 1. Substitute RoomRecord -> ChatRoomsRecord where appropriate
# Wait, roomref is a parameter: `final SupabaseDocRef? roomref;`
text = re.sub(r'RoomRecord', 'ChatRoomsRecord', text)
text = re.sub(r'queryChatRoomsRecord\(', 'queryChatRoomsRecord(', text) # No-op if done

# 2. Variable remapping
text = text.replace('.messagephoto', '.imageUrl')
text = text.replace('.timeup!', '.timestamp!')
text = text.replace('.timeup', '.timestamp')
text = text.replace('.messagetext', '.text')
text = text.replace('.LastpersonUpdate', '.lastMessageSenderId')
text = text.replace('.timeupdate', '.lastMessageTime')
text = text.replace('.lastmassage', '.lastMessage')

# Handle `who` SupabaseDocRef -> String
text = text.replace('.who?.id', '.senderId')
text = text.replace('.who!.id', '.senderId')
text = text.replace('.who?.path', "('users/' + datachatItem.senderId)")
# Sometimes it passes who! to another widget like DelchatWidget
text = text.replace('who: datachatItem.who!', 'whoId: datachatItem.senderId') 

# Fix sender UI mappings
text = text.replace('datachatItem.userphoto', 'datachatItem.senderPhoto')
text = text.replace('datachatItem.name', 'datachatItem.senderName')

# 3. Stream update
# We replace the datachat builder block
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
                                                    if (!messagesSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                                                    final datachat = messagesSnapshot.data!;

                                                    return ListView.builder("""
text = text.replace(old_builder, new_builder)

# We need to find where the `Builder` block ends to insert `},)`
# An easy hack: The builder ends right before `Padding( ... Padding( ... Container( ... Send message bar ... )`
# In FlutterFlow, it's usually followed by a Padding wrapping the text input.
# Let's use a regex to inject the closing braces.
closing_injection = """                                                );
                                              },
                                            ),"""
# Let's just do a manual AST count in dart or just replace it precisely if possible.
# Actually, since we wrap the ListView in a StreamBuilder, we can just replace the ListView close.
# ListView usually ends with `);` and right after it is the text field bottom bar.

with open("lib/features/social/presentation/chats/chats_widget.dart", "w") as f:
    f.write(text)

