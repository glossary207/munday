import 'dart:convert';
import 'package:http/http.dart' as http;

const _supabaseUrl = 'https://xdhhlxpysugtzkqrtdzp.supabase.co';
const _supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkaGhseHB5c3VndHprcXJ0ZHpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwODE0ODIsImV4cCI6MjA4MTY1NzQ4Mn0.WjtC3gW03KYsNexLS734sBJS-ZIKH4bKOmhKatoFPk8';

class OtpApiResult {
  final bool success;
  final Map<String, dynamic>? data;
  final String? error;

  const OtpApiResult({required this.success, this.data, this.error});
}

class SendOtpCall {
  static Future<OtpApiResult> call({required String phone}) async {
    try {
      final response = await http.post(
        Uri.parse('$_supabaseUrl/functions/v1/send-otp'),
        headers: {
          'Authorization': 'Bearer $_supabaseAnonKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'phone': phone}),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return OtpApiResult(success: true, data: data);
      }
      return OtpApiResult(
          success: false, error: data['error']?.toString() ?? 'เกิดข้อผิดพลาด');
    } catch (e) {
      return OtpApiResult(success: false, error: e.toString());
    }
  }
}

class VerifyOtpCall {
  static Future<OtpApiResult> call({
    required String phone,
    required String code,
    required String loginType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_supabaseUrl/functions/v1/verify-otp'),
        headers: {
          'Authorization': 'Bearer $_supabaseAnonKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'code': code,
          'login_type': loginType,
        }),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return OtpApiResult(success: true, data: data);
      }
      return OtpApiResult(
          success: false,
          error: data['error']?.toString() ?? 'รหัส OTP ไม่ถูกต้อง');
    } catch (e) {
      return OtpApiResult(success: false, error: e.toString());
    }
  }
}

class TestLoginCall {
  static const List<String> testPhones = ['0000000000', '1111111111'];

  static bool isTestPhone(String phone) => testPhones.contains(phone);

  static Future<OtpApiResult> call({
    required String phone,
    required String loginType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_supabaseUrl/functions/v1/test-login'),
        headers: {
          'Authorization': 'Bearer $_supabaseAnonKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'login_type': loginType,
        }),
      );
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return OtpApiResult(success: true, data: data);
      }
      return OtpApiResult(
          success: false, error: data['error']?.toString() ?? 'เกิดข้อผิดพลาด');
    } catch (e) {
      return OtpApiResult(success: false, error: e.toString());
    }
  }
}
