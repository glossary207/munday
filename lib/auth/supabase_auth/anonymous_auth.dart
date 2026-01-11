import 'package:supabase_flutter/supabase_flutter.dart';

Future<AuthResponse> anonymousSignInFunc() =>
    Supabase.instance.client.auth.signInAnonymously();
