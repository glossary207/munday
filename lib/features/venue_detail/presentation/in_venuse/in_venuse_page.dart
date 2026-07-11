import 'package:munday/core/theme/theme.dart';
import 'package:provider/provider.dart';

import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/media/allphoto_widget.dart';
import '/shared/widgets/layout/appbarsilver_widget.dart';
import '/shared/widgets/maps/popupmap_widget.dart';
import '/shared/widgets/media/poster_present_widget.dart';
import '/shared/widgets/misc/review_widget.dart';
import '/shared/widgets/misc/reviewgive_widget.dart';
import '/shared/widgets/misc/rowpromotion_widget.dart';
import '/shared/widgets/cards/showpeople_widget.dart';
import '/shared/widgets/media/showphoto_widget.dart';
import '/shared/widgets/media/story_view_widget.dart';
import '/shared/widgets/dialogs/youarenothere_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_video_player.dart';
import 'dart:math' as math;
import 'dart:ui';
import '/core/utils/index.dart' as actions;
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart' hide ScaleEffect;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:munday/core/routing/serialization_util.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate/flutter_animate.dart' as flutter_animate_lib;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'in_venuse_model.dart';
export 'in_venuse_model.dart';
part 'components/in_venuse_header_widget.dart';
part 'components/in_venuse_tabs_widget.dart';

const _kInVenuseFallbackPosterUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';
const _supportsVenueFavorites = false;
const _supportsVenueGroupInvites = false;
const _venuePresenceCollection = 'user_in_venues';
const _venueCheckInRadius = 10000000000000.0;

class InVenusePage extends ConsumerStatefulWidget {
  const InVenusePage({
    super.key,
    this.idVenues,
    this.distance,
    this.dateclick,
    required this.index,
  });

  final SupabaseDocRef? idVenues;
  final String? distance;
  final DateTime? dateclick;
  final int? index;

  static String routeName = 'InVenuse';
  static String routePath = 'inVenuse';

  @override
  ConsumerState<InVenusePage> createState() => _InVenuseWidgetState();
}

