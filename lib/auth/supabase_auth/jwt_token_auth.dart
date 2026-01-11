import 'package:supabase_flutter/supabase_flutter.dart';

Future<AuthResponse?> jwtTokenSignIn(String jwtToken) async {
  // Supabase usually handles JWTs via session setting, but simple "signInWithCustomToken" isn't 1:1.
  // Stubbing for now.
  return null;
}
