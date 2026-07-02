import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:munday/features/auth/data/base_auth_user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

@NowaGenerated()
class AuthManager {
  Future signOut() async {}

  Future deleteUser(BuildContext context) async {}

  Future updateEmail({
    required String email,
    required BuildContext context,
  }) async {}

  Future updatePassword({
    required String newPassword,
    required BuildContext context,
  }) async {}

  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {}

  Future<BaseAuthUser?> signInAnonymously(BuildContext context) async {}

  Future<BaseAuthUser?> signInWithGithub(BuildContext context) async {}

  Future<BaseAuthUser?> signInWithJwtToken(
    BuildContext context,
    String jwtToken,
  ) async {}

  Future beginPhoneAuth({
    required BuildContext context,
    required String phoneNumber,
    required void Function(BuildContext) onCodeSent,
  }) async {}

  Future verifySmsCode({
    required BuildContext context,
    required String smsCode,
  }) async {}

  static Future<void> saveLoginType(String loginType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_type', loginType);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required int expiresAt,
    required Map<String, dynamic> user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setInt('expires_at', expiresAt);
    await prefs.setString('user_data', jsonEncode(user));
  }
}