class _InVenuseWidgetState extends ConsumerState<InVenusePage>
    with TickerProviderStateMixin {
  late InVenuseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;
  double _scrollOffset = 0.0;
  bool _videoCompleted = false;

  final animationsMap = <String, AnimationInfo>{};

  Widget _buildVenueLoadError(
    BuildContext context, {
    String title = 'โหลดหน้าร้านไม่สำเร็จ',
    String message = 'ตรวจสอบอินเทอร์เน็ตแล้วลองใหม่อีกครั้ง',
    IconData icon = Icons.wifi_off_rounded,
  }) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 36.0),
                const SizedBox(height: 12.0),
                Text(
                  title,
                  style: MundayTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  message,
                  style: MundayTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.openSans(
                      fontWeight: MundayTheme.of(context).bodyMedium.fontWeight,
                      fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: const Color(0xFFB3B3B3),
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: MundayTheme.of(context).bodyMedium.fontWeight,
                    fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _hasValidNetworkImageUrl(String? url) {
    final normalized = url?.trim();
    if (normalized == null || normalized.isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(normalized);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  ImageProvider? _networkImageProviderOrNull(String? url) {
    if (!_hasValidNetworkImageUrl(url)) {
      return null;
    }
    return NetworkImage(url!.trim());
  }

  String _safeNetworkImageUrl(String? url, {required String fallback}) {
    if (_hasValidNetworkImageUrl(url)) {
      return url!.trim();
    }
    return fallback;
  }

  void _showSchemaUnavailableMessage(
    BuildContext context, {
    required String feature,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$feature ยังไม่รองรับใน schema ปัจจุบัน')),
      );
  }

  Stream<List<Map<String, dynamic>>> _streamVenuePresenceRows(String venueId) {
    return Supabase.instance.client
        .from(_venuePresenceCollection)
        .stream(primaryKey: ['id'])
        .eq('venue_id', venueId)
        .order('created_time', ascending: false)
        .map(
          (rows) => rows
              .map((row) => Map<String, dynamic>.from(row))
              .toList(growable: false),
        );
  }

  List<String> _distinctVenueMemberIds(List<Map<String, dynamic>> rows) {
    final orderedIds = <String>[];
    final seen = <String>{};

    for (final row in rows) {
      final userId = row['user_id']?.toString().trim();
      if (userId == null || userId.isEmpty || !seen.add(userId)) {
        continue;
      }
      orderedIds.add(userId);
    }

    return orderedIds;
  }

  Future<List<UsersRecord>> _loadVenueMemberUsers(List<String> userIds) async {
    if (userIds.isEmpty) {
      return const [];
    }

    final users = await queryUsersRecordOnce(
      queryBuilder: (q) => q.where('id', whereIn: userIds),
    );
    final usersById = {for (final user in users) user.reference.id: user};

    return userIds
        .map((userId) => usersById[userId])
        .whereType<UsersRecord>()
        .toList(growable: false);
  }

  List<PromotionDataSubStruct> _resolvedVenuePromotions(VenuesRecord venue) {
    if (venue.listpromotion.isNotEmpty) {
      final validLegacyPromotions = venue.listpromotion
          .where((promotion) => _hasValidNetworkImageUrl(promotion.photo))
          .toList(growable: false);
      if (validLegacyPromotions.isNotEmpty) {
        return validLegacyPromotions;
      }
    }

    return venue.promotion
        .where(_hasValidNetworkImageUrl)
        .map(
          (photoUrl) => PromotionDataSubStruct(
            photo: photoUrl.trim(),
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true,
          ),
        )
        .toList(growable: false);
  }

  List<String> _resolvedVenuePhotoUrls(VenuesRecord venue) {
    return venue.photos
        .where(_hasValidNetworkImageUrl)
        .map((photoUrl) => photoUrl.trim())
        .toList(growable: false);
  }

  Future<void> _showVenuePhotoSheet(
    BuildContext context,
    VenuesRecord venue,
    int index,
  ) async {
    final photoUrls = _resolvedVenuePhotoUrls(venue);
    if (index < 0 || index >= photoUrls.length) {
      return;
    }

    final orderedPhotos = List<String>.from(photoUrls);
    final selectedPhoto = orderedPhotos.removeAt(index);
    orderedPhotos.insert(0, selectedPhoto);

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: ShowphotoWidget(photo: orderedPhotos),
          ),
        );
      },
    ).then((value) => safeSetState(() {}));
  }

  Widget _buildVenuePhotoTile(
    BuildContext context,
    VenuesRecord venue,
    int index,
  ) {
    final photoUrls = _resolvedVenuePhotoUrls(venue);
    final photoUrl = index < photoUrls.length ? photoUrls[index] : null;
    final tileWidth = MediaQuery.sizeOf(context).width * 0.33;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: photoUrl == null
          ? null
          : () => _showVenuePhotoSheet(context, venue, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: photoUrl != null
            ? Image.network(
                photoUrl,
                width: tileWidth,
                height: MediaQuery.sizeOf(context).height * 1.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: const Color(0xFF1A1A1A)),
              )
            : Container(width: tileWidth, color: const Color(0xFF1A1A1A)),
      ),
    );
  }

  Widget _buildVenuePhotoGrid(BuildContext context, VenuesRecord venue) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gridHeight =
            constraints.maxHeight.isFinite && constraints.maxHeight > 0.0
            ? constraints.maxHeight
            : 260.0;
        final rowHeight = (gridHeight - 1.0) / 2;

        return SizedBox(
          height: gridHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: rowHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => _buildVenuePhotoTile(context, venue, index),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  1.0,
                  0.0,
                  0.0,
                ),
                child: SizedBox(
                  height: rowHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) =>
                          _buildVenuePhotoTile(context, venue, index + 3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _canCheckInToVenue(VenuesRecord venue) {
    if (venue.position == null || _model.location == null) {
      return true;
    }

    return functions.check2position(
          _model.location,
          venue.position,
          _venueCheckInRadius,
        ) ??
        true;
  }

  Future<void> _showNotAtVenueSheet(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: const YouarenothereWidget(poperror: false),
          ),
        );
      },
    ).then((value) => safeSetState(() {}));
  }

  Future<void> _handleVenueCheckIn(
    BuildContext context,
    VenuesRecord venue,
  ) async {
    if (currentUser == null || currentUserReference == null) {
      context.pushNamed(PhoneLoginPage.routeName);
      return;
    }

    if (!_canCheckInToVenue(venue)) {
      await _showNotAtVenueSheet(context);
      return;
    }

    final existingRows = await Supabase.instance.client
        .from(_venuePresenceCollection)
        .select('id')
        .eq('venue_id', venue.reference.id)
        .eq('user_id', currentUserReference!.id)
        .limit(1);

    final alreadyCheckedIn = existingRows.isNotEmpty;
    if (alreadyCheckedIn) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('คุณเช็กอินร้านนี้แล้ว')));
      return;
    }

    await Supabase.instance.client.from(_venuePresenceCollection).insert({
      'user_id': currentUserReference!.id,
      'venue_id': venue.reference.id,
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('เช็กอินเรียบร้อย')));
  }

  Widget _buildVenueMemberTile(BuildContext context, UsersRecord user) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.21,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.17,
            height: MediaQuery.sizeOf(context).width * 0.17,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999.0),
              child: Image.network(
                _safeNetworkImageUrl(
                  user.photoUrl,
                  fallback: _kInVenuseFallbackPosterUrl,
                ),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: const Color(0xFF1A1A1A)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                user.displayName,
                'Member',
              ).maybeHandleOverflow(maxChars: 12),
              textAlign: TextAlign.center,
              style: MundayTheme.of(context).bodyMedium.override(
                font: GoogleFonts.openSans(
                  fontWeight: MundayTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                ),
                fontSize: 10.0,
                letterSpacing: 0.0,
                fontWeight: MundayTheme.of(context).bodyMedium.fontWeight,
                fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVenueAudienceSection(
    BuildContext context,
    VenuesRecord venue,
    DateTime selectedDate,
  ) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _streamVenuePresenceRows(venue.reference.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D0D0D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 28.0, 24.0, 170.0),
              child: Text(
                'โหลดข้อมูลสมาชิกในร้านไม่สำเร็จ',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D0D0D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 190.0),
              child: Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFFF0000),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        final rows = snapshot.data!;
        final memberIds = _distinctVenueMemberIds(rows);
        final currentUserId = currentUserReference?.id;
        final hasCheckedIn =
            currentUserId != null && memberIds.contains(currentUserId);

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF0D0D0D),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  15.0,
                  0.0,
                  0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        25.0,
                        0.0,
                        0.0,
                        3.0,
                      ),
                      child: Text(
                        valueOrDefault<String>(
                          functions.month(selectedDate),
                          'ไม่ระบุ',
                        ),
                        style: MundayTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontStyle: MundayTheme.of(
                              context,
                            ).bodyMedium.fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: MundayTheme.of(
                            context,
                          ).bodyMedium.fontStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        25.0,
                        0.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${venue.capacity}',
                            style: MundayTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w500,
                                fontStyle: MundayTheme.of(
                                  context,
                                ).bodyMedium.fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: MundayTheme.of(
                                context,
                              ).bodyMedium.fontStyle,
                            ),
                          ),
                          Text(
                            ' / ${venue.maxCapacity}',
                            style: MundayTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w500,
                                fontStyle: MundayTheme.of(
                                  context,
                                ).bodyMedium.fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: MundayTheme.of(
                                context,
                              ).bodyMedium.fontStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0,
                              0.0,
                              0.0,
                              0.0,
                            ),
                            child: Icon(
                              Icons.people_rounded,
                              color: MundayTheme.of(context).primaryText,
                              size: 25.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0,
                              0.0,
                              0.0,
                              0.0,
                            ),
                            child: Text(
                              memberIds.length.toString(),
                              style: MundayTheme.of(context).bodyMedium
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: MundayTheme.of(
                                        context,
                                      ).bodyMedium.fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: MundayTheme.of(
                                      context,
                                    ).bodyMedium.fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  15.0,
                  7.0,
                  15.0,
                  0.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: custom_widgets.Calendarslide(
                    width: 45.0,
                    height: 75.0,
                    colorPicker: const Color(0xFFFF0000),
                    icon: const Icon(
                      Icons.star_rate,
                      color: Color(0xFFFF0000),
                      size: 15.0,
                    ),
                    dateNow: getCurrentTimestamp,
                    dateclickwidget: selectedDate,
                    dateEvent: venue.dateEvents,
                    onselect: () async {
                      safeSetState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  25.0,
                  10.0,
                  25.0,
                  8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Check in',
                      style: MundayTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontStyle: MundayTheme.of(
                            context,
                          ).bodyMedium.fontStyle,
                        ),
                        color: MundayTheme.of(context).primaryBtnText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: MundayTheme.of(context).bodyMedium.fontStyle,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => _handleVenueCheckIn(context, venue),
                      child: Container(
                        decoration: BoxDecoration(
                          color: hasCheckedIn
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF58BB2F),
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0,
                            3.0,
                            12.0,
                            5.0,
                          ),
                          child: Text(
                            hasCheckedIn ? 'checked in' : 'check in',
                            style: MundayTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontStyle: MundayTheme.of(
                                  context,
                                ).bodyMedium.fontStyle,
                              ),
                              color: MundayTheme.of(context).primaryText,
                              fontSize: 12.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: MundayTheme.of(
                                context,
                              ).bodyMedium.fontStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  14.0,
                  8.0,
                  14.0,
                  150.0,
                ),
                child: FutureBuilder<List<UsersRecord>>(
                  future: _loadVenueMemberUsers(memberIds),
                  builder: (context, usersSnapshot) {
                    if (usersSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Center(
                          child: SizedBox(
                            width: 32.0,
                            height: 32.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFF0000),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final users = usersSnapshot.data ?? const <UsersRecord>[];
                    if (users.isEmpty) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0,
                          12.0,
                          0.0,
                          0.0,
                        ),
                        child: Text(
                          'ยังไม่มีคนเช็กอินร้านนี้',
                          textAlign: TextAlign.center,
                          style: MundayTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontStyle: MundayTheme.of(
                                context,
                              ).bodyMedium.fontStyle,
                            ),
                            color: const Color(0xFFB3B3B3),
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: MundayTheme.of(
                              context,
                            ).bodyMedium.fontStyle,
                          ),
                        ),
                      );
                    }

                    return Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 16.0,
                      spacing: 8.0,
                      children: users
                          .map((user) => _buildVenueMemberTile(context, user))
                          .toList(growable: false),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _model = InVenuseModel()..internalInit(context);
    context.appState.dateclick ??=
        widget.dateclick ??
        functions.boxstarttime(getCurrentTimestamp) ??
        getCurrentTimestamp;

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue = await getCurrentUserLocation(
        defaultLocation: const LatLng(0.0, 0.0),
      );
      if (widget.dateclick != null) {
        context.appState.dateclick = widget.dateclick;
        safeSetState(() {});
      } else {
        context.appState.dateclick = functions.boxstarttime(
          getCurrentTimestamp,
        );
        safeSetState(() {});
      }

      safeSetState(() {
        _model.tabBarController!.animateTo(
          widget.index ?? 0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });

      _model.zoom = false;
      _model.location = currentUserLocationValue;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    animationsMap.addAll({
      'iconOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShakeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            hz: 10,
            offset: const Offset(0.0, 0.0),
            rotation: 0.087,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 330.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          flutter_animate_lib.ScaleEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 330.0.ms,
            begin: const Offset(0.7, 0.7),
            end: const Offset(1.0, 1.0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 330.0.ms,
            begin: const Offset(0.0, 100.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where(
        (anim) =>
            anim.trigger == AnimationTrigger.onActionTrigger ||
            !anim.applyInitialState,
      ),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    final selectedDate =
        context.appState.dateclick ??
        widget.dateclick ??
        functions.boxstarttime(getCurrentTimestamp) ??
        getCurrentTimestamp;

    if (widget.idVenues == null) {
      return _buildVenueLoadError(
        context,
        title: 'ไม่พบข้อมูลร้าน',
        message: 'ลิงก์ร้านไม่ถูกต้องหรือข้อมูลร้านถูกลบไปแล้ว',
        icon: Icons.storefront_outlined,
      );
    }

    return StreamBuilder<VenuesRecord>(
      stream: VenuesRecord.getDocument(widget.idVenues!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildVenueLoadError(context);
        }

        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          );
        }

        final inVenuseVenuesRecord = snapshot.data!;
        final venueBgImage = _networkImageProviderOrNull(
          inVenuseVenuesRecord.bg,
        );
        final venueLogoImage = _networkImageProviderOrNull(
          inVenuseVenuesRecord.logo,
        );
        final fadeFactor = (1.0 - (_scrollOffset / 250.0)).clamp(0.0, 1.0);

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.axis == Axis.vertical) {
                        final newOffset = notification.metrics.pixels;
                        if ((newOffset - _scrollOffset).abs() > 5.0 ||
                            newOffset <= 0.0) {
                          setState(() {
                            _scrollOffset = newOffset;
                          });
                        }
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InVenuseHeaderWidget(
                            model: _model,
                            inVenuseVenuesRecord: inVenuseVenuesRecord,
                            venueBgImage: venueBgImage,
                            venueLogoImage: venueLogoImage,
                            fadeFactor: fadeFactor,
                            videoCompleted: _videoCompleted,
                            onVideoCompleted: () {
                              if (mounted) {
                                setState(() {
                                  _videoCompleted = true;
                                });
                              }
                            },
                            animationsMap: animationsMap,
                            onStateChanged: () => safeSetState(() {}),
                          ),
                          InVenuseTabsWidget(
                            model: _model,
                            inVenuseVenuesRecord: inVenuseVenuesRecord,
                            animationsMap: animationsMap,
                            currentUserLocationValue: currentUserLocationValue,
                            onStateChanged: () => safeSetState(() {}),
                            venueAudienceSection: _buildVenueAudienceSection(
                              context,
                              inVenuseVenuesRecord,
                              DateTime.now() ?? DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.1, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 130.0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Color(0x9A000000),
                                  Colors.black,
                                ],
                                stops: [0.0, 0.5, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                            ),
                          ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation1']!,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                30.0,
                              ),
                              child: Container(
                                height: 65.0,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: Color(0x33000000),
                                      offset: Offset(0.0, 2.0),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(45.0),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                3.0,
                                                6.0,
                                                3.0,
                                              ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pop();
                                            },
                                            child: Container(
                                              width: 65.0,
                                              height: 65.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF121212),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: const Color(
                                                    0xFF343434,
                                                  ),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                      0.0,
                                                      0.0,
                                                    ),
                                                child: Icon(
                                                  Icons.arrow_back_ios_outlined,
                                                  color: MundayTheme.of(
                                                    context,
                                                  ).primaryText,
                                                  size: 28.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                const AlignmentDirectional(
                                                  0.0,
                                                  -1.0,
                                                ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                    2.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final isLoggedIn =
                                                      currentUser != null;
                                                  if (!isLoggedIn) {
                                                    context.pushNamed(
                                                      PhoneLoginPage.routeName,
                                                    );
                                                    return;
                                                  }
                                                  context.pushNamed(
                                                    BookingPage.routeName,
                                                    queryParameters: {
                                                      'id': serializeParam(
                                                        widget.idVenues,
                                                        ParamType
                                                            .SupabaseDocRef,
                                                      ),
                                                      'location':
                                                          serializeParam(
                                                            inVenuseVenuesRecord
                                                                .position,
                                                            ParamType.LatLng,
                                                          ),
                                                      'date': serializeParam(
                                                        widget.dateclick,
                                                        ParamType.DateTime,
                                                      ),
                                                      'currentuid':
                                                          serializeParam(
                                                            currentUserUid,
                                                            ParamType.String,
                                                          ),
                                                      'floorId': serializeParam(
                                                        '',
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(
                                                        context,
                                                      ).width *
                                                      1.0,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 5.0,
                                                        color: Color(
                                                          0x99000000,
                                                        ),
                                                        offset: Offset(
                                                          2.0,
                                                          2.0,
                                                        ),
                                                        spreadRadius: 4.0,
                                                      ),
                                                    ],
                                                    gradient: const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Color(0xFFC10000),
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            -1.0,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        0,
                                                        1.0,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          45.0,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional.fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Container(
                                                                    width: 35.0,
                                                                    height:
                                                                        35.0,
                                                                    decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image.network(
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/vkqck67kmjo7/22.png',
                                                                        ).image,
                                                                      ),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional.fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                    ),
                                                                child: Text(
                                                                  AppLocalizations.of(
                                                                    context,
                                                                  )!.k_ajawujz7,
                                                                  style: MundayTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        16.5,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle:
                                                                        MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
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
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                            1.0,
                                            -2.2,
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                  6.0,
                                                  3.0,
                                                  0.0,
                                                  3.0,
                                                ),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                final isLoggedIn =
                                                    currentUser != null;
                                                if (!isLoggedIn) {
                                                  context.pushNamed(
                                                    PhoneLoginPage.routeName,
                                                  );
                                                  return;
                                                }
                                                if (!_supportsVenueGroupInvites) {
                                                  _showSchemaUnavailableMessage(
                                                    context,
                                                    feature: 'Invite',
                                                  );
                                                  return;
                                                }
                                                var groupInviteRecordReference =
                                                    GroupInviteRecord.collection
                                                        .doc();
                                                await groupInviteRecordReference.set({
                                                  ...createGroupInviteRecordData(
                                                    nameGroup: '',
                                                    iDVenues: widget.idVenues,
                                                  ),
                                                  ...mapToSupabase({
                                                    'User_in_group': [
                                                      getUserInGroupInviteFirestoreData(
                                                        createUserInGroupInviteStruct(
                                                          username:
                                                              currentUserDisplayName,
                                                          uid:
                                                              currentUserReference,
                                                          photoPath:
                                                              currentUserPhoto,
                                                          status: 0,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        true,
                                                      ),
                                                    ],
                                                    'chat_room': [
                                                      getChatElementLivechatFirestoreData(
                                                        createChatElementLivechatStruct(
                                                          id: currentUserReference,
                                                          name:
                                                              currentUserDisplayName,
                                                          message:
                                                              currentUserDisplayName,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        true,
                                                      ),
                                                    ],
                                                  }),
                                                });
                                                _model
                                                    .idRefGroup = GroupInviteRecord.getDocumentFromData({
                                                  ...createGroupInviteRecordData(
                                                    nameGroup: '',
                                                    iDVenues: widget.idVenues,
                                                  ),
                                                  ...mapToSupabase({
                                                    'User_in_group': [
                                                      getUserInGroupInviteFirestoreData(
                                                        createUserInGroupInviteStruct(
                                                          username:
                                                              currentUserDisplayName,
                                                          uid:
                                                              currentUserReference,
                                                          photoPath:
                                                              currentUserPhoto,
                                                          status: 0,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        true,
                                                      ),
                                                    ],
                                                    'chat_room': [
                                                      getChatElementLivechatFirestoreData(
                                                        createChatElementLivechatStruct(
                                                          id: currentUserReference,
                                                          name:
                                                              currentUserDisplayName,
                                                          message:
                                                              currentUserDisplayName,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        true,
                                                      ),
                                                    ],
                                                  }),
                                                }, groupInviteRecordReference);

                                                await currentUserReference!
                                                    .update(
                                                      createUsersRecordData(
                                                        groupInviteID: _model
                                                            .idRefGroup
                                                            ?.reference,
                                                      ),
                                                    );

                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: 65.0,
                                                height: 65.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFF121212,
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 5.0,
                                                      color: Color(0x99000000),
                                                      offset: Offset(2.0, 2.0),
                                                      spreadRadius: 4.0,
                                                    ),
                                                  ],
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFF343434,
                                                    ),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              20.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.k_4cfjxu9d,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: MundayTheme.of(context).bodyMedium.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  MundayTheme.of(
                                                                        context,
                                                                      )
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 10.0,
                                                            letterSpacing: 0.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                MundayTheme.of(
                                                                      context,
                                                                    )
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            1.2,
                                                            -1.2,
                                                          ),
                                                      child: Container(
                                                        width: 22.0,
                                                        height: 22.0,
                                                        decoration: BoxDecoration(
                                                          color: const Color(
                                                            0xFF00B42C,
                                                          ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: Color(
                                                                0xAC000000,
                                                              ),
                                                              offset: Offset(
                                                                -3.0,
                                                                3.0,
                                                              ),
                                                            ),
                                                          ],
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: const Color(
                                                              0xFF121212,
                                                            ),
                                                            width: 2.2,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.add_outlined,
                                                          color: MundayTheme.of(
                                                            context,
                                                          ).primaryText,
                                                          size: 15.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              15.0,
                                                            ),
                                                        child: Icon(
                                                          Icons.people,
                                                          color: MundayTheme.of(
                                                            context,
                                                          ).primaryText,
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_supportsVenueGroupInvites &&
                    currentUserDocument?.groupInviteID != null)
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => StreamBuilder<GroupInviteRecord>(
                        stream: GroupInviteRecord.getDocument(
                          currentUserDocument!.groupInviteID!,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.transparent,
                                  ),
                                ),
                              ),
                            );
                          }

                          final columnGroupInviteRecord = snapshot.data!;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 320.0,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Color(0xDF000000),
                                      Colors.black,
                                    ],
                                    stops: [0.0, 0.2, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 55.0,
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              15.0,
                                              0.0,
                                              15.0,
                                              0.0,
                                            ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 40.0,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF2C2C2C),
                                                      Color(0xFF1C1C1C),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              90.0,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        topLeft:
                                                            Radius.circular(
                                                              90.0,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              2.0,
                                                            ),
                                                        child: ClipRRect(
                                                          borderRadius: const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                          ),
                                                          child:
                                                              inVenuseVenuesRecord
                                                                  .bg
                                                                  .isNotEmpty
                                                              ? Image.network(
                                                                  inVenuseVenuesRecord
                                                                      .bg,
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorBuilder:
                                                                      (
                                                                        context,
                                                                        error,
                                                                        stackTrace,
                                                                      ) => Container(
                                                                        color: const Color(
                                                                          0xFF1A1A1A,
                                                                        ),
                                                                      ),
                                                                )
                                                              : Container(
                                                                  color: const Color(
                                                                    0xFF1A1A1A,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        image:
                                                            inVenuseVenuesRecord
                                                                .bg
                                                                .isNotEmpty
                                                            ? DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                  inVenuseVenuesRecord
                                                                      .bg,
                                                                ),
                                                              )
                                                            : null,
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                sigmaX: 50.0,
                                                                sigmaY: 20.0,
                                                              ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.only(
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      90.0,
                                                                    ),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                                topLeft:
                                                                    Radius.circular(
                                                                      90.0,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                              ),
                                                              border: Border.all(
                                                                color:
                                                                    const Color(
                                                                      0xFF1D1D1D,
                                                                    ),
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.check_rounded,
                                                            color: Color(
                                                              0xFF58BB2F,
                                                            ),
                                                            size: 20.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  6.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_f56db5sz,
                                                              style: MundayTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    MundayTheme.of(
                                                                          context,
                                                                        )
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 2.0,
                                              height: 40.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                height: 40.0,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF2C2C2C),
                                                      Color(0xFF1C1C1C),
                                                    ],
                                                    stops: [0.0, 1.0],
                                                    begin: AlignmentDirectional(
                                                      0.0,
                                                      -1.0,
                                                    ),
                                                    end: AlignmentDirectional(
                                                      0,
                                                      1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        topLeft:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                      ),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              2.0,
                                                            ),
                                                        child: ClipRRect(
                                                          borderRadius: const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                          ),
                                                          child:
                                                              inVenuseVenuesRecord
                                                                  .bg
                                                                  .isNotEmpty
                                                              ? Image.network(
                                                                  inVenuseVenuesRecord
                                                                      .bg,
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorBuilder:
                                                                      (
                                                                        context,
                                                                        error,
                                                                        stackTrace,
                                                                      ) => Container(
                                                                        color: const Color(
                                                                          0xFF1A1A1A,
                                                                        ),
                                                                      ),
                                                                )
                                                              : Container(
                                                                  color: const Color(
                                                                    0xFF1A1A1A,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                            ),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                sigmaX: 50.0,
                                                                sigmaY: 20.0,
                                                              ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.only(
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                                topLeft:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                                topRight:
                                                                    Radius.circular(
                                                                      0.0,
                                                                    ),
                                                              ),
                                                              border: Border.all(
                                                                color:
                                                                    const Color(
                                                                      0xFF1D1D1D,
                                                                    ),
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .question_mark_rounded,
                                                            color:
                                                                MundayTheme.of(
                                                                  context,
                                                                ).warning,
                                                            size: 17.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_ifymhz2z,
                                                              style: MundayTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    MundayTheme.of(
                                                                          context,
                                                                        )
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 2.0,
                                              height: 40.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.ononvite = false;
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  height: 40.0,
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF2C2C2C),
                                                        Color(0xFF1C1C1C),
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            -1.0,
                                                          ),
                                                      end: AlignmentDirectional(
                                                        0,
                                                        1.0,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                90.0,
                                                              ),
                                                          topLeft:
                                                              Radius.circular(
                                                                0.0,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                90.0,
                                                              ),
                                                        ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Opacity(
                                                        opacity: 0.4,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                2.0,
                                                              ),
                                                          child: ClipRRect(
                                                            borderRadius: const BorderRadius.only(
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                              topLeft:
                                                                  Radius.circular(
                                                                    0.0,
                                                                  ),
                                                              topRight:
                                                                  Radius.circular(
                                                                    90.0,
                                                                  ),
                                                            ),
                                                            child:
                                                                inVenuseVenuesRecord
                                                                    .bg
                                                                    .isNotEmpty
                                                                ? Image.network(
                                                                    inVenuseVenuesRecord
                                                                        .bg,
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder:
                                                                        (
                                                                          context,
                                                                          error,
                                                                          stackTrace,
                                                                        ) => Container(
                                                                          color: const Color(
                                                                            0xFF1A1A1A,
                                                                          ),
                                                                        ),
                                                                  )
                                                                : Container(
                                                                    color: const Color(
                                                                      0xFF1A1A1A,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  90.0,
                                                                ),
                                                          ),
                                                          child: BackdropFilter(
                                                            filter:
                                                                ImageFilter.blur(
                                                                  sigmaX: 50.0,
                                                                  sigmaY: 20.0,
                                                                ),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                        90.0,
                                                                      ),
                                                                  topLeft:
                                                                      Radius.circular(
                                                                        0.0,
                                                                      ),
                                                                  topRight:
                                                                      Radius.circular(
                                                                        90.0,
                                                                      ),
                                                                ),
                                                                border: Border.all(
                                                                  color: const Color(
                                                                    0xFF1D1D1D,
                                                                  ),
                                                                  width: 1.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .close_rounded,
                                                              color: Color(
                                                                0xFFFF0000,
                                                              ),
                                                              size: 20.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    6.0,
                                                                    0.0,
                                                                    7.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_gkhwh8ji,
                                                                style: MundayTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle:
                                                                        MundayTheme.of(
                                                                          context,
                                                                        ).bodyMedium.fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      15.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        0.0,
                                        1.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 245.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF1C1C1C),
                                              Color(0xFF070707),
                                              Color(0xDA000000),
                                            ],
                                            stops: [0.0, 0.5, 1.0],
                                            begin: AlignmentDirectional(
                                              1.0,
                                              -0.34,
                                            ),
                                            end: AlignmentDirectional(
                                              -1.0,
                                              0.34,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Opacity(
                                              opacity: 0.4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                      0.0,
                                                      2.0,
                                                      0.0,
                                                      0.0,
                                                    ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        bottomRight:
                                                            Radius.circular(
                                                              0.0,
                                                            ),
                                                        topLeft:
                                                            Radius.circular(
                                                              20.0,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              20.0,
                                                            ),
                                                      ),
                                                  child:
                                                      inVenuseVenuesRecord
                                                          .bg
                                                          .isNotEmpty
                                                      ? Image.network(
                                                          inVenuseVenuesRecord
                                                              .bg,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) => Container(
                                                                color:
                                                                    const Color(
                                                                      0xFF1A1A1A,
                                                                    ),
                                                              ),
                                                        )
                                                      : Container(
                                                          color: const Color(
                                                            0xFF1A1A1A,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 0.3,
                                              child: Align(
                                                alignment:
                                                    const AlignmentDirectional(
                                                      1.0,
                                                      -1.0,
                                                    ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        2.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    decoration: const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFF1C1C1C),
                                                          Color(0xFF070707),
                                                          Color(0xDA000000),
                                                        ],
                                                        stops: [0.0, 0.5, 1.0],
                                                        begin:
                                                            AlignmentDirectional(
                                                              1.0,
                                                              -0.34,
                                                            ),
                                                        end:
                                                            AlignmentDirectional(
                                                              -1.0,
                                                              0.34,
                                                            ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            bottomRight:
                                                                Radius.circular(
                                                                  0.0,
                                                                ),
                                                            topLeft:
                                                                Radius.circular(
                                                                  20.0,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  20.0,
                                                                ),
                                                          ),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    1.0,
                                                    -1.0,
                                                  ),
                                              child: Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    -1.0,
                                                    0.0,
                                                  ),
                                              child: Container(
                                                width: 120.0,
                                                height: 120.0,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    0.0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    0.0,
                                                  ),
                                                  topLeft: Radius.circular(
                                                    20.0,
                                                  ),
                                                  topRight: Radius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(0.0),
                                                      bottomRight:
                                                          Radius.circular(0.0),
                                                      topLeft: Radius.circular(
                                                        20.0,
                                                      ),
                                                      topRight: Radius.circular(
                                                        20.0,
                                                      ),
                                                    ),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 50.0,
                                                    sigmaY: 20.0,
                                                  ),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    0.0,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    0.0,
                                                  ),
                                                  topLeft: Radius.circular(
                                                    20.0,
                                                  ),
                                                  topRight: Radius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  25.0,
                                                                  12.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_3kzdm2df,
                                                              style: MundayTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontWeight,
                                                                  fontStyle:
                                                                      MundayTheme.of(
                                                                        context,
                                                                      ).bodyMedium.fontStyle,
                                                                ),
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    MundayTheme.of(
                                                                          context,
                                                                        )
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                fontStyle:
                                                                    MundayTheme.of(
                                                                          context,
                                                                        )
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  8.0,
                                                                  15.0,
                                                                  4.0,
                                                                  0.0,
                                                                ),
                                                            child: Icon(
                                                              Icons.edit_sharp,
                                                              color:
                                                                  Colors.white,
                                                              size: 15.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  10.0,
                                                                  0.0,
                                                                ),
                                                            child: Container(
                                                              height: 25.0,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
                                                                      0x741D1D1D,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      90.0,
                                                                    ),
                                                                border: Border.all(
                                                                  color: const Color(
                                                                    0xC31D1D1D,
                                                                  ),
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional.fromSTEB(
                                                                      0.0,
                                                                      0.5,
                                                                      0.0,
                                                                      0.5,
                                                                    ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .swap_horiz,
                                                                        color: MundayTheme.of(
                                                                          context,
                                                                        ).primaryText,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            1.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_ffx98bbd,
                                                                        style:
                                                                            MundayTheme.of(
                                                                              context,
                                                                            ).bodyMedium.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.5,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: MundayTheme.of(
                                                                                context,
                                                                              ).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  10.0,
                                                                  0.0,
                                                                ),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await currentUserReference!.update({
                                                                  ...mapToSupabase({
                                                                    'Group_invite_ID':
                                                                        FieldValue.delete(),
                                                                  }),
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 25.0,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        90.0,
                                                                      ),
                                                                  border:
                                                                      Border.all(
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional.fromSTEB(
                                                                        0.0,
                                                                        0.5,
                                                                        0.0,
                                                                        0.5,
                                                                      ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          1.0,
                                                                        ),
                                                                        child: Text(
                                                                          AppLocalizations.of(
                                                                            context,
                                                                          )!.k_dvgerlhc,
                                                                          style:
                                                                              MundayTheme.of(
                                                                                context,
                                                                              ).bodyMedium.override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: MundayTheme.of(
                                                                                    context,
                                                                                  ).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Colors.black,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.5,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: MundayTheme.of(
                                                                                  context,
                                                                                ).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                          15.0,
                                                          20.0,
                                                          0.0,
                                                          0.0,
                                                        ),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                  ),
                                                              child: Container(
                                                                width: 70.0,
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                        child: Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 50.0,
                                                                              height: 50.0,
                                                                              child: custom_widgets.Containerborder(
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Text(
                                                                                AppLocalizations.of(
                                                                                  context,
                                                                                )!.k_eo1pf729,
                                                                                style:
                                                                                    MundayTheme.of(
                                                                                      context,
                                                                                    ).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: MundayTheme.of(
                                                                                          context,
                                                                                        ).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: MundayTheme.of(
                                                                                        context,
                                                                                      ).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                  ),
                                                              child: Builder(
                                                                builder: (context) {
                                                                  final friend =
                                                                      columnGroupInviteRecord
                                                                          .userInGroup
                                                                          .toList();

                                                                  return Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: List.generate(
                                                                      friend
                                                                          .length,
                                                                      (
                                                                        friendIndex,
                                                                      ) {
                                                                        final friendItem =
                                                                            friend[friendIndex];
                                                                        return Container(
                                                                          width:
                                                                              70.0,
                                                                          decoration: const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                          ),
                                                                          child: Align(
                                                                            alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(
                                                                                    0.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: const AlignmentDirectional(
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Container(
                                                                                          width: 50.0,
                                                                                          height: 50.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: const Color(
                                                                                              0xFF1D1D1D,
                                                                                            ),
                                                                                            image: friendItem.photoPath.isNotEmpty
                                                                                                ? DecorationImage(
                                                                                                    fit: BoxFit.cover,
                                                                                                    image: NetworkImage(
                                                                                                      friendItem.photoPath,
                                                                                                    ),
                                                                                                  )
                                                                                                : null,
                                                                                            shape: BoxShape.circle,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                          0.0,
                                                                                          8.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Text(
                                                                                          friendItem.username,
                                                                                          style:
                                                                                              MundayTheme.of(
                                                                                                context,
                                                                                              ).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: MundayTheme.of(
                                                                                                    context,
                                                                                                  ).bodyMedium.fontWeight,
                                                                                                  fontStyle: MundayTheme.of(
                                                                                                    context,
                                                                                                  ).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: 12.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: MundayTheme.of(
                                                                                                  context,
                                                                                                ).bodyMedium.fontWeight,
                                                                                                fontStyle: MundayTheme.of(
                                                                                                  context,
                                                                                                ).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(
                                                                                    1.0,
                                                                                    -1.0,
                                                                                  ),
                                                                                  child: Container(
                                                                                    width: 18.0,
                                                                                    height: 18.0,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Color(
                                                                                        0xFF58BB2F,
                                                                                      ),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: const Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Icon(
                                                                                        Icons.check_rounded,
                                                                                        color: Colors.white,
                                                                                        size: 14.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: 130.0,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              Color(0xEB000000),
                                                            ],
                                                            stops: [0.0, 1.0],
                                                            begin:
                                                                AlignmentDirectional(
                                                                  0.0,
                                                                  -1.0,
                                                                ),
                                                            end:
                                                                AlignmentDirectional(
                                                                  0,
                                                                  1.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                        animationsMap['containerOnPageLoadAnimation2']!,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                    0.0,
                                                    1.0,
                                                  ),
                                              child: Container(
                                                decoration:
                                                    const BoxDecoration(),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: 130.0,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration: const BoxDecoration(
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              Color(0x9A000000),
                                                              Colors.black,
                                                            ],
                                                            stops: [
                                                              0.0,
                                                              0.5,
                                                              1.0,
                                                            ],
                                                            begin:
                                                                AlignmentDirectional(
                                                                  0.0,
                                                                  -1.0,
                                                                ),
                                                            end:
                                                                AlignmentDirectional(
                                                                  0,
                                                                  1.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                        animationsMap['containerOnPageLoadAnimation3']!,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              1.0,
                                                            ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                10.0,
                                                                30.0,
                                                              ),
                                                          child: Container(
                                                            height: 65.0,
                                                            decoration: BoxDecoration(
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      4.0,
                                                                  color: Color(
                                                                    0x33000000,
                                                                  ),
                                                                  offset:
                                                                      Offset(
                                                                        0.0,
                                                                        2.0,
                                                                      ),
                                                                ),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    45.0,
                                                                  ),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            6.0,
                                                                            3.0,
                                                                          ),
                                                                      child: InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap: () async {
                                                                          context
                                                                              .pop();
                                                                        },
                                                                        child: Container(
                                                                          width:
                                                                              65.0,
                                                                          height:
                                                                              65.0,
                                                                          decoration: BoxDecoration(
                                                                            color: const Color(
                                                                              0xFF121212,
                                                                            ),
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            border: Border.all(
                                                                              color: const Color(
                                                                                0xFF343434,
                                                                              ),
                                                                              width: 2.0,
                                                                            ),
                                                                          ),
                                                                          child: Align(
                                                                            alignment: const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                            child: Icon(
                                                                              Icons.arrow_back_ios_outlined,
                                                                              color: MundayTheme.of(
                                                                                context,
                                                                              ).primaryText,
                                                                              size: 28.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: Align(
                                                                        alignment: const AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0,
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                          child: InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap: () async {
                                                                              final isLoggedIn =
                                                                                  currentUser !=
                                                                                  null;
                                                                              if (!isLoggedIn) {
                                                                                context.pushNamed(
                                                                                  PhoneLoginPage.routeName,
                                                                                );
                                                                                return;
                                                                              }
                                                                              context.pushNamed(
                                                                                BookingPage.routeName,
                                                                                queryParameters: {
                                                                                  'id': serializeParam(
                                                                                    widget.idVenues,
                                                                                    ParamType.SupabaseDocRef,
                                                                                  ),
                                                                                  'location': serializeParam(
                                                                                    inVenuseVenuesRecord.position,
                                                                                    ParamType.LatLng,
                                                                                  ),
                                                                                  'date': serializeParam(
                                                                                    widget.dateclick,
                                                                                    ParamType.DateTime,
                                                                                  ),
                                                                                  'currentuid': serializeParam(
                                                                                    currentUserUid,
                                                                                    ParamType.String,
                                                                                  ),
                                                                                  'floorId': serializeParam(
                                                                                    '',
                                                                                    ParamType.String,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );
                                                                            },
                                                                            child: Container(
                                                                              width:
                                                                                  MediaQuery.sizeOf(
                                                                                    context,
                                                                                  ).width *
                                                                                  1.0,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    blurRadius: 5.0,
                                                                                    color: Color(
                                                                                      0x99000000,
                                                                                    ),
                                                                                    offset: Offset(
                                                                                      2.0,
                                                                                      2.0,
                                                                                    ),
                                                                                    spreadRadius: 4.0,
                                                                                  ),
                                                                                ],
                                                                                gradient: const LinearGradient(
                                                                                  colors: [
                                                                                    Color(
                                                                                      0xFFFF0000,
                                                                                    ),
                                                                                    Color(
                                                                                      0xFFC10000,
                                                                                    ),
                                                                                  ],
                                                                                  stops: [
                                                                                    0.0,
                                                                                    1.0,
                                                                                  ],
                                                                                  begin: AlignmentDirectional(
                                                                                    0.0,
                                                                                    -1.0,
                                                                                  ),
                                                                                  end: AlignmentDirectional(
                                                                                    0,
                                                                                    1.0,
                                                                                  ),
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(
                                                                                  45.0,
                                                                                ),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      decoration: const BoxDecoration(),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: const AlignmentDirectional(
                                                                                              0.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                                0.0,
                                                                                                0.0,
                                                                                                10.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Container(
                                                                                                width: 35.0,
                                                                                                height: 35.0,
                                                                                                decoration: BoxDecoration(
                                                                                                  image: DecorationImage(
                                                                                                    fit: BoxFit.cover,
                                                                                                    image: Image.network(
                                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/vkqck67kmjo7/22.png',
                                                                                                    ).image,
                                                                                                  ),
                                                                                                  shape: BoxShape.rectangle,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              10.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Text(
                                                                                              AppLocalizations.of(
                                                                                                context,
                                                                                              )!.k_f0jkfy7q,
                                                                                              style:
                                                                                                  MundayTheme.of(
                                                                                                    context,
                                                                                                  ).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: MundayTheme.of(
                                                                                                        context,
                                                                                                      ).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: 16.5,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: MundayTheme.of(
                                                                                                      context,
                                                                                                    ).bodyMedium.fontStyle,
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
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                            1.0,
                                                                            -2.2,
                                                                          ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          6.0,
                                                                          0.0,
                                                                          0.0,
                                                                          3.0,
                                                                        ),
                                                                        child: InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap: () async {
                                                                            _model.ononvite =
                                                                                true;
                                                                            safeSetState(
                                                                              () {},
                                                                            );
                                                                          },
                                                                          child: Container(
                                                                            width:
                                                                                65.0,
                                                                            height:
                                                                                65.0,
                                                                            decoration: const BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  blurRadius: 4.0,
                                                                                  color: Color(
                                                                                    0x33000000,
                                                                                  ),
                                                                                  offset: Offset(
                                                                                    0.0,
                                                                                    2.0,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child: Stack(
                                                                              children: [
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(
                                                                                    0.0,
                                                                                    -1.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      5.0,
                                                                                      0.0,
                                                                                      0.0,
                                                                                    ),
                                                                                    child: Image.asset(
                                                                                      'assets/images/chat-bubble_(2).png',
                                                                                      width: 35.0,
                                                                                      height: 35.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: const AlignmentDirectional(
                                                                                    0.0,
                                                                                    1.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                                                      0.0,
                                                                                      0.0,
                                                                                      0.0,
                                                                                      4.0,
                                                                                    ),
                                                                                    child: Text(
                                                                                      AppLocalizations.of(
                                                                                        context,
                                                                                      )!.k_l53tynrs,
                                                                                      style:
                                                                                          MundayTheme.of(
                                                                                            context,
                                                                                          ).bodyMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: MundayTheme.of(
                                                                                                context,
                                                                                              ).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 9.0,
                                                                                            letterSpacing: 0.5,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: MundayTheme.of(
                                                                                              context,
                                                                                            ).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                            ],
                          ).animateOnPageLoad(
                            animationsMap['columnOnPageLoadAnimation']!,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
