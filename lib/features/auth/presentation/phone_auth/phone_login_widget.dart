import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/backend/api_requests/otp_api_calls.dart';
import 'otp_verify_widget.dart';

const _authBg = Color(0xFF0D0D0D);
const _authPanel = Color(0xFF1A1A1A);
const _authBorder = Color(0xFF2E2021);
const _authAccent = Color(0xFFE53935);
const _authAccentDark = Color(0xFF7A1217);

class PhoneLoginWidget extends StatefulWidget {
  const PhoneLoginWidget({super.key});

  static String routeName = 'PhoneLogin';
  static String routePath = 'phone-login';

  @override
  State<PhoneLoginWidget> createState() => _PhoneLoginWidgetState();
}

class _PhoneLoginWidgetState extends State<PhoneLoginWidget> {
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _pageController = PageController();

  bool _isLoading = false;
  String? _errorMessage;
  int _currentSlide = 0;

  static const _slides = [
    _SlideData(
      image:
          'assets/images/colorful-vibrant-holographic-pastel-foil-background-texture-toxic-rave-party-backdrop_232693-243_3.jpeg',
      title: 'Community Night Party',
      subtitle: 'ค้นพบปาร์ตี้และสถานที่ยามค่ำคืนใกล้คุณ',
    ),
    _SlideData(
      image:
          'assets/images/455040334_886884533466916_1650523449501590794_n.jpg',
      title: 'จองโต๊ะล่วงหน้า',
      subtitle: 'จองที่นั่งได้ทันที ไม่ต้องรอคิว',
    ),
    _SlideData(
      image:
          'assets/images/480550932_923908646619366_4284518964252663928_n.jpg',
      title: 'สนุกได้ทุกคืน',
      subtitle: 'โปรโมชั่นพิเศษและกิจกรรมสุดเอ็กซ์คลูซีฟ',
    ),
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  String _normalizePhone(String raw) {
    String phone = raw.replaceAll(RegExp(r'\D'), '');
    if (phone.startsWith('66')) phone = '0${phone.substring(2)}';
    if (phone.startsWith('+66')) phone = '0${phone.substring(3)}';
    return phone;
  }

  Future<void> _sendOtp() async {
    final phone = _normalizePhone(_phoneController.text.trim());
    if (phone.length < 9 || phone.length > 10) {
      setState(() => _errorMessage = 'กรุณากรอกเบอร์โทรให้ถูกต้อง (9-10 หลัก)');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (TestLoginCall.isTestPhone(phone)) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerifyWidget(
            phone: phone,
            loginType: 'user',
            isTestPhone: true,
          ),
        ),
      );
      return;
    }

    final result = await SendOtpCall.call(phone: phone);
    setState(() => _isLoading = false);
    if (!mounted) return;

    if (result.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerifyWidget(
            phone: phone,
            loginType: 'user',
            isTestPhone: false,
          ),
        ),
      );
    } else {
      setState(() =>
          _errorMessage = result.error ?? 'ไม่สามารถส่ง OTP ได้ กรุณาลองใหม่');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _authBg,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              height: bottomPadding > 0
                  ? screenHeight * 0.28
                  : screenHeight * 0.58,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (i) => setState(() => _currentSlide = i),
                    itemBuilder: (context, index) {
                      return _buildSlide(_slides[index]);
                    },
                  ),
                  Positioned(
                    top: 48,
                    left: 24,
                    child: Image.asset(
                      'assets/images/Munday-logo.png',
                      height: 36,
                      errorBuilder: (_, __, ___) => const Text(
                        'MUNDAY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 160,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [_authBg, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _slides[_currentSlide].title,
                            key: ValueKey(_currentSlide),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            _slides[_currentSlide].subtitle,
                            key: ValueKey('sub$_currentSlide'),
                            style: const TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: List.generate(_slides.length, (i) {
                            final active = i == _currentSlide;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.only(right: 6),
                              width: active ? 20 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: active ? _authAccent : const Color(0xFF555555),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'เบอร์โทรศัพท์',
                      style: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: _authPanel,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _errorMessage != null
                              ? Colors.redAccent
                              : _authBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 16),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: _authBorder),
                              ),
                            ),
                            child: const Text(
                              '+66',
                              style: TextStyle(
                                color: _authAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              focusNode: _phoneFocusNode,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: '0812345678',
                                hintStyle:
                                    TextStyle(color: Color(0xFF555555)),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 14),
                              ),
                              onChanged: (_) {
                                if (_errorMessage != null) {
                                  setState(() => _errorMessage = null);
                                }
                              },
                              onSubmitted: (_) => _sendOtp(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 8),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _sendOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _authAccent,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: _authAccentDark,
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
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'ส่ง OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'ระบบจะส่งรหัส OTP ไปยังเบอร์โทรของคุณ\nรหัสมีอายุ 5 นาที',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_SlideData slide) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          slide.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFF1A1A1A),
            child: const Icon(Icons.nightlife,
                color: Color(0xFF444444), size: 80),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x66000000),
                Color(0xCC120607),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SlideData {
  final String image;
  final String title;
  final String subtitle;
  const _SlideData(
      {required this.image, required this.title, required this.subtitle});
}
