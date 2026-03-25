import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/backend/api_requests/otp_api_calls.dart';
import '/backend/backend.dart';
import '/services/auth_manager.dart';

class OtpVerifyWidget extends StatefulWidget {
  const OtpVerifyWidget({
    super.key,
    required this.phone,
    required this.loginType,
    required this.isTestPhone,
  });

  final String phone;
  final String loginType;
  final bool isTestPhone;

  static String routeName = 'OtpVerify';
  static String routePath = 'otp-verify';

  @override
  State<OtpVerifyWidget> createState() => _OtpVerifyWidgetState();
}

class _OtpVerifyWidgetState extends State<OtpVerifyWidget> with CodeAutoFill {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  bool _isLoading = false;
  bool _isResending = false;
  String? _errorMessage;
  int _resendCountdown = 60;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // SMS auto-fill: mobile only
    if (!kIsWeb) _listenForSms();
  }

  void _startCountdown() {
    _resendCountdown = 60;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _listenForSms() async {
    try {
      await SmsAutoFill().listenForCode();
    } catch (_) {
      // SMS autofill unavailable on this device
    }
  }

  /// Called automatically by CodeAutoFill mixin when SMS OTP is detected
  @override
  void codeUpdated() {
    if (kIsWeb) return;
    if (code != null && code!.isNotEmpty && mounted) {
      _otpController.text = code!;
      _otpController.selection = TextSelection.fromPosition(
        TextPosition(offset: code!.length),
      );
      if (code!.length == 6) {
        Future.microtask(() => _verifyOtp());
      }
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    _countdownTimer?.cancel();
    if (!kIsWeb) {
      SmsAutoFill().unregisterListener();
      cancel();
    }
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final code = _otpController.text.trim();
    if (code.length < 4) {
      setState(() => _errorMessage = 'กรุณากรอกรหัส OTP ให้ครบ');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    OtpApiResult result;
    if (widget.isTestPhone) {
      result = await TestLoginCall.call(
        phone: widget.phone,
        loginType: widget.loginType,
      );
    } else {
      result = await VerifyOtpCall.call(
        phone: widget.phone,
        code: code,
        loginType: widget.loginType,
      );
    }

    if (!mounted) return;

    if (result.success && result.data != null) {
      await _handleSession(result.data!);
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = result.error ?? 'รหัส OTP ไม่ถูกต้อง กรุณาลองใหม่';
      });
    }
  }

  Future<void> _handleSession(Map<String, dynamic> responseData) async {
    try {
      final accessToken = responseData['access_token'] as String?;
      final refreshToken = responseData['refresh_token'] as String?;
      final expiresAt = responseData['expires_at'] as int?;
      final expiresIn = responseData['expires_in'] as int?;
      final userRaw = responseData['user'];

      if (refreshToken == null || accessToken == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'ไม่ได้รับข้อมูล token จากระบบ';
        });
        return;
      }

      Map<String, dynamic> userMap;
      if (userRaw is Map<String, dynamic>) {
        userMap = userRaw;
      } else {
        userMap = {'phone': widget.phone, 'login_type': widget.loginType};
      }
      userMap['login_type'] ??= widget.loginType;

      await AuthManager.saveLoginType(widget.loginType);

      // Set Supabase session — triggers AppStateNotifier via auth stream
      await Supabase.instance.client.auth.setSession(refreshToken);

      final session = Supabase.instance.client.auth.currentSession;
      final finalAccessToken = session?.accessToken ?? accessToken;
      final finalExpiresAt = expiresAt ??
          (DateTime.now().millisecondsSinceEpoch ~/ 1000) +
              (expiresIn ?? 3600);

      await AuthManager.saveTokens(
        accessToken: finalAccessToken,
        expiresAt: finalExpiresAt,
        user: userMap,
      );

      // Ensure user record exists in the users table and populate currentUserDocument
      final supabaseUser = Supabase.instance.client.auth.currentUser;
      if (supabaseUser != null) {
        await maybeCreateUser(supabaseUser);
      }

      if (!mounted) return;

      // Explicitly navigate to root — replaces the entire Navigator stack
      // This is needed because OtpVerifyWidget was pushed via Navigator.push()
      // (not GoRouter), so GoRouter's redirect alone won't pop this screen.
      context.go('/');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'เกิดข้อผิดพลาดในการเชื่อมต่อ: $e';
      });
    }
  }

  Future<void> _resendOtp() async {
    if (_resendCountdown > 0 || _isResending) return;

    setState(() => _isResending = true);
    final result = await SendOtpCall.call(phone: widget.phone);
    if (!mounted) return;

    setState(() => _isResending = false);

    if (result.success) {
      _startCountdown();
      _otpController.clear();
      if (!kIsWeb) _listenForSms();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ส่ง OTP ใหม่แล้ว'),
          backgroundColor: Color(0xFF2A2A2A),
        ),
      );
    } else {
      setState(
          () => _errorMessage = result.error ?? 'ไม่สามารถส่ง OTP ใหม่ได้');
    }
  }

  String get _maskedPhone {
    final p = widget.phone;
    if (p.length < 6) return p;
    return '${p.substring(0, 3)}***${p.substring(p.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D0D0D),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'ยืนยันตัวตน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 14,
                      height: 1.6,
                    ),
                    children: [
                      const TextSpan(text: 'ส่งรหัส OTP ไปยังเบอร์ '),
                      TextSpan(
                        text: _maskedPhone,
                        style: const TextStyle(
                          color: Color(0xFFE8C46E),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: '\nกรุณากรอกรหัสที่ได้รับ'),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // OTP Label
                Row(
                  children: [
                    const Text(
                      'รหัส OTP (6 หลัก)',
                      style: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // Show auto-fill badge on mobile
                    if (!kIsWeb)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2A1A),
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: const Color(0xFF2A4A2A)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.sms_outlined,
                                color: Color(0xFF4CAF50), size: 12),
                            SizedBox(width: 4),
                            Text(
                              'รับอัตโนมัติจาก SMS',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // OTP TextField — works on all platforms
                // On mobile: CodeAutoFill mixin fills this automatically
                // On web: user types manually
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _errorMessage != null
                          ? Colors.redAccent
                          : const Color(0xFF2A2A2A),
                    ),
                  ),
                  child: TextField(
                    controller: _otpController,
                    focusNode: _otpFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 12,
                    ),
                    decoration: const InputDecoration(
                      hintText: '------',
                      hintStyle: TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 28,
                        letterSpacing: 12,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                    ),
                    onChanged: (val) {
                      if (_errorMessage != null) {
                        setState(() => _errorMessage = null);
                      }
                      // Auto-verify on manual 6-digit entry
                      if (val.length == 6) _verifyOtp();
                    },
                    onSubmitted: (_) => _verifyOtp(),
                  ),
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.redAccent, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 36),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8C46E),
                      foregroundColor: Colors.black,
                      disabledBackgroundColor: const Color(0xFF4A3E2A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            'ยืนยัน OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: GestureDetector(
                    onTap: _resendCountdown == 0 ? _resendOtp : null,
                    child: _isResending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFE8C46E),
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13),
                              children: [
                                const TextSpan(
                                  text: 'ไม่ได้รับรหัส? ',
                                  style:
                                      TextStyle(color: Color(0xFF888888)),
                                ),
                                TextSpan(
                                  text: _resendCountdown > 0
                                      ? 'ส่งใหม่อีกครั้งใน ${_resendCountdown}s'
                                      : 'ส่งใหม่อีกครั้ง',
                                  style: TextStyle(
                                    color: _resendCountdown > 0
                                        ? const Color(0xFF555555)
                                        : const Color(0xFFE8C46E),
                                    fontWeight: _resendCountdown == 0
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                if (widget.isTestPhone) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF333333)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Color(0xFF888888), size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'เบอร์ทดสอบ: กรอก OTP อะไรก็ได้',
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
