import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import '../auth_manager.dart';

import '/backend/backend.dart';
import 'supabase_user_provider.dart'; // We kept the file name but it should contain Supabase logic

export '../base_auth_user_provider.dart';

const kbIsWeb = kIsWeb;

class SupabasePhoneAuthManager extends ChangeNotifier {
  // Stubbed for Supabase Phone Auth if needed later
  bool? _triggerOnCodeSent;

  void Function(BuildContext)? _onCodeSent;

  bool get triggerOnCodeSent => _triggerOnCodeSent ?? false;
  set triggerOnCodeSent(bool val) => _triggerOnCodeSent = val;

  void Function(BuildContext) get onCodeSent =>
      _onCodeSent == null ? (_) {} : _onCodeSent!;
  set onCodeSent(void Function(BuildContext) func) => _onCodeSent = func;

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}

class SupabaseAuthManager extends AuthManager
    with
        EmailSignInManager,
        AnonymousSignInManager,
        AppleSignInManager,
        GoogleSignInManager,
        GithubSignInManager,
        PhoneSignInManager,
        JwtSignInManager {
  SupabasePhoneAuthManager phoneAuthManager = SupabasePhoneAuthManager();

  @override
  Future signOut() {
    return Supabase.instance.client.auth.signOut();
  }

  @override
  Future deleteUser(BuildContext context) async {
    // Client side delete is restricted.
    print(
        'Delete user requested. Supabase typically requires backend function for this.');
  }

  @override
  Future updateEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      if (!loggedIn) {
        return;
      }
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(email: email));
      await updateUserDocument(email: email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Future updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      if (!loggedIn) {
        return;
      }
      await Supabase.instance.client.auth
          .updateUser(UserAttributes(password: newPassword));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return null;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent')),
    );
  }

  @override
  Future<BaseAuthUser?> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => Supabase.instance.client.auth
            .signInWithPassword(email: email, password: password),
        'EMAIL',
      );

  @override
  Future<BaseAuthUser?> createAccountWithEmail(
    BuildContext context,
    String email,
    String password,
  ) =>
      _signInOrCreateAccount(
        context,
        () => Supabase.instance.client.auth
            .signUp(email: email, password: password),
        'EMAIL',
      );

  @override
  Future<BaseAuthUser?> signInAnonymously(
    BuildContext context,
  ) async {
    final res = await Supabase.instance.client.auth.signInAnonymously();
    if (res.user != null) {
      await maybeCreateUser(res.user!);
      return MundaySupabaseUser.fromSupabaseUser(res.user);
    }
    return null;
  }

  @override
  Future<BaseAuthUser?> signInWithApple(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      final accessToken = credential
          .authorizationCode; // Apple returns auth code, Supabase handles it

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      return _signInOrCreateAccount(
        context,
        () => Supabase.instance.client.auth.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: idToken,
          accessToken: accessToken,
        ),
        'APPLE',
      );
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException &&
          e.code == AuthorizationErrorCode.canceled) {
        return null;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple Sign-In Error: $e')),
      );
      return null;
    }
  }

  @override
  Future<BaseAuthUser?> signInWithGoogle(BuildContext context) async {
    try {
      // Initialize GoogleSignIn
      // For Web: clientId is required. For iOS: iosClientId is defined in Info.plist usually,
      // but explicitly providing it here ensures finding it if package doesn't auto-detect.
      const webClientId =
          '21798173906-g3g20402gug9a3retgrt8dcg3qsu7dtc.apps.googleusercontent.com';
      const iosClientId =
          '21798173906-g3g20402gug9a3retgrt8dcg3qsu7dtc.apps.googleusercontent.com'; // Derived from scheme com.googleusercontent.apps...

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: kbIsWeb
            ? webClientId
            : (defaultTargetPlatform == TargetPlatform.iOS
                ? iosClientId
                : null), // Explicitly pass iOS Client ID
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in flow
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      return _signInOrCreateAccount(
        context,
        () => Supabase.instance.client.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        ),
        'GOOGLE',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Error: $e')),
      );
      return null;
    }
  }

  @override
  Future<BaseAuthUser?> signInWithGithub(BuildContext context) async {
    return null;
  }

  @override
  Future<BaseAuthUser?> signInWithJwtToken(
    BuildContext context,
    String jwtToken,
  ) async {
    return null;
  }

  void handlePhoneAuthStateChanges(BuildContext context) {
    // Stub
  }

  @override
  Future beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  }) async {
    // Stub or implement OTP
  }

  @override
  Future verifySmsCode({
    required BuildContext context,
    required String smsCode,
  }) async {
    return null;
  }

  /// Tries to sign in or create an account using Supabase Auth.
  Future<BaseAuthUser?> _signInOrCreateAccount(
    BuildContext context,
    Future<AuthResponse> Function() signInFunc,
    String authProvider,
  ) async {
    try {
      final response = await signInFunc();
      if (response.user != null) {
        await maybeCreateUser(response.user!);
      }
      return response.user == null
          ? null
          : MundaySupabaseUser.fromAuthResponse(response);
    } on AuthException catch (e) {
      final errorMsg = 'Error: ${e.message}';
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return null;
    }
  }
}
