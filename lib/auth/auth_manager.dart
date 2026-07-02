import 'package:flutter/material.dart';

import 'base_auth_user_provider.dart';

abstract class AuthManager {
  Future signOut();
  Future deleteUser(BuildContext context);
  Future updateEmail({required String email, required BuildContext context});
  Future resetPassword({required String email, required BuildContext context});
  Future sendEmailVerification() async => currentUser?.sendEmailVerification();
  Future refreshUser() async => currentUser?.refreshUser();
}

abstract mixin class AnonymousSignInManager implements AuthManager {
  Future<BaseAuthUser?> signInAnonymously(BuildContext context);
}

abstract mixin class JwtSignInManager implements AuthManager {
  Future<BaseAuthUser?> signInWithJwtToken(
    BuildContext context,
    String jwtToken,
  );
}

abstract mixin class PhoneSignInManager implements AuthManager {
  Future beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  });

  Future verifySmsCode({
    required BuildContext context,
    required String smsCode,
  });
}

abstract class FacebookSignInManager implements AuthManager {
  Future<BaseAuthUser?> signInWithFacebook(BuildContext context);
}

abstract class MicrosoftSignInManager implements AuthManager {
  Future<BaseAuthUser?> signInWithMicrosoft(
    BuildContext context,
    List<String> scopes,
    String tenantId,
  );
}

abstract mixin class GithubSignInManager implements AuthManager {
  Future<BaseAuthUser?> signInWithGithub(BuildContext context);
}
