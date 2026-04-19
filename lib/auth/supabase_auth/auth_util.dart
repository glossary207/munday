import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

import '/backend/backend.dart';
import 'package:stream_transform/stream_transform.dart';
import 'supabase_auth_manager.dart'; // We should probably shim this too or reuse it if generic

export 'supabase_auth_manager.dart';

final _authManager = SupabaseAuthManager();
SupabaseAuthManager get authManager => _authManager;

User? get currentUser => Supabase.instance.client.auth.currentUser;

bool get loggedIn => currentUser != null;

String get currentUserEmail =>
    currentUserDocument?.email ?? currentUser?.email ?? '';

String get currentUserUid => currentUser?.id ?? '';

String get currentUserDisplayName =>
    currentUserDocument?.displayName ??
    currentUser?.userMetadata?['full_name'] ??
    '';

String get currentUserPhoto =>
    currentUserDocument?.photoUrl ??
    currentUser?.userMetadata?['avatar_url'] ??
    '';

String get currentPhoneNumber =>
    currentUserDocument?.phoneNumber ?? currentUser?.phone ?? '';

String get currentJwtToken => _currentJwtToken ?? '';

bool get currentUserNeedsOnboarding {
  final authEmail = currentUser?.email?.trim() ?? '';
  if (!authEmail.endsWith('@phone.munday.app')) {
    return false;
  }

  final displayName = currentUserDocument?.displayName.trim() ?? '';
  return displayName.isEmpty || displayName.endsWith('@phone.munday.app');
}

bool get currentUserEmailVerified =>
    currentUser?.identities?.isNotEmpty ?? false; // Approximation

/// Create a Stream that listens to the current user's JWT Token
String? _currentJwtToken;
final jwtTokenStream =
    Supabase.instance.client.auth.onAuthStateChange.map((event) async {
  _currentJwtToken = event.session?.accessToken;
  return _currentJwtToken;
}).asBroadcastStream();

SupabaseDocRef? get currentUserReference =>
    loggedIn ? UsersRecord.collection.doc(currentUser!.id) : null;

UsersRecord? currentUserDocument;
final authenticatedUserStream = Supabase.instance.client.auth.onAuthStateChange
    .map<String>((event) => event.session?.user.id ?? '')
    .switchMap(
      (uid) => uid.isEmpty
          ? Stream.value(null)
          : UsersRecord.getDocument(UsersRecord.collection.doc(uid))
              .handleError((_) {}),
    )
    .asyncMap((user) async {
  // If the stream emits a sparse UsersRecord with no timestamps, bootstrap it.
  // Ensure the row is created/loaded so currentUserDocument is always valid.
  if (user != null && !user.hasCreatedTime()) {
    final supabaseUser = Supabase.instance.client.auth.currentUser;
    if (supabaseUser != null) {
      await maybeCreateUser(supabaseUser);
    }
  } else {
    currentUserDocument = user;
  }
  return currentUserDocument;
}).asBroadcastStream();

class AuthUserStreamWidget extends StatelessWidget {
  const AuthUserStreamWidget({Key? key, required this.builder})
      : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: authenticatedUserStream,
        builder: (context, _) => builder(context),
      );
}
