import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  final client = Supabase.instance.client;
  await client.from('chat_rooms').select('id').eq('group_chat', false).contains(
    'user_ids',
    ['uid1', 'uid2'],
  );
}
