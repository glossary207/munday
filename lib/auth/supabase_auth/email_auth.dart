import 'package:supabase_flutter/supabase_flutter.dart';

Future<AuthResponse?> emailSignInFunc(
  String email,
  String password,
) async =>
    await Supabase.instance.client.auth
        .signInWithPassword(email: email.trim(), password: password);

Future<AuthResponse?> emailCreateAccountFunc(
  String email,
  String password,
) async =>
    await Supabase.instance.client.auth
        .signUp(email: email.trim(), password: password);
