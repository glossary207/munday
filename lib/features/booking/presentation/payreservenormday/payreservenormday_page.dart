import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase_helper.dart';
import 'payreservenormday_model.dart';

export 'payreservenormday_model.dart';

class PayreservenormdayPage extends ConsumerStatefulWidget {
  const PayreservenormdayPage({
    super.key,
    this.venueId,
    this.date,
    this.tableIds = const [],
    this.amount,
    this.partySize,
  });

  final String? venueId;
  final DateTime? date;
  final List<String> tableIds;
  final double? amount;
  final int? partySize;

  static const String routeName = 'payreservenormday';
  static const String routePath = 'payreservenormday';

  @override
  ConsumerState<PayreservenormdayPage> createState() =>
      _PayreservenormdayPageState();
}

class _PayreservenormdayPageState extends ConsumerState<PayreservenormdayPage> {
  late final PayreservenormdayModel _model;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _partySizeController = TextEditingController();

  bool _loading = true;
  bool _submitting = false;
  Object? _error;
  Map<String, dynamic>? _activeReservation;
  XFile? _slip;
  String _venueName = '';
  String _promptPay = '';
  String? _submittedBillId;
  double? _serverAmount;
  int _minimumPartySize = 1;
  int _maximumPartySize = 0;

  String get _dateString {
    final date = widget.date;
    if (date == null) return '';
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  void initState() {
    super.initState();
    _model = PayreservenormdayModel()..internalInit(context);
    _partySizeController.text = (widget.partySize ?? 1)
        .clamp(1, 999)
        .toString();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadReservation());
  }

  @override
  void dispose() {
    _partySizeController.dispose();
    _model.dispose();
    super.dispose();
  }

