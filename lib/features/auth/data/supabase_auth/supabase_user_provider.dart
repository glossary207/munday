import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../base_auth_user_provider.dart';

export '../base_auth_user_provider.dart';

class MundaySupabaseUser extends BaseAuthUser {
  MundaySupabaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;

  @override
  AuthUserInfo get authUserInfo => AuthUserInfo(
        uid: user?.id,
        email: user?.email,
        displayName: user?.userMetadata?['full_name'],
        photoUrl: user?.userMetadata?['avatar_url'],
        phoneNumber: user?.phone,
      );

  @override
  Future? delete() => Supabase.instance.client.rpc('delete_user');

  @override
  Future? updateEmail(String email) async {
    await Supabase.instance.client.auth
        .updateUser(UserAttributes(email: email));
  }

  @override
  Future? updatePassword(String newPassword) async {
    await Supabase.instance.client.auth
        .updateUser(UserAttributes(password: newPassword));
  }

  @override
  Future? sendEmailVerification() => null;

  @override
  bool get emailVerified {
    return user?.identities?.isNotEmpty ?? false;
  }

  @override
  Future refreshUser() async {
    final response = await Supabase.instance.client.auth.getUser();
    user = response.user;
  }

  static BaseAuthUser fromAuthResponse(AuthResponse response) =>
      fromSupabaseUser(response.user);
  static BaseAuthUser fromSupabaseUser(User? user) => MundaySupabaseUser(user);
}

Stream<BaseAuthUser> mundaySupabaseUserStream() =>
    Supabase.instance.client.auth.onAuthStateChange
        .debounce((event) => event.session == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(event))
        .map<BaseAuthUser>(
      (event) {
        currentUser = MundaySupabaseUser(event.session?.user);
        return currentUser!;
      },
    );
