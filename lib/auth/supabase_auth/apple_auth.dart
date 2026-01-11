import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

Future<bool> appleSignIn() async {
  final res = await Supabase.instance.client.auth.signInWithOAuth(
    OAuthProvider.apple,
    redirectTo: kIsWeb ? null : 'io.supabase.flutter://signin-callback/',
  );
  return res;
}