  Future<void> _loadReservation() async {
    final venueId = widget.venueId;
    if (venueId == null ||
        venueId.isEmpty ||
        widget.date == null ||
        widget.tableIds.isEmpty ||
        currentUserUid.isEmpty) {
      setState(() {
        _loading = false;
        _error = StateError('ข้อมูลการจองไม่ครบ กรุณากลับไปเลือกโต๊ะใหม่');
      });
      return;
    }

    try {
      final results = await Future.wait([
        SupabaseHelper.getActiveReservation(
          venueId: venueId,
          date: _dateString,
          userId: currentUserUid,
        ),
        SupabaseHelper.query(
          'venues',
          equals: {'id': venueId},
          columns: 'venue_name,promptpay',
        ),
        SupabaseHelper.getReservationPaymentQuote(
          venueId: venueId,
          date: _dateString,
        ),
      ]);
      final reservation = results[0] as Map<String, dynamic>?;
      if (reservation == null) {
        throw StateError('ไม่พบรายการจองที่ยังใช้งานอยู่');
      }
      final quote = results[2] as Map<String, dynamic>;
      final serverTableIds = (quote['table_ids'] as List? ?? const [])
          .map((value) => value.toString())
          .toSet();
      if (serverTableIds.length != widget.tableIds.toSet().length ||
          !serverTableIds.containsAll(widget.tableIds)) {
        throw StateError('รายการโต๊ะเปลี่ยนแปลง กรุณากลับไปตรวจสอบอีกครั้ง');
      }
      final venueRows = results[1] as List<Map<String, dynamic>>;
      final venue = venueRows.isEmpty
          ? const <String, dynamic>{}
          : venueRows.first;
      final minimumPartySize = _asInt(
        quote['minimum_party_size'],
      ).clamp(1, 999).toInt();
      final maximumPartySize = _asInt(quote['maximum_party_size']);
      if (!mounted) return;
      setState(() {
        _activeReservation = reservation;
        if (reservation['status'] == 'payment_pending') {
          _submittedBillId =
              reservation['bill_id']?.toString() ?? 'กำลังตรวจสอบ';
        }
        _venueName = (venue['venue_name'] ?? '').toString();
        _promptPay = (venue['promptpay'] ?? '').toString();
        _serverAmount = _asDouble(quote['amount']);
        _minimumPartySize = minimumPartySize;
        _maximumPartySize = maximumPartySize;
        final currentPartySize = int.tryParse(_partySizeController.text) ?? 1;
        if (currentPartySize < minimumPartySize) {
          _partySizeController.text = minimumPartySize.toString();
        }
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  Future<void> _pickSlip() async {
    final slip = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
      maxWidth: 2400,
    );
    if (slip == null || !mounted) return;
    final extension = slip.name.contains('.')
        ? slip.name.split('.').last.toLowerCase()
        : '';
    const allowedExtensions = {'jpg', 'jpeg', 'png', 'webp'};
    if (!allowedExtensions.contains(extension)) {
      _showMessage('รองรับสลิปชนิด JPG, PNG หรือ WebP เท่านั้น');
      return;
    }
    setState(() => _slip = slip);
  }

  Future<void> _submitPayment() async {
    if (_submitting) return;
    final slip = _slip;
    final partySize = int.tryParse(_partySizeController.text);
    if (slip == null) {
      _showMessage('กรุณาแนบสลิปการชำระเงิน');
      return;
    }
    if (partySize == null || partySize < 1) {
      _showMessage('กรุณาระบุจำนวนผู้เข้าร่วมให้ถูกต้อง');
      return;
    }
    if (partySize < _minimumPartySize) {
      _showMessage('จำนวนผู้เข้าร่วมขั้นต่ำคือ $_minimumPartySize คน');
      return;
    }
    if (_maximumPartySize > 0 && partySize > _maximumPartySize) {
      _showMessage('จำนวนผู้เข้าร่วมสูงสุดคือ $_maximumPartySize คน');
      return;
    }

    setState(() => _submitting = true);
    String? uploadedPath;
    try {
      final extension = slip.name.contains('.')
          ? slip.name.split('.').last.toLowerCase()
          : 'jpg';
      final contentType = switch (extension) {
        'png' => 'image/png',
        'webp' => 'image/webp',
        _ => 'image/jpeg',
      };
      uploadedPath = '$currentUserUid/${const Uuid().v4()}.$extension';
      final bytes = await slip.readAsBytes();
      await SupabaseHelper.client.storage
          .from('reservation-slips')
          .uploadBinary(
            uploadedPath,
            bytes,
            fileOptions: FileOptions(contentType: contentType, upsert: false),
          );

      final result = await SupabaseHelper.submitReservationPayment(
        venueId: widget.venueId!,
        date: _dateString,
        tableIds: widget.tableIds,
        partySize: partySize,
        slipPath: uploadedPath,
      );
      if (!mounted) return;
      setState(() {
        _submittedBillId = result['reservation_bill_id']?.toString();
        _serverAmount = _asDouble(result['amount']);
        _activeReservation = {
          ...?_activeReservation,
          'status': 'payment_pending',
        };
      });
    } catch (error) {
      if (uploadedPath != null) {
        try {
          await SupabaseHelper.client.storage.from('reservation-slips').remove([
            uploadedPath,
          ]);
        } catch (_) {}
      }
      if (mounted) _showMessage('ส่งข้อมูลการชำระเงินไม่สำเร็จ: $error');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  int _asInt(Object? value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  double _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('ยืนยันและชำระค่าจอง'),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? _ErrorState(error: _error!, onRetry: _loadReservation)
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    _venueName.isEmpty ? 'รายการจองโต๊ะ' : _venueName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SummaryRow(label: 'วันที่', value: _dateString),
                  _SummaryRow(label: 'โต๊ะ', value: widget.tableIds.join(', ')),
                  _SummaryRow(
                    label: 'ยอดชำระ',
                    value:
                        '${(_serverAmount ?? widget.amount ?? 0).toStringAsFixed(2)} บาท',
                  ),
                  if (_maximumPartySize > 0)
                    _SummaryRow(
                      label: 'จำนวนคน',
                      value: '$_minimumPartySize–$_maximumPartySize คน',
                    ),
                  if (_promptPay.isNotEmpty)
                    _SummaryRow(label: 'PromptPay', value: _promptPay),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _partySizeController,
                    keyboardType: TextInputType.number,
                    enabled: _submittedBillId == null,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'จำนวนผู้เข้าร่วม',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_submittedBillId == null) ...[
                    OutlinedButton.icon(
                      onPressed: _submitting ? null : _pickSlip,
                      icon: const Icon(Icons.receipt_long),
                      label: Text(
                        _slip == null ? 'แนบสลิปการชำระเงิน' : _slip!.name,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _submitting ? null : _submitPayment,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size.fromHeight(52),
                      ),
                      child: _submitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('ส่งสลิปเพื่อรอตรวจสอบ'),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.hourglass_top_rounded,
                      color: Colors.orange,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'ได้รับสลิปแล้ว กำลังรอระบบตรวจสอบ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'เลขที่รายการ: $_submittedBillId',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(label, style: const TextStyle(color: Colors.white60)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('ลองใหม่')),
          ],
        ),
      ),
    );
  }
}
