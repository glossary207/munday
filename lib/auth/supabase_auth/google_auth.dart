import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

Future<bool> googleSignInFunc() async {
  // web or mobile handling for oauth
  // For simplicity with Supabase Flutter, we use signInWithOAuth
  final res = await Supabase.instance.client.auth.signInWithOAuth(
    OAuthProvider.google,
    redirectTo: kIsWeb ? null : 'io.supabase.flutter://signin-callback/',
  );
  return res;
}

Future signOutWithGoogle() async {
  // Supabase signout handles everything usually
  await Supabase.instance.client.auth.signOut();
}
