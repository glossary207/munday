import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _keyAccessToken = 'auth_access_token';
  static const _keyTokenExpiresAt = 'auth_token_expires_at';
  static const _keyUser = 'auth_user';
  static const _keyUserId = 'auth_user_id';
  static const _keyLoginType = 'auth_login_type';

  static Future<void> _writeSecure(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> _readSecure(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required int expiresAt,
    required Map<String, dynamic> user,
  }) async {
    await _writeSecure(_keyAccessToken, accessToken);
    await _writeSecure(_keyTokenExpiresAt, expiresAt.toString());
    await _writeSecure(_keyUser, jsonEncode(user));

    final userId = user['uid'] as String? ?? user['id'] as String?;
    if (userId != null) {
      await _writeSecure(_keyUserId, userId);
    }

    final loginType = user['login_type'] as String?;
    if (loginType != null && loginType.isNotEmpty) {
      await _writeSecure(_keyLoginType, loginType);
    }
  }

  static Future<void> saveLoginType(String loginType) async {
    await _writeSecure(_keyLoginType, loginType);
  }

  static Future<String?> getAccessToken() async {
    final token = await _readSecure(_keyAccessToken);
    if (token == null) return null;
    final expiresAtStr = await _readSecure(_keyTokenExpiresAt);
    if (expiresAtStr != null) {
      final expiresAt = int.tryParse(expiresAtStr) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (now >= expiresAt) return null;
    }
    return token;
  }

  static Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null;
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final userJson = await _readSecure(_keyUser);
    if (userJson == null) return null;
    try {
      return jsonDecode(userJson) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<String?> getUserId() async {
    return await _readSecure(_keyUserId);
  }

  static Future<String?> getLoginType() async {
    return await _readSecure(_keyLoginType);
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyTokenExpiresAt);
    await _storage.delete(key: _keyUser);
    await _storage.delete(key: _keyUserId);
    await _storage.delete(key: _keyLoginType);
  }
}
