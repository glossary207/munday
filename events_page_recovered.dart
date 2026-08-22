import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/shared/widgets/dialogs/filter_widget.dart';
import '/shared/widgets/misc/joinroom_widget.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/shared/widgets/core/munday_video_player.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:munday/core/routing/serialization_util.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'events_model.dart';
import 'package:munday/core/theme/theme.dart';

const _kEventsFallbackPosterUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

const _kEventsFallbackProfileUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

const _kEventsHeaderHeight = 74.0;
const _kEventsProfileButtonSize = 47.0;
const _kEventsPrimaryRed = Color(0xFFFF1E1E);
const _kEventsVenueRed = Color(0xFFFF3B3B);
const _kEventsHeaderGlassSettings = LiquidGlassSettings(
  glassColor: Color(0x08FFFFFF),
  thickness: 32.0,
  blur: 0.8,
  chromaticAberration: 0.006,
  lightIntensity: 0.8,
  ambientStrength: 0.12,
  ambientRim: 0.16,
  refractiveIndex: 1.18,
  saturation: 1.25,
  glowIntensity: 0.8,
  specularSharpness: GlassSpecularSharpness.medium,
  standardOpacityMultiplier: 0.55,
  shadowElevation: 0.0,
  whitenStrength: 0.05,
);
const _kFeaturedMockVideoAssets = <String>[
  'assets/videos/venue_cover.mp4',
  'assets/videos/video3.mp4',
];
const _kNightclubCategoryMockups = <String>[
  'EDM / ปาร์ตี้',
  'Hip Hop',
  'Techno',
  'House',
  'Deep House',
  'Disco',
  'R&B',
  'Live DJ',
  'Rooftop',
  'Cocktail Bar',
  'After Party',
  'Ladies Night',
  'Pool Party',
  'ดนตรีสด',
  'บาร์ลับ',
  'Trance',
  'Drum & Bass',
  'Theme Night',
];

double _eventsFeaturedHeroHeight({
  required Size screenSize,
  required double topInset,
}) {
  final designWidth = screenSize.width.clamp(0.0, 390.0).toDouble();
  return topInset + (designWidth - 32.0) + 112.0;
}

final _kThaiCharacterPattern = RegExp(r'[\u0E00-\u0E7F]+');

String get _notoSansThaiFamily =>
    GoogleFonts.notoSansThai().fontFamily ?? 'Noto Sans Thai';

TextStyle _eventsBodyTextStyle({
  required Color color,
  required double fontSize,
  FontWeight fontWeight = FontWeight.w400,
  double? height,
  double? letterSpacing,
}) {
  return GoogleFonts.openSans().copyWith(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
    fontFamilyFallback: [_notoSansThaiFamily],
  );
}

List<InlineSpan> _eventsScriptAwareSpans(
  String text, {
  required bool displayEnglish,
  required Color color,
  required double fontSize,
  FontWeight fontWeight = FontWeight.w400,
  double? height,
  double? letterSpacing,
}) {
  final spans = <InlineSpan>[];
  var cursor = 0;
  for (final match in _kThaiCharacterPattern.allMatches(text)) {
    if (match.start > cursor) {
      final latinText = text.substring(cursor, match.start);
      final latinStyle = displayEnglish
          ? GoogleFonts.bebasNeue(fontWeight: FontWeight.w400)
          : GoogleFonts.openSans(fontWeight: fontWeight);
      spans.add(
        TextSpan(
          text: latinText,
          style: latinStyle.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: displayEnglish ? FontWeight.w400 : fontWeight,
            height: height,
            letterSpacing: letterSpacing,
            fontFamilyFallback: [_notoSansThaiFamily],
          ),
        ),
      );
    }
    spans.add(
      TextSpan(
        text: match.group(0),
        style: GoogleFonts.notoSansThai().copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          fontFamilyFallback: [_notoSansThaiFamily],
        ),
      ),
    );
    cursor = match.end;
  }
  if (cursor < text.length) {
    final latinStyle = displayEnglish
        ? GoogleFonts.bebasNeue(fontWeight: FontWeight.w400)
        : GoogleFonts.openSans(fontWeight: fontWeight);
    spans.add(
      TextSpan(
        text: text.substring(cursor),
        style: latinStyle.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: displayEnglish ? FontWeight.w400 : fontWeight,
          height: height,
          letterSpacing: letterSpacing,
          fontFamilyFallback: [_notoSansThaiFamily],
        ),
      ),
    );
  }
  return spans;
}

class _EventsScriptText extends StatelessWidget {
  const _EventsScriptText(
    this.text, {
    required this.color,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.displayEnglish = false,
    this.height,
    this.letterSpacing,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final bool displayEnglish;
  final double? height;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: _eventsScriptAwareSpans(
          text,
          displayEnglish: displayEnglish,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        ),
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

String _safeEventsImageUrl(String? url, {required String fallback}) {
  final normalized = url?.trim();
  if (normalized == null || normalized.isEmpty) {
    return fallback;
  }

  final uri = Uri.tryParse(normalized);
  if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
    return fallback;
  }

  return normalized;
}

dynamic _eventRawValue(EventsRecord event, List<String> keys) {
  for (final key in keys) {
    final value = event.snapshotData[key];
    if (value != null) return value;
  }
  return null;
}

String? _eventRawString(EventsRecord event, List<String> keys) {
  final value = _eventRawValue(event, keys);
  if (value is String && value.trim().isNotEmpty) return value.trim();
  if (value is Iterable) {
    for (final item in value) {
      if (item is String && item.trim().isNotEmpty) return item.trim();
    }
  }
  return null;
}

bool _isVideoMediaPath(String? path) {
  if (path == null) return false;
  final normalized = path.toLowerCase().split('?').first;
  return normalized.endsWith('.mp4') ||
      normalized.endsWith('.mov') ||
      normalized.endsWith('.m4v') ||
      normalized.endsWith('.webm');
}

String? _featuredVideoPath(EventsRecord event, {int? mockIndex}) {
  final explicitVideo = _eventRawString(event, const [
    'featured_video',
    'featuredVideo',
    'hero_video',
    'heroVideo',
    'video',
    'Video',
  ]);
  if (explicitVideo != null) return explicitVideo;
  if (_isVideoMediaPath(event.poster)) return event.poster;
  if (mockIndex != null && mockIndex < _kFeaturedMockVideoAssets.length) {
    return _kFeaturedMockVideoAssets[mockIndex];
  }
  return null;
}

bool _isFeaturedEvent(EventsRecord event) {
  final value = _eventRawValue(event, const [
    'featured',
    'Featured',
    'is_featured',
    'isFeatured',
  ]);
  return value == true || value == 1 || value == 'true';
}

List<EventsRecord> _selectFeaturedEvents(List<EventsRecord> events) {
  final now = DateTime.now();
  final candidates = events.where((event) {
    return _featuredVideoPath(event) != null || event.poster.trim().isNotEmpty;
  }).toList();

  candidates.sort((a, b) {
    final featuredOrder = (_isFeaturedEvent(b) ? 1 : 0).compareTo(
      _isFeaturedEvent(a) ? 1 : 0,
    );
    if (featuredOrder != 0) return featuredOrder;

    final aUpcoming = a.date == null || !a.date!.isBefore(now);
    final bUpcoming = b.date == null || !b.date!.isBefore(now);
    if (aUpcoming != bUpcoming) return aUpcoming ? -1 : 1;

    final aDate = a.date ?? DateTime(9999);
    final bDate = b.date ?? DateTime(9999);
    return aDate.compareTo(bDate);
  });

  return candidates.take(5).toList();
}

DataEventsStruct _eventDataFromRecord(EventsRecord event) {
  return DataEventsStruct(
    nameArtise: event.nameArtise.toList(),
    nameStore: event.nameStore,
    poster: event.poster,
    capacity: event.capacity,
    maxCapacity: event.maxCapacity,
    musicstyle: event.musicstyle,
    date: event.date,
    docRef: event.reference,
    position: event.location,
    iDVenuse: event.iDVenues,
    free: event.free,
    priceDetail: event.priceDetail,
  );
}

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  static String routeName = 'Events';
  static String routePath = 'events';

  @override
  ConsumerState<EventsPage> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends ConsumerState<EventsPage>
    with TickerProviderStateMixin {
  late EventsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  Stream<List<EventsRecord>>? _eventsStream;
  final ValueNotifier<bool> _heroCoveredNotifier = ValueNotifier<bool>(false);
  bool _showLegacyEventGrid = false;
  int _featuredHeroIndex = 0;
  bool _heroSnapInProgress = false;
  ScrollDirection _lastEventsScrollDirection = ScrollDirection.idle;
  double _featuredHeroSnapOffset = 420.0;

  @override
  void initState() {
    super.initState();
    _model = EventsModel()..internalInit(context);
    _model.columnController?.addListener(_handleEventsScroll);

    _eventsStream = queryEventsRecord();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue = await getCurrentUserLocation(
        defaultLocation: LatLng(0.0, 0.0),
      );
      context.appState.locationsearch = currentUserLocationValue;
      context.appState.dateclick = getCurrentTimestamp;
      context.appState.MoveMap = false;
      safeSetState(() {});
      _model.mapOn = false;
      _model.wide = MediaQuery.sizeOf(context).width;
      safeSetState(() {});
    });

    getCurrentUserLocation(
      defaultLocation: LatLng(0.0, 0.0),
      cached: true,
    ).then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(() async {
      _model.page = 1;
      _model.textinput = true;
      safeSetState(() {});
    });
    animationsMap.addAll({
      'containerOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(320.0, 0.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0, 0),
            end: Offset(0, 0.436),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(0.85, 0.85),
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 50.0),
            end: Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
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
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
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
    _model.columnController?.removeListener(_handleEventsScroll);
    _heroCoveredNotifier.dispose();
    _model.dispose();

    super.dispose();
  }

  void _handleEventsScroll() {
    final collapseThreshold = (_featuredHeroSnapOffset * 0.82)
        .clamp(240.0, 420.0)
        .toDouble();
    final collapsed =
        (_model.columnController?.offset ?? 0.0) > collapseThreshold;
    if (collapsed != _heroCoveredNotifier.value) {
      _heroCoveredNotifier.value = collapsed;
    }
  }

  bool _handleEventsScrollNotification(
    ScrollNotification notification,
    double heroSnapOffset,
  ) {
    if (notification.metrics.axis != Axis.vertical) return false;

    if (notification is UserScrollNotification &&
        notification.direction != ScrollDirection.idle) {
      _lastEventsScrollDirection = notification.direction;
    }

    if (notification is ScrollEndNotification && heroSnapOffset > 0.0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _snapFeaturedHero(heroSnapOffset);
      });
    }
    return false;
  }

  void _snapFeaturedHero(double requestedSnapOffset) {
    final controller = _model.columnController;
    if (!mounted ||
        controller == null ||
        !controller.hasClients ||
        _heroSnapInProgress) {
      return;
    }

    final position = controller.position;
    final snapOffset = requestedSnapOffset
        .clamp(0.0, position.maxScrollExtent)
        .toDouble();
    final currentOffset = position.pixels;
    if (snapOffset <= 1.0 ||
        currentOffset <= 1.0 ||
        currentOffset >= snapOffset - 1.0) {
      return;
    }

    final collapse =
        _lastEventsScrollDirection == ScrollDirection.reverse ||
        (_lastEventsScrollDirection == ScrollDirection.idle &&
            currentOffset >= snapOffset * 0.35);
    final destination = collapse ? snapOffset : 0.0;
    _heroSnapInProgress = true;
    controller
        .animateTo(
          destination,
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeOutCubic,
        )
        .whenComplete(() => _heroSnapInProgress = false);
  }

  Widget _buildEventsTopHeader(BuildContext context, int featuredCount) {
    return _EventsTopHeader(
      topInset: MediaQuery.paddingOf(context).top,
      featuredCount: featuredCount,
      featuredIndex: _featuredHeroIndex,
      collapsed: false,
      onLocationPressed: () {
        _model.mapOn = true;
        context.appState.update(() {
          context.appState.mapModeOn = true;
        });
        safeSetState(() {});
      },
      onNotificationPressed: () {
        context.pushNamed(NotificationPage.routeName);
      },
      onProfilePressed: () {
        context.pushNamed(
          ProfilePage.routeName,
          queryParameters: {
            'fromSeting': serializeParam(false, ParamType.bool),
          }.withoutNulls,
        );
      },
    );
  }

  Future<_EventDetailData> _loadEventDetailData(
    DataEventsStruct eventData,
  ) async {
    EventsRecord? eventRecord;
    VenuesRecord? venueRecord;

    final eventRef = eventData.docRef;
    if (eventRef != null) {
      try {
        eventRecord = await EventsRecord.getDocumentOnce(eventRef);
      } catch (error) {
        debugPrint('Unable to load selected event: $error');
      }
    }

    final venueRef = eventData.iDVenuse ?? eventRecord?.iDVenues;
    if (venueRef != null) {
      try {
        venueRecord = await VenuesRecord.getDocumentOnce(venueRef);
      } catch (error) {
        debugPrint('Unable to load event venue: $error');
      }
    }

    return _EventDetailData(
      eventData: eventData,
      eventRecord: eventRecord,
      venueRecord: venueRecord,
    );
  }

  Future<void> _showEventDetailSheet(DataEventsStruct? eventData) async {
    if (eventData == null || eventData.nameStore == '007') {
      return;
    }

    final detailFuture = _loadEventDetailData(eventData);
    final topSafeInset = MediaQueryData.fromView(
      View.of(context),
    ).viewPadding.top;
    final appState = context.appState;
    appState.eventDetailOpen = true;

    try {
      // Let the native adaptive nav bar leave the view hierarchy before the
      // root modal is presented; otherwise it can remain above Flutter's
      // bottom-sheet layer for the first frame on iOS.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) {
        return;
      }

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: false,
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        barrierColor: const Color(0xB3000000),
        builder: (bottomSheetContext) {
          return _EventDetailSheet(
            detailFuture: detailFuture,
            fallbackEventData: eventData,
            topSafeInset: topSafeInset,
            onViewVenue: (detailData) {
              Navigator.of(bottomSheetContext).pop();

              final venueRef = detailData.venueRef;
              if (venueRef == null) {
                return;
              }

              context.pushNamed(
                InVenusePage.routeName,
                queryParameters: {
                  'idVenues': serializeParam(
                    venueRef,
                    ParamType.SupabaseDocRef,
                  ),
                  'distance': serializeParam(
                    detailData.distanceValue,
                    ParamType.String,
                  ),
                  'dateclick': serializeParam(
                    detailData.eventDate ?? context.appState.dateclick,
                    ParamType.DateTime,
                  ),
                  'index': serializeParam(0, ParamType.int),
                }.withoutNulls,
              );
            },
          );
        },
      );
    } finally {
      appState.eventDetailOpen = false;
      if (mounted) {
        safeSetState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    // Removed blocking location check to allow UI to render immediately
    // if (currentUserLocationValue == null) { ... }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                StreamBuilder<List<EventsRecord>>(
                  stream: _eventsStream,
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<EventsRecord> homeBodyEventsRecordList =
                        snapshot.data!;
                    final featuredEvents = _selectFeaturedEvents(
                      homeBodyEventsRecordList,
                    );
                    final eventsHeaderHeight =
                        _kEventsHeaderHeight +
                        MediaQuery.paddingOf(context).top;
                    final featuredHeroHeight = featuredEvents.isEmpty
                        ? 0.0
                        : _eventsFeaturedHeroHeight(
                            screenSize: MediaQuery.sizeOf(context),
                            topInset: eventsHeaderHeight,
                          );
                    final featuredHeroSnapOffset =
                        (featuredHeroHeight - eventsHeaderHeight)
                            .clamp(0.0, double.infinity)
                            .toDouble();
                    _featuredHeroSnapOffset = featuredHeroSnapOffset;
                    final discoveryEvents =
                        (functions.dataEvent(
                                  context.appState.Filterdistance,
                                  homeBodyEventsRecordList
                                      .where(
                                        (event) =>
                                            functions.showsearch(
                                              _model.textController?.text ?? '',
                                              functions.addName(
                                                event.nameArtise.toList(),
                                              ),
                                            ) ??
                                            false,
                                      )
                                      .toList(),
                                  context.appState.locationsearch,
                                  _model.stylemusic.toList(),
                                  (currentUserDocument?.loveEvent?.toList() ??
                                          const <SupabaseDocRef>[])
                                      .toList(),
                                  context.appState.StyleVenuse.toList(),
                                  _model.page,
                                  false,
                                  _model.selectdate,
                                  context.appState.dateclick,
                                  false,
                                  _model.lovefilter,
                                ) ??
                                const <dynamic>[])
                            .map(DataEventsStruct.maybeFromMap)
                            .whereType<DataEventsStruct>()
                            .where((event) => event.nameStore != '007')
                            .toList();
                    final eventCategories = <String>{
                      ...homeBodyEventsRecordList
                          .map((event) => event.musicstyle.trim())
                          .where((style) => style.isNotEmpty),
                      ..._kNightclubCategoryMockups,
                    }.toList();
                    print(
                      "DEBUG: homeBodyEventsRecordList length = ${homeBodyEventsRecordList.length}",
                    );

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 50.0,
                            color: Color(0xC0000000),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            if (_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: custom_widgets.MapEvent(
                                      width: double.infinity,
                                      height: double.infinity,
                                      zoomStart: 10.5,
                                      zoomMin: 9.0,
                                      zoomMax: 18.0,
                                      markerIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/4ukflr1mlkc1/beer_(3).png',
                                      markerMeIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/lkzyscp6kupj/map-marker_(2).png',
                                      compassEnabled: true,
                                      items: functions.dataEventDocRef(
                                        context.appState.Filterdistance,
                                        context.appState.locationsearch,
                                        (currentUserDocument?.loveEvent ?? [])
                                            .toList(),
                                        _model.stylemusic.toList(),
                                        context.appState.StyleVenuse.toList(),
                                        homeBodyEventsRecordList
                                            .where(
                                              (e) => functions.showsearch(
                                                _model.textController.text,
                                                functions.addName(
                                                  e.nameArtise.toList(),
                                                ),
                                              )!,
                                            )
                                            .toList(),
                                        _model.selectdate,
                                        context.appState.dateclick,
                                      ),
                                      itemClick:
                                          context.appState.EventSelection,
                                      locationStart:
                                          currentUserLocationValue ??
                                          LatLng(0.0, 0.0),
                                      currentLocation:
                                          context.appState.locationsearch,
                                      makerSelectedIcon:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ugva4ht8jron/beer_(2).png',
                                      moveMapCondition:
                                          context.appState.MoveMap,
                                      radian: context.appState.Filterdistance,
                                      whenSelect: () async {
                                        _model.slide = false;
                                        safeSetState(() {});
                                        await _model.carouselController
                                            ?.animateToPage(
                                              functions.searchIndexEvent(
                                                functions
                                                    .dataEventDocRef(
                                                      context
                                                          .appState
                                                          .Filterdistance,
                                                      context
                                                          .appState
                                                          .locationsearch,
                                                      (currentUserDocument
                                                                  ?.loveEvent ??
                                                              [])
                                                          .toList(),
                                                      _model.stylemusic
                                                          .toList(),
                                                      context
                                                          .appState
                                                          .StyleVenuse
                                                          .toList(),
                                                      homeBodyEventsRecordList
                                                          .where(
                                                            (
                                                              e,
                                                            ) => functions.showsearch(
                                                              _model
                                                                  .textController
                                                                  .text,
                                                              functions.addName(
                                                                e.nameArtise
                                                                    .toList(),
                                                              ),
                                                            )!,
                                                          )
                                                          .toList(),
                                                      _model.selectdate,
                                                      context
                                                          .appState
                                                          .dateclick,
                                                    )
                                                    ?.toList(),
                                                context.appState.EventSelection,
                                              )!,
                                              duration: Duration(
                                                milliseconds: 500,
                                              ),
                                              curve: Curves.ease,
                                            );
                                        _model.slide = true;
                                        safeSetState(() {});
                                      },
                                      whenSetStyleSuccess: () async {},
                                    ),
                                  ),
                                ),
                              ),
                            Container(
                              width: double.infinity,
                              height: _model.selectdate ? 210.0 : 170.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.7, 1.0],
                                  begin: AlignmentDirectional(0.0, -1.0),
                                  end: AlignmentDirectional(0, 1.0),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                ),
                              ),
                            ),
                            if (!_model.mapOn && featuredEvents.isNotEmpty)
                              _EventsHeroSearchSheet(
                                heroHeight: featuredHeroHeight,
                                safeTopInset: MediaQuery.paddingOf(context).top,
                                header: _buildEventsTopHeader(
                                  context,
                                  featuredEvents.length,
                                ),
                                hero: _FeaturedEventsHero(
                                  events: featuredEvents,
                                  topInset: eventsHeaderHeight,
                                  onPageChanged: (index) {
                                    if (_featuredHeroIndex != index) {
                                      safeSetState(
                                        () => _featuredHeroIndex = index,
                                      );
                                    }
                                  },
                                  onEventTap: (event) async {
                                    await _showEventDetailSheet(
                                      _eventDataFromRecord(event),
                                    );
                                  },
                                ),
                                children: [
                                  _EventsDesignCanvas(
                                    child: _EventsSearchControls(
                                      controller: _model.textController!,
                                      focusNode: _model.textFieldFocusNode!,
                                      favoriteSelected: _model.lovefilter,
                                      dateSelected: _model.selectdate,
                                      distance: context.appState.Filterdistance,
                                      onSearchChanged: (_) {
                                        _model.page = 1;
                                        safeSetState(() {});
                                      },
                                      onFilterPressed: () async {
                                        await showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(
                                                  context,
                                                ).unfocus();
                                                FocusManager
                                                    .instance
                                                    .primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                      context,
                                                    ),
                                                child: FilterWidget(),
                                              ),
                                            );
                                          },
                                        );
                                        _model.page = 1;
                                        safeSetState(() {});
                                      },
                                      onFavoritePressed: () {
                                        _model.lovefilter = !_model.lovefilter;
                                        if (_model.lovefilter) {
                                          _model.selectdate = false;
                                        }
                                        _model.page = 1;
                                        safeSetState(() {});
                                      },
                                      onMapPressed: () {
                                        _model.mapOn = true;
                                        context.appState.update(() {
                                          context.appState.mapModeOn = true;
                                        });
                                        safeSetState(() {});
                                      },
                                      onDatePressed: () {
                                        _model.selectdate = !_model.selectdate;
                                        if (_model.selectdate) {
                                          _model.lovefilter = false;
                                        }
                                        _model.page = 1;
                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                  _EventsDesignCanvas(
                                    child: _EventsTopEventsCarousel(
                                      events: discoveryEvents,
                                      onEventPressed: _showEventDetailSheet,
                                    ),
                                  ),
                                  _EventsDesignCanvas(
                                    child: _EventsCategoryBrowser(
                                      categories: eventCategories,
                                      selectedCategories: _model.stylemusic,
                                      onCategoryPressed: (category) {
                                        if (_model.stylemusic.contains(
                                          category,
                                        )) {
                                          _model.removeFromStylemusic(category);
                                        } else {
                                          _model.addToStylemusic(category);
                                        }
                                        _model.page = 1;
                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                  _EventsDesignCanvas(
                                    child: _EventsGroupedByDay(
                                      events: discoveryEvents,
                                      onEventPressed: _showEventDetailSheet,
                                    ),
                                  ),
                                ],
                              ),
                            if (!_model.mapOn && featuredEvents.isEmpty)
                              Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    featuredEvents.isEmpty
                                        ? eventsHeaderHeight
                                        : 0.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (notification) =>
                                        _handleEventsScrollNotification(
                                          notification,
                                          featuredHeroSnapOffset,
                                        ),
                                    child:
                                        SingleChildScrollView(
                                          controller: _model.columnController,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _FeaturedEventsHero(
                                                events: featuredEvents,
                                                topInset: eventsHeaderHeight,
                                                onPageChanged: (index) {
                                                  if (_featuredHeroIndex !=
                                                      index) {
                                                    safeSetState(
                                                      () => _featuredHeroIndex =
                                                          index,
                                                    );
                                                  }
                                                },
                                                onEventTap: (event) async {
                                                  await _showEventDetailSheet(
                                                    _eventDataFromRecord(event),
                                                  );
                                                },
                                              ),
                                              _EventsDesignCanvas(
                                                child: _EventsCategoryBrowser(
                                                  categories: eventCategories,
                                                  selectedCategories:
                                                      _model.stylemusic,
                                                  onCategoryPressed: (category) {
                                                    if (_model.stylemusic
                                                        .contains(category)) {
                                                      _model
                                                          .removeFromStylemusic(
                                                            category,
                                                          );
                                                    } else {
                                                      _model.addToStylemusic(
                                                        category,
                                                      );
                                                    }
                                                    _model.page = 1;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                              _EventsDesignCanvas(
                                                child: _EventsTopEventsCarousel(
                                                  events: discoveryEvents,
                                                  onEventPressed:
                                                      _showEventDetailSheet,
                                                ),
                                              ),
                                              _EventsDesignCanvas(
                                                child: _EventsSearchControls(
                                                  controller:
                                                      _model.textController!,
                                                  focusNode: _model
                                                      .textFieldFocusNode!,
                                                  favoriteSelected:
                                                      _model.lovefilter,
                                                  dateSelected:
                                                      _model.selectdate,
                                                  distance: context
                                                      .appState
                                                      .Filterdistance,
                                                  onSearchChanged: (_) {
                                                    _model.page = 1;
                                                    safeSetState(() {});
                                                  },
                                                  onFilterPressed: () async {
                                                    await showModalBottomSheet<
                                                      void
                                                    >(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                              context,
                                                            ).unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                MediaQuery.viewInsetsOf(
                                                                  context,
                                                                ),
                                                            child:
                                                                FilterWidget(),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    _model.page = 1;
                                                    safeSetState(() {});
                                                  },
                                                  onFavoritePressed: () {
                                                    _model.lovefilter =
                                                        !_model.lovefilter;
                                                    if (_model.lovefilter) {
                                                      _model.selectdate = false;
                                                    }
                                                    _model.page = 1;
                                                    safeSetState(() {});
                                                  },
                                                  onMapPressed: () {
                                                    _model.mapOn = true;
                                                    context.appState.update(() {
                                                      context
                                                              .appState
                                                              .mapModeOn =
                                                          true;
                                                    });
                                                    safeSetState(() {});
                                                  },
                                                  onDatePressed: () {
                                                    _model.selectdate =
                                                        !_model.selectdate;
                                                    if (_model.selectdate) {
                                                      _model.lovefilter = false;
                                                    }
                                                    _model.page = 1;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                              _EventsDesignCanvas(
                                                child: _EventsGroupedByDay(
                                                  events: discoveryEvents,
                                                  onEventPressed:
                                                      _showEventDetailSheet,
                                                ),
                                              ),
                                              if (_showLegacyEventGrid &&
                                                  _model.selectdate &&
                                                  !_model.mapOn)
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        15.0,
                                                        0.0,
                                                        15.0,
                                                        5.0,
                                                      ),
                                                  child:
                                                      Container(
                                                        width: double.infinity,
                                                        height: 70.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Container(
                                                          width: 45.0,
                                                          height: 60.0,
                                                          child: custom_widgets.CalendarslideEvent(
                                                            width: 45.0,
                                                            height: 60.0,
                                                            colorPicker: Color(
                                                              0xFFFF0000,
                                                            ),
                                                            dateNow:
                                                                getCurrentTimestamp,
                                                            dateclickwidget:
                                                                AppState()
                                                                    .dateclick,
                                                            onselect: () async {
                                                              safeSetState(
                                                                () {},
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ).animateOnPageLoad(
                                                        animationsMap['containerOnPageLoadAnimation1']!,
                                                      ),
                                                ),
                                              if (_showLegacyEventGrid &&
                                                  functions
                                                          .dataEvent(
                                                            context
                                                                .appState
                                                                .Filterdistance,
                                                            homeBodyEventsRecordList
                                                                .where(
                                                                  (
                                                                    e,
                                                                  ) => functions.showsearch(
                                                                    _model
                                                                        .textController
                                                                        .text,
                                                                    functions.addName(
                                                                      e.nameArtise
                                                                          .toList(),
                                                                    ),
                                                                  )!,
                                                                )
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .locationsearch,
                                                            _model.stylemusic
                                                                .toList(),
                                                            (currentUserDocument
                                                                        ?.loveEvent
                                                                        ?.toList() ??
                                                                    [])
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .StyleVenuse
                                                                .toList(),
                                                            _model.page,
                                                            _model.mapOn,
                                                            _model.selectdate,
                                                            context
                                                                .appState
                                                                .dateclick,
                                                            false,
                                                            _model.lovefilter,
                                                          )
                                                          ?.length ==
                                                      0)
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        0.0,
                                                        10.0,
                                                        0.0,
                                                      ),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) => Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20.0,
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              40.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .notifications_none,
                                                              color:
                                                                  Colors.white,
                                                              size: 72.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child:
                                                                  currentUserReference ==
                                                                      null
                                                                  ? Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(
                                                                            context,
                                                                          )!.k_sf7y15sd,
                                                                          style:
                                                                              Theme.of(
                                                                                context,
                                                                              ).textTheme.headlineMedium!.override(
                                                                                font: GoogleFonts.outfit(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.headlineMedium!.fontStyle,
                                                                                ),
                                                                                color: Colors.white,
                                                                                fontSize: 30.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.headlineMedium!.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : StreamBuilder<
                                                                      UsersRecord
                                                                    >(
                                                                      stream: UsersRecord.getDocument(
                                                                        currentUserReference!,
                                                                      ),
                                                                      builder:
                                                                          (
                                                                            context,
                                                                            snapshot,
                                                                          ) {
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 50.0,
                                                                                  height: 50.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor:
                                                                                        AlwaysStoppedAnimation<
                                                                                          Color
                                                                                        >(
                                                                                          Colors.transparent,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            final textUsersRecord =
                                                                                snapshot.data!;
                                                                            return Text(
                                                                              AppLocalizations.of(
                                                                                context,
                                                                              )!.k_sf7y15sd,
                                                                              style:
                                                                                  Theme.of(
                                                                                    context,
                                                                                  ).textTheme.headlineMedium!.override(
                                                                                    font: GoogleFonts.outfit(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: Theme.of(
                                                                                        context,
                                                                                      ).textTheme.headlineMedium!.fontStyle,
                                                                                    ),
                                                                                    color: Colors.white,
                                                                                    fontSize: 30.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: Theme.of(
                                                                                      context,
                                                                                    ).textTheme.headlineMedium!.fontStyle,
                                                                                  ),
                                                                            );
                                                                          },
                                                                    ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    25.0,
                                                                    4.0,
                                                                    25.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_z4axt11t,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: Theme.of(context).textTheme.labelMedium!.override(
                                                                  font: GoogleFonts.plusJakartaSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .labelMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                    0xFFBCBCBC,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .labelMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    7.0,
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
                                                                  if (_model
                                                                      .selectdate) {
                                                                    _model.selectdate =
                                                                        false;
                                                                    _model.page =
                                                                        1;
                                                                    safeSetState(
                                                                      () {},
                                                                    );
                                                                    await _model.columnController?.animateTo(
                                                                      0,
                                                                      duration: Duration(
                                                                        milliseconds:
                                                                            300,
                                                                      ),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  } else {
                                                                    _model.selectdate =
                                                                        true;
                                                                    _model.page =
                                                                        1;
                                                                    safeSetState(
                                                                      () {},
                                                                    );
                                                                    await _model.columnController?.animateTo(
                                                                      0,
                                                                      duration: Duration(
                                                                        milliseconds:
                                                                            300,
                                                                      ),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  }
                                                                },
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        _model
                                                                            .selectdate
                                                                        ? Color(
                                                                            0xFFFF0000,
                                                                          )
                                                                        : Color(
                                                                            0xFF1C1C1C,
                                                                          ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          20.0,
                                                                        ),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                      color:
                                                                          _model
                                                                              .selectdate
                                                                          ? Color(
                                                                              0xFFFF0000,
                                                                            )
                                                                          : Color(
                                                                              0xFF1C1C1C,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          4.0,
                                                                          6.0,
                                                                          5.0,
                                                                        ),
                                                                        child: Text(
                                                                          AppLocalizations.of(
                                                                            context,
                                                                          )!.k_wgbetsw7,
                                                                          style:
                                                                              Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                                color: Colors.white,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0,
                                                                        ),
                                                                        child: Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if (functions
                                                                    .dataEvent(
                                                                      AppState()
                                                                          .Filterdistance,
                                                                      homeBodyEventsRecordList
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.showsearch(
                                                                              _model.textController.text,
                                                                              functions.addName(
                                                                                e.nameArtise.toList(),
                                                                              ),
                                                                            )!,
                                                                          )
                                                                          .toList(),
                                                                      AppState()
                                                                          .locationsearch,
                                                                      _model
                                                                          .stylemusic
                                                                          .toList(),
                                                                      (currentUserDocument?.loveEvent?.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      AppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      _model
                                                                          .page,
                                                                      true,
                                                                      false,
                                                                      AppState()
                                                                          .dateclick,
                                                                      false,
                                                                      _model
                                                                          .lovefilter,
                                                                    )!
                                                                    .length >
                                                                0)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      10.0,
                                                                      80.0,
                                                                      10.0,
                                                                      7.0,
                                                                    ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Flexible(
                                                                      child: Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            2.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(
                                                                            0xFF1C1C1C,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            10.0,
                                                                            2.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_gfa27afd,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            2.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(
                                                                            0xFF1C1C1C,
                                                                          ),
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
                                                ),
                                              if (_showLegacyEventGrid &&
                                                  functions
                                                          .dataEvent(
                                                            context
                                                                .appState
                                                                .Filterdistance,
                                                            homeBodyEventsRecordList
                                                                .where(
                                                                  (
                                                                    e,
                                                                  ) => functions.showsearch(
                                                                    _model
                                                                        .textController
                                                                        .text,
                                                                    functions.addName(
                                                                      e.nameArtise
                                                                          .toList(),
                                                                    ),
                                                                  )!,
                                                                )
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .locationsearch,
                                                            _model.stylemusic
                                                                .toList(),
                                                            (currentUserDocument
                                                                        ?.loveEvent
                                                                        ?.toList() ??
                                                                    [])
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .StyleVenuse
                                                                .toList(),
                                                            _model.page,
                                                            _model.mapOn,
                                                            _model.selectdate,
                                                            context
                                                                .appState
                                                                .dateclick,
                                                            false,
                                                            _model.lovefilter,
                                                          )
                                                          ?.length ==
                                                      0)
                                                Align(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          -1.0,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            5.0,
                                                            1.0,
                                                            5.0,
                                                            0.0,
                                                          ),
                                                      child: AuthUserStreamWidget(
                                                        builder: (context) => Builder(
                                                          builder: (context) {
                                                            final dataEvents =
                                                                functions
                                                                    .dataEvent(
                                                                      AppState()
                                                                          .Filterdistance,
                                                                      homeBodyEventsRecordList
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.showsearch(
                                                                              _model.textController.text,
                                                                              functions.addName(
                                                                                e.nameArtise.toList(),
                                                                              ),
                                                                            )!,
                                                                          )
                                                                          .toList(),
                                                                      AppState()
                                                                          .locationsearch,
                                                                      _model
                                                                          .stylemusic
                                                                          .toList(),
                                                                      (currentUserDocument?.loveEvent?.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      AppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      _model
                                                                          .page,
                                                                      _model
                                                                          .mapOn,
                                                                      false,
                                                                      AppState()
                                                                          .dateclick,
                                                                      false,
                                                                      _model
                                                                          .lovefilter,
                                                                    )
                                                                    ?.toList() ??
                                                                [];

                                                            return Wrap(
                                                              spacing: 1.0,
                                                              runSpacing: 1.0,
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .start,
                                                              direction: Axis
                                                                  .horizontal,
                                                              runAlignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              verticalDirection:
                                                                  VerticalDirection
                                                                      .down,
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: List.generate(
                                                                dataEvents
                                                                    .length,
                                                                (
                                                                  dataEventsIndex,
                                                                ) {
                                                                  final dataEventsItem =
                                                                      dataEvents[dataEventsIndex];
                                                                  return Opacity(
                                                                    opacity:
                                                                        DataEventsStruct.maybeFromMap(
                                                                              dataEventsItem,
                                                                            )?.nameStore ==
                                                                            '007'
                                                                        ? 0.0
                                                                        : 1.0,
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                            5.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).width *
                                                                            0.446,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await _showEventDetailSheet(
                                                                                      DataEventsStruct.maybeFromMap(
                                                                                        dataEventsItem,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    width:
                                                                                        MediaQuery.sizeOf(
                                                                                          context,
                                                                                        ).width *
                                                                                        0.444,
                                                                                    height:
                                                                                        valueOrDefault<
                                                                                          double
                                                                                        >(
                                                                                          functions.posterscale(
                                                                                            _model.wide,
                                                                                            false,
                                                                                          ),
                                                                                          250.0,
                                                                                        ),
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(
                                                                                        0xFF161616,
                                                                                      ),
                                                                                      image: DecorationImage(
                                                                                        fit: BoxFit.cover,
                                                                                        image: Image.network(
                                                                                          _safeEventsImageUrl(
                                                                                            DataEventsStruct.maybeFromMap(
                                                                                              dataEventsItem,
                                                                                            )?.poster,
                                                                                            fallback: _kEventsFallbackPosterUrl,
                                                                                          ),
                                                                                        ).image,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        bottomRight: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                        topLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        topRight: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  10.0,
                                                                                                  10.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Container(
                                                                                                  width: 42.0,
                                                                                                  constraints: const BoxConstraints(
                                                                                                    minHeight: 42.0,
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(
                                                                                                      0xFFFF0000,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(
                                                                                                      10.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          0.0,
                                                                                                          3.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          functions
                                                                                                              .dateEventday(
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.date,
                                                                                                              )
                                                                                                              .toString(),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color:
                                                                                                                    Theme.of(
                                                                                                                          context,
                                                                                                                        )
                                                                                                                        .extension<
                                                                                                                          CustomColors
                                                                                                                        >()!
                                                                                                                        .primaryText,
                                                                                                                fontSize: 17.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                                lineHeight: 1.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          0.0,
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            functions.dateMonthTH(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.date,
                                                                                                            ),
                                                                                                            'ไม่ระบุ',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontWeight,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color:
                                                                                                                    Theme.of(
                                                                                                                          context,
                                                                                                                        )
                                                                                                                        .extension<
                                                                                                                          CustomColors
                                                                                                                        >()!
                                                                                                                        .primaryText,
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                                lineHeight: 1.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                0.0,
                                                                                                0.0,
                                                                                                5.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  if (!loggedIn) {
                                                                                                    context.pushNamed(
                                                                                                      PhoneLoginPage.routeName,
                                                                                                    );
                                                                                                    return;
                                                                                                  }
                                                                                                  if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                          [])
                                                                                                      .contains(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.docRef,
                                                                                                      )) {
                                                                                                    await currentUserReference!.update(
                                                                                                      {
                                                                                                        ...mapToSupabase(
                                                                                                          {
                                                                                                            'loveEvent': FieldValue.arrayRemove(
                                                                                                              [
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.docRef,
                                                                                                              ],
                                                                                                            ),
                                                                                                          },
                                                                                                        ),
                                                                                                      },
                                                                                                    );
                                                                                                  } else {
                                                                                                    await currentUserReference!.update(
                                                                                                      {
                                                                                                        ...mapToSupabase(
                                                                                                          {
                                                                                                            'loveEvent': FieldValue.arrayUnion(
                                                                                                              [
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.docRef,
                                                                                                              ],
                                                                                                            ),
                                                                                                          },
                                                                                                        ),
                                                                                                      },
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 38.0,
                                                                                                  height: 38.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(
                                                                                                      0x22000000,
                                                                                                    ),
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: Stack(
                                                                                                    children: [
                                                                                                      if (!(currentUserDocument?.loveEvent?.toList() ??
                                                                                                              [])
                                                                                                          .contains(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.docRef,
                                                                                                          ))
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              0.0,
                                                                                                              1.5,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: FaIcon(
                                                                                                              FontAwesomeIcons.heart,
                                                                                                              color: Color(
                                                                                                                0xFFFDFDFD,
                                                                                                              ),
                                                                                                              size: 23.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                              [])
                                                                                                          .contains(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.docRef,
                                                                                                          ))
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              0.0,
                                                                                                              1.5,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: FaIcon(
                                                                                                              FontAwesomeIcons.solidHeart,
                                                                                                              color: Color(
                                                                                                                0xFFFF0000,
                                                                                                              ),
                                                                                                              size: 23.0,
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
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            decoration: BoxDecoration(),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: double.infinity,
                                                                                          height:
                                                                                              MediaQuery.sizeOf(
                                                                                                context,
                                                                                              ).height *
                                                                                              0.22,
                                                                                          decoration: BoxDecoration(
                                                                                            gradient: LinearGradient(
                                                                                              colors: [
                                                                                                Colors.transparent,
                                                                                                Color(
                                                                                                  0xED000000,
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
                                                                                            borderRadius: BorderRadius.only(
                                                                                              bottomLeft: Radius.circular(
                                                                                                10.0,
                                                                                              ),
                                                                                              bottomRight: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                              topLeft: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                              topRight: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              5.0,
                                                                                              0.0,
                                                                                              5.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    -1.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      5.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<
                                                                                                        String
                                                                                                      >(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.nameArtise.firstOrNull,
                                                                                                        'ไม่ระบุ',
                                                                                                      ),
                                                                                                      maxLines: 18,
                                                                                                      style:
                                                                                                          Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                            ),
                                                                                                            color:
                                                                                                                Theme.of(
                                                                                                                      context,
                                                                                                                    )
                                                                                                                    .extension<
                                                                                                                      CustomColors
                                                                                                                    >()!
                                                                                                                    .primaryText,
                                                                                                            fontSize: 18.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    5.0,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        decoration: BoxDecoration(
                                                                                                          borderRadius: BorderRadius.circular(
                                                                                                            10.0,
                                                                                                          ),
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            5.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.nameStore,
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            maxLines: 18,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFA1A1A1,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    1.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      5.0,
                                                                                                      0.0,
                                                                                                      5.0,
                                                                                                      5.0,
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.distance.toString(),
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            5.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_27dxtl2j,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 100.0,
                                                                                                            height: 1.0,
                                                                                                            decoration: BoxDecoration(),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Image.network(
                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                          width: 16.0,
                                                                                                          height: 16.0,
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              8.0,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              valueOrDefault<
                                                                                                                String
                                                                                                              >(
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.capacity.toString(),
                                                                                                                'ไม่ระบุ',
                                                                                                              ),
                                                                                                              style:
                                                                                                                  Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: Theme.of(
                                                                                                                        context,
                                                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                                                    ),
                                                                                                                    color: Color(
                                                                                                                      0xFFE8E8E8,
                                                                                                                    ),
                                                                                                                    fontSize: 13.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            2.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_3fd0zq8r,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            2.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.maxCapacity.toString(),
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    if (!DataEventsStruct.maybeFromMap(
                                                                                      dataEventsItem,
                                                                                    )!.free)
                                                                                      Flexible(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            1.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              1.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                gradient: LinearGradient(
                                                                                                  colors: [
                                                                                                    Color(
                                                                                                      0xFF411010,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFFDB0000,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFFFF0000,
                                                                                                    ),
                                                                                                  ],
                                                                                                  stops: [
                                                                                                    0.0,
                                                                                                    0.2,
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
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  bottomLeft: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  bottomRight: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  topLeft: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  topRight: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.priceDetail,
                                                                                                            '1,200 ฿',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.3,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    if (DataEventsStruct.maybeFromMap(
                                                                                          dataEventsItem,
                                                                                        )?.free ??
                                                                                        true)
                                                                                      Flexible(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            1.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              1.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                gradient: LinearGradient(
                                                                                                  colors: [
                                                                                                    Color(
                                                                                                      0xFF1E4110,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFF58BB2F,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFF58BB2F,
                                                                                                    ),
                                                                                                  ],
                                                                                                  stops: [
                                                                                                    0.0,
                                                                                                    0.2,
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
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  bottomLeft: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  bottomRight: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  topLeft: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  topRight: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_l73fai7v,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.3,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (_showLegacyEventGrid)
                                                Align(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                          0.0,
                                                          -1.0,
                                                        ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            5.0,
                                                            1.0,
                                                            5.0,
                                                            0.0,
                                                          ),
                                                      child: AuthUserStreamWidget(
                                                        builder: (context) => Builder(
                                                          builder: (context) {
                                                            final dataEvents =
                                                                functions
                                                                    .dataEvent(
                                                                      AppState()
                                                                          .Filterdistance,
                                                                      homeBodyEventsRecordList
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.showsearch(
                                                                              _model.textController.text,
                                                                              functions.addName(
                                                                                e.nameArtise.toList(),
                                                                              ),
                                                                            )!,
                                                                          )
                                                                          .toList(),
                                                                      AppState()
                                                                          .locationsearch,
                                                                      _model
                                                                          .stylemusic
                                                                          .toList(),
                                                                      (currentUserDocument?.loveEvent?.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      AppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      _model
                                                                          .page,
                                                                      _model
                                                                          .mapOn,
                                                                      _model
                                                                          .selectdate,
                                                                      AppState()
                                                                          .dateclick,
                                                                      false,
                                                                      _model
                                                                          .lovefilter,
                                                                    )
                                                                    ?.toList() ??
                                                                [];

                                                            return Wrap(
                                                              spacing: 1.0,
                                                              runSpacing: 1.0,
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .start,
                                                              direction: Axis
                                                                  .horizontal,
                                                              runAlignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              verticalDirection:
                                                                  VerticalDirection
                                                                      .down,
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: List.generate(
                                                                dataEvents
                                                                    .length,
                                                                (
                                                                  dataEventsIndex,
                                                                ) {
                                                                  final dataEventsItem =
                                                                      dataEvents[dataEventsIndex];
                                                                  return Opacity(
                                                                    opacity:
                                                                        DataEventsStruct.maybeFromMap(
                                                                              dataEventsItem,
                                                                            )?.nameStore ==
                                                                            '007'
                                                                        ? 0.0
                                                                        : 1.0,
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                            5.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            MediaQuery.sizeOf(
                                                                              context,
                                                                            ).width *
                                                                            0.446,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                            10.0,
                                                                          ),
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await _showEventDetailSheet(
                                                                                      DataEventsStruct.maybeFromMap(
                                                                                        dataEventsItem,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    width:
                                                                                        MediaQuery.sizeOf(
                                                                                          context,
                                                                                        ).width *
                                                                                        0.444,
                                                                                    height:
                                                                                        valueOrDefault<
                                                                                          double
                                                                                        >(
                                                                                          functions.posterscale(
                                                                                            _model.wide,
                                                                                            false,
                                                                                          ),
                                                                                          250.0,
                                                                                        ),
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(
                                                                                        0xFF161616,
                                                                                      ),
                                                                                      image: DecorationImage(
                                                                                        fit: BoxFit.cover,
                                                                                        image: Image.network(
                                                                                          _safeEventsImageUrl(
                                                                                            DataEventsStruct.maybeFromMap(
                                                                                              dataEventsItem,
                                                                                            )?.poster,
                                                                                            fallback: _kEventsFallbackPosterUrl,
                                                                                          ),
                                                                                        ).image,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        bottomRight: Radius.circular(
                                                                                          0.0,
                                                                                        ),
                                                                                        topLeft: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                        topRight: Radius.circular(
                                                                                          10.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  10.0,
                                                                                                  10.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Container(
                                                                                                  width: 42.0,
                                                                                                  constraints: const BoxConstraints(
                                                                                                    minHeight: 42.0,
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(
                                                                                                      0xFFFF0000,
                                                                                                    ),
                                                                                                    borderRadius: BorderRadius.circular(
                                                                                                      10.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          0.0,
                                                                                                          3.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          functions
                                                                                                              .dateEventday(
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.date,
                                                                                                              )
                                                                                                              .toString(),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color:
                                                                                                                    Theme.of(
                                                                                                                          context,
                                                                                                                        )
                                                                                                                        .extension<
                                                                                                                          CustomColors
                                                                                                                        >()!
                                                                                                                        .primaryText,
                                                                                                                fontSize: 17.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                                lineHeight: 1.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          0.0,
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            functions.dateMonthTH(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.date,
                                                                                                            ),
                                                                                                            'ไม่ระบุ',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontWeight,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color:
                                                                                                                    Theme.of(
                                                                                                                          context,
                                                                                                                        )
                                                                                                                        .extension<
                                                                                                                          CustomColors
                                                                                                                        >()!
                                                                                                                        .primaryText,
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                                lineHeight: 1.0,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                0.0,
                                                                                                0.0,
                                                                                                5.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                          [])
                                                                                                      .contains(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.docRef,
                                                                                                      )) {
                                                                                                    await currentUserReference!.update(
                                                                                                      {
                                                                                                        ...mapToSupabase(
                                                                                                          {
                                                                                                            'loveEvent': FieldValue.arrayRemove(
                                                                                                              [
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.docRef,
                                                                                                              ],
                                                                                                            ),
                                                                                                          },
                                                                                                        ),
                                                                                                      },
                                                                                                    );
                                                                                                  } else {
                                                                                                    await currentUserReference!.update(
                                                                                                      {
                                                                                                        ...mapToSupabase(
                                                                                                          {
                                                                                                            'loveEvent': FieldValue.arrayUnion(
                                                                                                              [
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.docRef,
                                                                                                              ],
                                                                                                            ),
                                                                                                          },
                                                                                                        ),
                                                                                                      },
                                                                                                    );
                                                                                                  }
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 38.0,
                                                                                                  height: 38.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Color(
                                                                                                      0x22000000,
                                                                                                    ),
                                                                                                    shape: BoxShape.circle,
                                                                                                  ),
                                                                                                  child: Stack(
                                                                                                    children: [
                                                                                                      if (!(currentUserDocument?.loveEvent?.toList() ??
                                                                                                              [])
                                                                                                          .contains(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.docRef,
                                                                                                          ))
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              0.0,
                                                                                                              1.5,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: FaIcon(
                                                                                                              FontAwesomeIcons.heart,
                                                                                                              color: Color(
                                                                                                                0xFFFDFDFD,
                                                                                                              ),
                                                                                                              size: 23.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      if ((currentUserDocument?.loveEvent?.toList() ??
                                                                                                              [])
                                                                                                          .contains(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.docRef,
                                                                                                          ))
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              0.0,
                                                                                                              1.5,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: FaIcon(
                                                                                                              FontAwesomeIcons.solidHeart,
                                                                                                              color: Color(
                                                                                                                0xFFFF0000,
                                                                                                              ),
                                                                                                              size: 23.0,
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
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            decoration: BoxDecoration(),
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: double.infinity,
                                                                                          height:
                                                                                              MediaQuery.sizeOf(
                                                                                                context,
                                                                                              ).height *
                                                                                              0.22,
                                                                                          decoration: BoxDecoration(
                                                                                            gradient: LinearGradient(
                                                                                              colors: [
                                                                                                Colors.transparent,
                                                                                                Color(
                                                                                                  0xED000000,
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
                                                                                            borderRadius: BorderRadius.only(
                                                                                              bottomLeft: Radius.circular(
                                                                                                10.0,
                                                                                              ),
                                                                                              bottomRight: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                              topLeft: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                              topRight: Radius.circular(
                                                                                                0.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              5.0,
                                                                                              0.0,
                                                                                              5.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    -1.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      5.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                      0.0,
                                                                                                    ),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<
                                                                                                        String
                                                                                                      >(
                                                                                                        DataEventsStruct.maybeFromMap(
                                                                                                          dataEventsItem,
                                                                                                        )?.nameArtise.firstOrNull,
                                                                                                        'ไม่ระบุ',
                                                                                                      ),
                                                                                                      maxLines: 18,
                                                                                                      style:
                                                                                                          Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                            ),
                                                                                                            color:
                                                                                                                Theme.of(
                                                                                                                      context,
                                                                                                                    )
                                                                                                                    .extension<
                                                                                                                      CustomColors
                                                                                                                    >()!
                                                                                                                    .primaryText,
                                                                                                            fontSize: 18.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    5.0,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        decoration: BoxDecoration(
                                                                                                          borderRadius: BorderRadius.circular(
                                                                                                            10.0,
                                                                                                          ),
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            5.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            2.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.nameStore,
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            maxLines: 18,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFA1A1A1,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(
                                                                                                    1.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                      5.0,
                                                                                                      0.0,
                                                                                                      5.0,
                                                                                                      5.0,
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.distance.toString(),
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            5.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_hf127elb,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 100.0,
                                                                                                            height: 1.0,
                                                                                                            decoration: BoxDecoration(),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Image.network(
                                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                          width: 16.0,
                                                                                                          height: 16.0,
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                        Align(
                                                                                                          alignment: AlignmentDirectional(
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                              8.0,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                              0.0,
                                                                                                            ),
                                                                                                            child: Text(
                                                                                                              valueOrDefault<
                                                                                                                String
                                                                                                              >(
                                                                                                                DataEventsStruct.maybeFromMap(
                                                                                                                  dataEventsItem,
                                                                                                                )?.capacity.toString(),
                                                                                                                'ไม่ระบุ',
                                                                                                              ),
                                                                                                              style:
                                                                                                                  Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: Theme.of(
                                                                                                                        context,
                                                                                                                      ).textTheme.bodyMedium!.fontStyle,
                                                                                                                    ),
                                                                                                                    color: Color(
                                                                                                                      0xFFE8E8E8,
                                                                                                                    ),
                                                                                                                    fontSize: 13.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            2.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            AppLocalizations.of(
                                                                                                              context,
                                                                                                            )!.k_5am4kqpc,
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 14.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            2.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventsItem,
                                                                                                              )?.maxCapacity.toString(),
                                                                                                              'ไม่ระบุ',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    if (!DataEventsStruct.maybeFromMap(
                                                                                      dataEventsItem,
                                                                                    )!.free)
                                                                                      Flexible(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            1.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              1.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                gradient: LinearGradient(
                                                                                                  colors: [
                                                                                                    Color(
                                                                                                      0xFF411010,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFFDB0000,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFFFF0000,
                                                                                                    ),
                                                                                                  ],
                                                                                                  stops: [
                                                                                                    0.0,
                                                                                                    0.2,
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
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  bottomLeft: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  bottomRight: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  topLeft: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  topRight: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventsItem,
                                                                                                            )?.priceDetail,
                                                                                                            '1,200 ฿',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.3,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    if (DataEventsStruct.maybeFromMap(
                                                                                          dataEventsItem,
                                                                                        )?.free ??
                                                                                        true)
                                                                                      Flexible(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(
                                                                                            1.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                              0.0,
                                                                                              0.0,
                                                                                              1.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                gradient: LinearGradient(
                                                                                                  colors: [
                                                                                                    Color(
                                                                                                      0xFF1E4110,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFF58BB2F,
                                                                                                    ),
                                                                                                    Color(
                                                                                                      0xFF58BB2F,
                                                                                                    ),
                                                                                                  ],
                                                                                                  stops: [
                                                                                                    0.0,
                                                                                                    0.2,
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
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  bottomLeft: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  bottomRight: Radius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                  topLeft: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  topRight: Radius.circular(
                                                                                                    0.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  Column(
                                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                          10.0,
                                                                                                          2.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_zsbddjf5,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.3,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (_showLegacyEventGrid &&
                                                  functions
                                                          .dataEvent(
                                                            context
                                                                .appState
                                                                .Filterdistance,
                                                            homeBodyEventsRecordList
                                                                .where(
                                                                  (
                                                                    e,
                                                                  ) => functions.showsearch(
                                                                    _model
                                                                        .textController
                                                                        .text,
                                                                    functions.addName(
                                                                      e.nameArtise
                                                                          .toList(),
                                                                    ),
                                                                  )!,
                                                                )
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .locationsearch,
                                                            _model.stylemusic
                                                                .toList(),
                                                            (currentUserDocument
                                                                        ?.loveEvent
                                                                        ?.toList() ??
                                                                    [])
                                                                .toList(),
                                                            context
                                                                .appState
                                                                .StyleVenuse
                                                                .toList(),
                                                            _model.page,
                                                            _model.mapOn,
                                                            false,
                                                            context
                                                                .appState
                                                                .dateclick,
                                                            true,
                                                            _model.lovefilter,
                                                          )!
                                                          .length >
                                                      20)
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        20.0,
                                                        0.0,
                                                        0.0,
                                                      ),
                                                  child: AuthUserStreamWidget(
                                                    builder: (context) => Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
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
                                                              if (_model.page !=
                                                                  1) {
                                                                _model.page =
                                                                    _model
                                                                        .page! +
                                                                    -1;
                                                                safeSetState(
                                                                  () {},
                                                                );
                                                                await _model
                                                                    .columnController
                                                                    ?.animateTo(
                                                                      0,
                                                                      duration: Duration(
                                                                        milliseconds:
                                                                            200,
                                                                      ),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 44.0,
                                                              height: 44.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                    color: Color(
                                                                      0xFF1C1C1C,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.0,
                                                                        ),
                                                                  ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                          0.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .chevron_left,
                                                                      color: Theme.of(context)
                                                                          .extension<
                                                                            CustomColors
                                                                          >()!
                                                                          .primaryText,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                  ),
                                                              child: Container(
                                                                width: 44.0,
                                                                height: 44.0,
                                                                decoration: BoxDecoration(
                                                                  color: Color(
                                                                    0xFFFF0000,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        10.0,
                                                                      ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Text(
                                                                        valueOrDefault<
                                                                          String
                                                                        >(
                                                                          _model
                                                                              .page
                                                                              ?.toString(),
                                                                          '0',
                                                                        ),
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.bodyMedium!.override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                              fontSize: 20.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontWeight,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.page =
                                                                _model.page! +
                                                                1;
                                                            safeSetState(() {});
                                                            await _model
                                                                .columnController
                                                                ?.animateTo(
                                                                  0,
                                                                  duration:
                                                                      Duration(
                                                                        milliseconds:
                                                                            200,
                                                                      ),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                          },
                                                          child: Container(
                                                            width: 44.0,
                                                            height: 44.0,
                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Color(
                                                                    0xFF1C1C1C,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        10.0,
                                                                      ),
                                                                ),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .navigate_next,
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    size: 24.0,
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
                                            ].addToEnd(SizedBox(height: 120.0)),
                                          ),
                                        ).animateOnPageLoad(
                                          animationsMap['columnOnPageLoadAnimation']!,
                                        ),
                                  ),
                                ),
                              ),
                            if (_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            -1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              17.0,
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
                                                            InkWell(
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
                                                                AppState()
                                                                        .locationsearch =
                                                                    AppState()
                                                                        .MapCenter;
                                                                safeSetState(
                                                                  () {},
                                                                );
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        15.0,
                                                                      ),
                                                                  border: Border.all(
                                                                    color: Color(
                                                                      0xFF757575,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional.fromSTEB(
                                                                        15.0,
                                                                        2.0,
                                                                        15.0,
                                                                        3.0,
                                                                      ),
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                      context,
                                                                    )!.k_z1r3or6y,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                      font: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: Theme.of(
                                                                          context,
                                                                        ).textTheme.bodyMedium!.fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            1.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              7.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 120.0,
                                                          height: 2.0,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                  0xFFFF0000,
                                                                ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        10.0,
                                                        0.0,
                                                        10.0,
                                                        13.0,
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                defaultLocation:
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                              );
                                                          if (_model.mapOn) {
                                                            _model.mapOn =
                                                                false;
                                                            context.appState.update(
                                                              () {
                                                                context
                                                                        .appState
                                                                        .mapModeOn =
                                                                    false;
                                                              },
                                                            );
                                                            safeSetState(() {});
                                                          } else {
                                                            _model.mapOn = true;
                                                            context.appState.update(
                                                              () {
                                                                context
                                                                        .appState
                                                                        .mapModeOn =
                                                                    true;
                                                              },
                                                            );
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 27.0,
                                                          height: 27.0,
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                  0xFFFF0000,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Icon(
                                                            Icons.close,
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .extension<
                                                                      CustomColors
                                                                    >()!
                                                                    .primaryText,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      MundayIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 90.0,
                                                        buttonSize: 50.0,
                                                        fillColor: Color(
                                                          0xCC000000,
                                                        ),
                                                        icon: Icon(
                                                          Icons.my_location,
                                                          color:
                                                              Theme.of(context)
                                                                  .extension<
                                                                    CustomColors
                                                                  >()!
                                                                  .info,
                                                          size: 29.0,
                                                        ),
                                                        onPressed: () async {
                                                          currentUserLocationValue =
                                                              await getCurrentUserLocation(
                                                                defaultLocation:
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                              );
                                                          AppState()
                                                                  .locationsearch =
                                                              currentUserLocationValue;
                                                          safeSetState(() {});
                                                          context
                                                                  .appState
                                                                  .MoveMap =
                                                              true;
                                                          safeSetState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                              0.0,
                                              1.0,
                                            ),
                                            child:
                                                Container(
                                                  height:
                                                      valueOrDefault<double>(
                                                        functions.posterscale(
                                                          _model.wide,
                                                          true,
                                                        ),
                                                        250.0,
                                                      ),
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      AuthUserStreamWidget(
                                                        builder: (context) => Builder(
                                                          builder: (context) {
                                                            final dataEvent =
                                                                functions
                                                                    .dataEvent(
                                                                      AppState()
                                                                              .Filterdistance ??
                                                                          500.0,
                                                                      homeBodyEventsRecordList
                                                                          .where(
                                                                            (
                                                                              e,
                                                                            ) => functions.showsearch(
                                                                              _model.textController.text,
                                                                              functions.addName(
                                                                                e.nameArtise.toList(),
                                                                              ),
                                                                            )!,
                                                                          )
                                                                          .toList(),
                                                                      AppState()
                                                                              .locationsearch ??
                                                                          currentUserLocationValue ??
                                                                          LatLng(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      _model
                                                                          .stylemusic
                                                                          .toList(),
                                                                      (currentUserDocument?.loveEvent?.toList() ??
                                                                              [])
                                                                          .toList(),
                                                                      AppState()
                                                                          .StyleVenuse
                                                                          .toList(),
                                                                      60,
                                                                      _model
                                                                          .mapOn,
                                                                      _model
                                                                          .selectdate,
                                                                      AppState()
                                                                          .dateclick,
                                                                      false,
                                                                      _model
                                                                          .lovefilter,
                                                                    )
                                                                    ?.toList() ??
                                                                [];

                                                            return Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child: CarouselSlider.builder(
                                                                itemCount:
                                                                    dataEvent
                                                                        .length,
                                                                itemBuilder:
                                                                    (
                                                                      context,
                                                                      dataEventIndex,
                                                                      _,
                                                                    ) {
                                                                      final dataEventItem =
                                                                          dataEvent[dataEventIndex];
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child: Align(
                                                                              alignment: AlignmentDirectional(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await _showEventDetailSheet(
                                                                                    DataEventsStruct.maybeFromMap(
                                                                                      dataEventItem,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  width:
                                                                                      MediaQuery.sizeOf(
                                                                                        context,
                                                                                      ).width *
                                                                                      0.444,
                                                                                  height: functions.posterscale(
                                                                                    _model.wide,
                                                                                    false,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(
                                                                                      0xFF161616,
                                                                                    ),
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: Image.network(
                                                                                        _safeEventsImageUrl(
                                                                                          DataEventsStruct.maybeFromMap(
                                                                                            dataEventItem,
                                                                                          )?.poster,
                                                                                          fallback: _kEventsFallbackPosterUrl,
                                                                                        ),
                                                                                      ).image,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.only(
                                                                                      bottomLeft: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                      bottomRight: Radius.circular(
                                                                                        0.0,
                                                                                      ),
                                                                                      topLeft: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                      topRight: Radius.circular(
                                                                                        10.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(
                                                                                              0.0,
                                                                                              0.0,
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                10.0,
                                                                                                10.0,
                                                                                                0.0,
                                                                                                0.0,
                                                                                              ),
                                                                                              child: Container(
                                                                                                width: 42.0,
                                                                                                constraints: const BoxConstraints(
                                                                                                  minHeight: 42.0,
                                                                                                ),
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(
                                                                                                    0xFFFF0000,
                                                                                                  ),
                                                                                                  borderRadius: BorderRadius.circular(
                                                                                                    10.0,
                                                                                                  ),
                                                                                                ),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        0.0,
                                                                                                        3.0,
                                                                                                        0.0,
                                                                                                        0.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        functions
                                                                                                            .dateEventday(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.date,
                                                                                                            )
                                                                                                            .toString(),
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color:
                                                                                                                  Theme.of(
                                                                                                                        context,
                                                                                                                      )
                                                                                                                      .extension<
                                                                                                                        CustomColors
                                                                                                                      >()!
                                                                                                                      .primaryText,
                                                                                                              fontSize: 17.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w600,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                              lineHeight: 1.0,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<
                                                                                                          String
                                                                                                        >(
                                                                                                          functions.dateMonthTH(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventItem,
                                                                                                            )?.date,
                                                                                                          ),
                                                                                                          'ไม่ระบุ',
                                                                                                        ),
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color:
                                                                                                                  Theme.of(
                                                                                                                        context,
                                                                                                                      )
                                                                                                                      .extension<
                                                                                                                        CustomColors
                                                                                                                      >()!
                                                                                                                      .primaryText,
                                                                                                              fontSize: 13.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontWeight,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                              lineHeight: 1.0,
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
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: double.infinity,
                                                                                          height: double.infinity,
                                                                                          decoration: BoxDecoration(),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Colors.transparent,
                                                                                              Color(
                                                                                                0xCB000000,
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
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            5.0,
                                                                                            0.0,
                                                                                            5.0,
                                                                                            0.0,
                                                                                          ),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  -1.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                    0.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventItem,
                                                                                                      )?.nameArtise.firstOrNull,
                                                                                                      'ไม่ระบุ',
                                                                                                    ),
                                                                                                    maxLines: 18,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          color:
                                                                                                              Theme.of(
                                                                                                                    context,
                                                                                                                  )
                                                                                                                  .extension<
                                                                                                                    CustomColors
                                                                                                                  >()!
                                                                                                                  .primaryText,
                                                                                                          fontSize: 18.0,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  0.0,
                                                                                                  3.0,
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                        5.0,
                                                                                                        0.0,
                                                                                                        0.0,
                                                                                                        2.0,
                                                                                                      ),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<
                                                                                                          String
                                                                                                        >(
                                                                                                          DataEventsStruct.maybeFromMap(
                                                                                                            dataEventItem,
                                                                                                          )?.nameStore,
                                                                                                          'ไม่ระบุ',
                                                                                                        ),
                                                                                                        maxLines: 18,
                                                                                                        style:
                                                                                                            Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                              color: Color(
                                                                                                                0xFFA1A1A1,
                                                                                                              ),
                                                                                                              fontSize: 14.0,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              fontStyle: Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(
                                                                                                  1.0,
                                                                                                  0.0,
                                                                                                ),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    5.0,
                                                                                                    0.0,
                                                                                                    5.0,
                                                                                                    5.0,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                    children: [
                                                                                                      Image.network(
                                                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4kl4e8mwdzi6/MEE2.png',
                                                                                                        width: 16.0,
                                                                                                        height: 16.0,
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                                      Align(
                                                                                                        alignment: AlignmentDirectional(
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            8.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.capacity.toString(),
                                                                                                              '-',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_djg788wu,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 14.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          2.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<
                                                                                                            String
                                                                                                          >(
                                                                                                            DataEventsStruct.maybeFromMap(
                                                                                                              dataEventItem,
                                                                                                            )?.maxCapacity.toString(),
                                                                                                            '-',
                                                                                                          ),
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        child: Container(
                                                                                                          width: 100.0,
                                                                                                          height: 1.0,
                                                                                                          decoration: BoxDecoration(),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Align(
                                                                                                        alignment: AlignmentDirectional(
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                            10.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                            0.0,
                                                                                                          ),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<
                                                                                                              String
                                                                                                            >(
                                                                                                              DataEventsStruct.maybeFromMap(
                                                                                                                dataEventItem,
                                                                                                              )?.distance.toString(),
                                                                                                              '-',
                                                                                                            ),
                                                                                                            style:
                                                                                                                Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: Theme.of(
                                                                                                                      context,
                                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                                  ),
                                                                                                                  color: Color(
                                                                                                                    0xFFE8E8E8,
                                                                                                                  ),
                                                                                                                  fontSize: 13.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                          5.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                          0.0,
                                                                                                        ),
                                                                                                        child: Text(
                                                                                                          AppLocalizations.of(
                                                                                                            context,
                                                                                                          )!.k_cbd0lvds,
                                                                                                          style:
                                                                                                              Theme.of(
                                                                                                                context,
                                                                                                              ).textTheme.bodyMedium!.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: Theme.of(
                                                                                                                    context,
                                                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                                                ),
                                                                                                                color: Color(
                                                                                                                  0xFFE8E8E8,
                                                                                                                ),
                                                                                                                fontSize: 13.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w600,
                                                                                                                fontStyle: Theme.of(
                                                                                                                  context,
                                                                                                                ).textTheme.bodyMedium!.fontStyle,
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
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              if (!DataEventsStruct.maybeFromMap(
                                                                                dataEventItem,
                                                                              )!.free)
                                                                                Flexible(
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      1.0,
                                                                                      1.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        1.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Color(
                                                                                                0xFF411010,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFFDB0000,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFFFF0000,
                                                                                              ),
                                                                                            ],
                                                                                            stops: [
                                                                                              0.0,
                                                                                              0.2,
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
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<
                                                                                                      String
                                                                                                    >(
                                                                                                      DataEventsStruct.maybeFromMap(
                                                                                                        dataEventItem,
                                                                                                      )?.priceDetail,
                                                                                                      '1,200 ฿',
                                                                                                    ),
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.3,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
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
                                                                                ),
                                                                              Container(
                                                                                width: functions.positionprice(
                                                                                  _model.wide,
                                                                                ),
                                                                                decoration: BoxDecoration(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              if (DataEventsStruct.maybeFromMap(
                                                                                    dataEventItem,
                                                                                  )?.free ??
                                                                                  true)
                                                                                Flexible(
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(
                                                                                      1.0,
                                                                                      1.0,
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        1.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Color(
                                                                                                0xFF1E4110,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFF58BB2F,
                                                                                              ),
                                                                                              Color(
                                                                                                0xFF58BB2F,
                                                                                              ),
                                                                                            ],
                                                                                            stops: [
                                                                                              0.0,
                                                                                              0.2,
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
                                                                                          borderRadius: BorderRadius.only(
                                                                                            bottomLeft: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            bottomRight: Radius.circular(
                                                                                              10.0,
                                                                                            ),
                                                                                            topLeft: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                            topRight: Radius.circular(
                                                                                              0.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                    10.0,
                                                                                                    2.0,
                                                                                                  ),
                                                                                                  child: Text(
                                                                                                    AppLocalizations.of(
                                                                                                      context,
                                                                                                    )!.k_ebkvitz2,
                                                                                                    style:
                                                                                                        Theme.of(
                                                                                                          context,
                                                                                                        ).textTheme.bodyMedium!.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: Theme.of(
                                                                                                              context,
                                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: 13.0,
                                                                                                          letterSpacing: 0.3,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: Theme.of(
                                                                                                            context,
                                                                                                          ).textTheme.bodyMedium!.fontStyle,
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
                                                                                ),
                                                                              Container(
                                                                                width: functions.positionprice(
                                                                                  _model.wide,
                                                                                ),
                                                                                decoration: BoxDecoration(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                carouselController:
                                                                    _model.carouselController ??=
                                                                        CarouselSliderController(),
                                                                options: CarouselOptions(
                                                                  initialPage: max(
                                                                    0,
                                                                    min(
                                                                      1,
                                                                      dataEvent
                                                                              .length -
                                                                          1,
                                                                    ),
                                                                  ),
                                                                  viewportFraction:
                                                                      0.5,
                                                                  disableCenter:
                                                                      true,
                                                                  enlargeCenterPage:
                                                                      false,
                                                                  enlargeFactor:
                                                                      0.0,
                                                                  enableInfiniteScroll:
                                                                      false,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  autoPlay:
                                                                      false,
                                                                  onPageChanged: (index, _) async {
                                                                    _model.carouselCurrentIndex =
                                                                        index;
                                                                    if (_model
                                                                            .slide ==
                                                                        true) {
                                                                      AppState()
                                                                          .EventSelection = DataEventsStruct.maybeFromMap(
                                                                        dataEvent.elementAtOrNull(
                                                                          _model
                                                                              .carouselCurrentIndex,
                                                                        ),
                                                                      )?.docRef;
                                                                      safeSetState(
                                                                        () {},
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              -1.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 60.0,
                                                          height:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black,
                                                              ],
                                                              stops: [0.0, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                    1.0,
                                                                    0.0,
                                                                  ),
                                                              end:
                                                                  AlignmentDirectional(
                                                                    -1.0,
                                                                    0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              1.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 60.0,
                                                          height:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                Colors.black,
                                                                Colors
                                                                    .transparent,
                                                              ],
                                                              stops: [0.0, 1.0],
                                                              begin:
                                                                  AlignmentDirectional(
                                                                    1.0,
                                                                    0.0,
                                                                  ),
                                                              end:
                                                                  AlignmentDirectional(
                                                                    -1.0,
                                                                    0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (functions
                                                              .dataEvent(
                                                                AppState()
                                                                        .Filterdistance ??
                                                                    500.0,
                                                                homeBodyEventsRecordList
                                                                    .where(
                                                                      (
                                                                        e,
                                                                      ) => functions.showsearch(
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                        functions.addName(
                                                                          e.nameArtise
                                                                              .toList(),
                                                                        ),
                                                                      )!,
                                                                    )
                                                                    .toList(),
                                                                AppState()
                                                                        .locationsearch ??
                                                                    currentUserLocationValue ??
                                                                    LatLng(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                _model
                                                                    .stylemusic
                                                                    .toList(),
                                                                (currentUserDocument
                                                                            ?.loveEvent
                                                                            ?.toList() ??
                                                                        [])
                                                                    .toList(),
                                                                AppState()
                                                                    .StyleVenuse
                                                                    .toList(),
                                                                _model.page,
                                                                _model.mapOn,
                                                                _model
                                                                    .selectdate,
                                                                AppState()
                                                                    .dateclick,
                                                                false,
                                                                _model
                                                                    .lovefilter,
                                                              )
                                                              ?.length ==
                                                          0)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                10.0,
                                                                0.0,
                                                                10.0,
                                                                0.0,
                                                              ),
                                                          child: AuthUserStreamWidget(
                                                            builder: (context) => Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                color: Color(
                                                                  0x9A000000,
                                                                ),
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
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      0.0,
                                                                      25.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .notifications_none,
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          72.0,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_16vbnwxq,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.headlineMedium!.override(
                                                                              font: GoogleFonts.outfit(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.headlineMedium!.fontStyle,
                                                                              ),
                                                                              color: Colors.white,
                                                                              fontSize: 30.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.headlineMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            25.0,
                                                                            4.0,
                                                                            25.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                          context,
                                                                        )!.k_jxcp0zzg,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            Theme.of(
                                                                              context,
                                                                            ).textTheme.labelMedium!.override(
                                                                              font: GoogleFonts.plusJakartaSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.labelMedium!.fontStyle,
                                                                              ),
                                                                              color: Color(
                                                                                0xFFBCBCBC,
                                                                              ),
                                                                              fontSize: 14.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: Theme.of(
                                                                                context,
                                                                              ).textTheme.labelMedium!.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          7.0,
                                                                          0.0,
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
                                                                            if (_model.selectdate) {
                                                                              _model.selectdate = false;
                                                                              _model.page = 1;
                                                                              safeSetState(
                                                                                () {},
                                                                              );
                                                                              await _model.columnController?.animateTo(
                                                                                0,
                                                                                duration: Duration(
                                                                                  milliseconds: 300,
                                                                                ),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            } else {
                                                                              _model.selectdate = true;
                                                                              _model.page = 1;
                                                                              safeSetState(
                                                                                () {},
                                                                              );
                                                                              await _model.columnController?.animateTo(
                                                                                0,
                                                                                duration: Duration(
                                                                                  milliseconds: 300,
                                                                                ),
                                                                                curve: Curves.ease,
                                                                              );
                                                                            }
                                                                          },
                                                                          child: Container(
                                                                            height:
                                                                                30.0,
                                                                            decoration: BoxDecoration(
                                                                              color: _model.selectdate
                                                                                  ? Color(
                                                                                      0xFFFF0000,
                                                                                    )
                                                                                  : Color(
                                                                                      0xFF1C1C1C,
                                                                                    ),
                                                                              borderRadius: BorderRadius.circular(
                                                                                20.0,
                                                                              ),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: _model.selectdate
                                                                                    ? Color(
                                                                                        0xFFFF0000,
                                                                                      )
                                                                                    : Color(
                                                                                        0xFF1C1C1C,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    15.0,
                                                                                    0.0,
                                                                                    6.0,
                                                                                    1.0,
                                                                                  ),
                                                                                  child: Text(
                                                                                    AppLocalizations.of(
                                                                                      context,
                                                                                    )!.k_twcppxxh,
                                                                                    style:
                                                                                        Theme.of(
                                                                                          context,
                                                                                        ).textTheme.bodyMedium!.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: Theme.of(
                                                                                              context,
                                                                                            ).textTheme.bodyMedium!.fontStyle,
                                                                                          ),
                                                                                          color: Colors.white,
                                                                                          fontSize: 14.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: Theme.of(
                                                                                            context,
                                                                                          ).textTheme.bodyMedium!.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(
                                                                                    0.0,
                                                                                    0.0,
                                                                                    15.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Icon(
                                                                                    Icons.keyboard_arrow_down,
                                                                                    color: Colors.white,
                                                                                    size: 16.0,
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
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ).animateOnPageLoad(
                                                  animationsMap['containerOnPageLoadAnimation2']!,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (!_model.mapOn && featuredEvents.isEmpty)
                              ValueListenableBuilder<bool>(
                                valueListenable: _heroCoveredNotifier,
                                builder: (context, covered, child) =>
                                    IgnorePointer(
                                      ignoring: covered,
                                      child: AnimatedSlide(
                                        duration: const Duration(
                                          milliseconds: 180,
                                        ),
                                        curve: Curves.easeOutCubic,
                                        offset: covered
                                            ? const Offset(0.0, -1.0)
                                            : Offset.zero,
                                        child: AnimatedOpacity(
                                          duration: const Duration(
                                            milliseconds: 140,
                                          ),
                                          opacity: covered ? 0.0 : 1.0,
                                          child: _EventsTopHeader(
                                            topInset: MediaQuery.paddingOf(
                                              context,
                                            ).top,
                                            featuredCount:
                                                featuredEvents.length,
                                            featuredIndex: _featuredHeroIndex,
                                            collapsed: covered,
                                            onLocationPressed: () {
                                              _model.mapOn = true;
                                              context.appState.update(() {
                                                context.appState.mapModeOn =
                                                    true;
                                              });
                                              safeSetState(() {});
                                            },
                                            onNotificationPressed: () {
                                              context.pushNamed(
                                                NotificationPage.routeName,
                                              );
                                            },
                                            onProfilePressed: () {
                                              context.pushNamed(
                                                ProfilePage.routeName,
                                                queryParameters: {
                                                  'fromSeting': serializeParam(
                                                    false,
                                                    ParamType.bool,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            if (_model.mapOn)
                              Container(
                                width: double.infinity,
                                height: _model.selectdate && _model.mapOn
                                    ? 225.0 + MediaQuery.paddingOf(context).top
                                    : eventsHeaderHeight,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.paddingOf(context).top,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          12.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    20.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    ProfilePage.routeName,
                                                    queryParameters: {
                                                      'fromSeting':
                                                          serializeParam(
                                                            false,
                                                            ParamType.bool,
                                                          ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      AuthUserStreamWidget(
                                                        builder: (context) => Container(
                                                          width: 50.0,
                                                          height: 50.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Image.network(
                                                            _safeEventsImageUrl(
                                                              currentUserPhoto,
                                                              fallback:
                                                                  _kEventsFallbackProfileUrl,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              1.0,
                                                              1.0,
                                                            ),
                                                        child: Container(
                                                          width: 18.0,
                                                          height: 18.0,
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFFFF0005,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  45.0,
                                                                ),
                                                          ),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                        0.0,
                                                                        0.0,
                                                                      ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .settings,
                                                                    color: Theme.of(context)
                                                                        .extension<
                                                                          CustomColors
                                                                        >()!
                                                                        .primaryText,
                                                                    size: 13.0,
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
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
                                                      18.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                    ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            0.0,
                                                            2.0,
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 13.0,
                                                            height: 20.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                          0.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            3.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            6.0,
                                                                        height:
                                                                            6.0,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Theme.of(
                                                                                    context,
                                                                                  )
                                                                                  .extension<
                                                                                    CustomColors
                                                                                  >()!
                                                                                  .primaryText,
                                                                          borderRadius: BorderRadius.circular(
                                                                            45.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                          0.0,
                                                                          0.0,
                                                                        ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .location_pin,
                                                                      color: Color(
                                                                        0xFFFF0000,
                                                                      ),
                                                                      size:
                                                                          14.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Container(
                                                              width: 125.0,
                                                              height: 15.0,
                                                              child: custom_widgets.LocationName(
                                                                width: 125.0,
                                                                height: 15.0,
                                                                locationNow:
                                                                    AppState()
                                                                        .locationsearch,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            -1.0,
                                                            0.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              2.0,
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: StreamBuilder<List<VenuesRecord>>(
                                                          stream:
                                                              queryVenuesRecord(),
                                                          builder: (context, snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child: CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                          Color
                                                                        >(
                                                                          Colors
                                                                              .transparent,
                                                                        ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<VenuesRecord>
                                                            textVenuesRecordList =
                                                                snapshot.data!;

                                                            return InkWell(
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
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder: (context) {
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        FocusScope.of(
                                                                          context,
                                                                        ).unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child: Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(
                                                                              context,
                                                                            ),
                                                                        child: JoinroomWidget(
                                                                          datavenuse: textVenuesRecordList
                                                                              .take(
                                                                                3,
                                                                              )
                                                                              .toList()
                                                                              .map(
                                                                                (
                                                                                  e,
                                                                                ) => e.reference,
                                                                              )
                                                                              .toList(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then(
                                                                  (value) =>
                                                                      safeSetState(
                                                                        () {},
                                                                      ),
                                                                );
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_8in2y4rt,
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Theme.of(context)
                                                                      .extension<
                                                                        CustomColors
                                                                      >()!
                                                                      .primaryText,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    5.0,
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: GestureDetector(
                                                onTap: () => context.pushNamed(
                                                  TicketPage.routeName,
                                                ),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Image.asset(
                                                            'assets/images/icon_ticket.png',
                                                            width: 27.0,
                                                            height: 27.0,
                                                          ),
                                                        ),
                                                        if ((currentUserDocument
                                                                    ?.tickets ??
                                                                [])
                                                            .isNotEmpty)
                                                          Positioned(
                                                            top: 6.0,
                                                            right: 6.0,
                                                            child: Container(
                                                              width: 14.0,
                                                              height: 14.0,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
                                                                      0xFFE52020,
                                                                    ),
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    5.0,
                                                    10.0,
                                                    0.0,
                                                  ),
                                              child: GestureDetector(
                                                onTap: () => context.pushNamed(
                                                  MainChatPage.routeName,
                                                ),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.black,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Stack(
                                                      children: [
                                                        Center(
                                                          child: Image.asset(
                                                            'assets/images/icon_message.png',
                                                            width: 22.0,
                                                            height: 22.0,
                                                          ),
                                                        ),
                                                        if ((currentUserDocument
                                                                    ?.usermassage ??
                                                                [])
                                                            .isNotEmpty)
                                                          Positioned(
                                                            top: 6.0,
                                                            right: 6.0,
                                                            child: Container(
                                                              width: 14.0,
                                                              height: 14.0,
                                                              decoration: BoxDecoration(
                                                                color:
                                                                    const Color(
                                                                      0xFFE52020,
                                                                    ),
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.5,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                    0.0,
                                                    5.0,
                                                    16.0,
                                                    0.0,
                                                  ),
                                              child: AuthUserStreamWidget(
                                                builder: (context) =>
                                                    NotificationBadgeButton(
                                                      onTap: () =>
                                                          context.pushNamed(
                                                            NotificationPage
                                                                .routeName,
                                                          ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (_model.mapOn)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0,
                                          0.0,
                                          20.0,
                                          10.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 45.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x981D1D1D),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional.fromSTEB(
                                                            15.0,
                                                            0.0,
                                                            15.0,
                                                            2.0,
                                                          ),
                                                      child: Icon(
                                                        Icons.search_rounded,
                                                        color: Theme.of(context)
                                                            .extension<
                                                              CustomColors
                                                            >()!
                                                            .primaryBtnText,
                                                        size: 22.0,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: TextFormField(
                                                          controller: _model
                                                              .textController,
                                                          focusNode: _model
                                                              .textFieldFocusNode,
                                                          onChanged: (_) =>
                                                              EasyDebounce.debounce(
                                                                '_model.textController',
                                                                Duration(
                                                                  milliseconds:
                                                                      500,
                                                                ),
                                                                () =>
                                                                    safeSetState(
                                                                      () {},
                                                                    ),
                                                              ),
                                                          onFieldSubmitted:
                                                              (_) async {
                                                                _model.textinput =
                                                                    false;
                                                                safeSetState(
                                                                  () {},
                                                                );
                                                              },
                                                          autofocus: false,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .search,
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            isDense: false,
                                                            hintText:
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_k93w5ytl,
                                                            hintStyle: Theme.of(context).textTheme.bodySmall!.override(
                                                              font: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .fontStyle,
                                                              ),
                                                              color: Color(
                                                                0xFF9D9D9D,
                                                              ),
                                                              fontSize: 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodySmall!
                                                                      .fontStyle,
                                                            ),
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                      0x00000000,
                                                                    ),
                                                                    width: 1.0,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                      0x00000000,
                                                                    ),
                                                                    width: 1.0,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                            errorBorder: UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                      0x00000000,
                                                                    ),
                                                                    width: 1.0,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                            focusedErrorBorder: UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                      0x00000000,
                                                                    ),
                                                                    width: 1.0,
                                                                  ),
                                                              borderRadius:
                                                                  const BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          4.0,
                                                                        ),
                                                                  ),
                                                            ),
                                                            suffixIcon:
                                                                _model
                                                                    .textController!
                                                                    .text
                                                                    .isNotEmpty
                                                                ? InkWell(
                                                                    onTap: () async {
                                                                      _model
                                                                          .textController
                                                                          ?.clear();
                                                                      safeSetState(
                                                                        () {},
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .clear,
                                                                      color: Color(
                                                                        0xFF757575,
                                                                      ),
                                                                      size:
                                                                          22.0,
                                                                    ),
                                                                  )
                                                                : null,
                                                          ),
                                                          style: Theme.of(context).textTheme.bodyMedium!.override(
                                                            font: GoogleFonts.openSans(
                                                              fontWeight:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                              0xFFBDBDBD,
                                                            ),
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                          ),
                                                          validator: _model
                                                              .textControllerValidator
                                                              .asValidator(
                                                                context,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 24.0,
                                                      child: VerticalDivider(
                                                        thickness: 1.0,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            0.0,
                                                          ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              4.0,
                                                              0.0,
                                                              12.0,
                                                              0.0,
                                                            ),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder: (context) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                      context,
                                                                    ).unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child: Padding(
                                                                    padding:
                                                                        MediaQuery.viewInsetsOf(
                                                                          context,
                                                                        ),
                                                                    child:
                                                                        FilterWidget(),
                                                                  ),
                                                                );
                                                              },
                                                            ).then(
                                                              (value) =>
                                                                  safeSetState(
                                                                    () {},
                                                                  ),
                                                            );

                                                            _model.page = 1;
                                                            safeSetState(() {});
                                                          },
                                                          child: Image.network(
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4mhd403jg5z2/fillter.png',
                                                            width: 30.0,
                                                            height: 28.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        if (_model.lovefilter ==
                                                            true) {
                                                          _model.lovefilter =
                                                              false;
                                                          _model.page = 1;
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.lovefilter =
                                                              true;
                                                          _model.selectdate =
                                                              false;
                                                          _model.page = 1;
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 45.0,
                                                        height: 45.0,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0x981D1D1D,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 5.0,
                                                              color: Color(
                                                                0x33000000,
                                                              ),
                                                              offset: Offset(
                                                                2.0,
                                                                2.0,
                                                              ),
                                                              spreadRadius: 4.0,
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10.0,
                                                              ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border_rounded,
                                                                color:
                                                                    _model
                                                                        .lovefilter
                                                                    ? Color(
                                                                        0xFFFF0000,
                                                                      )
                                                                    : Colors
                                                                          .white,
                                                                size: 30.0,
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
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.fromSTEB(
                                                    10.0,
                                                    0.0,
                                                    0.0,
                                                    0.0,
                                                  ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (_model.mapOn) {
                                                    _model.mapOn = false;
                                                    context.appState.update(() {
                                                      context
                                                              .appState
                                                              .mapModeOn =
                                                          false;
                                                    });
                                                    safeSetState(() {});
                                                  } else {
                                                    _model.mapOn = true;
                                                    context.appState.update(() {
                                                      context
                                                              .appState
                                                              .mapModeOn =
                                                          true;
                                                    });
                                                    safeSetState(() {});
                                                  }

                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: 45.0,
                                                  height: 45.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x981D1D1D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.0,
                                                        ),
                                                    border: Border.all(
                                                      color: _model.mapOn
                                                          ? Color(0xFFA5A5A5)
                                                          : Color(0x981D1D1D),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                0.0,
                                                              ),
                                                          child: Image.asset(
                                                            'assets/images/7089161_google_maps_icon.png',
                                                            width: 32.0,
                                                            height: 32.0,
                                                            fit: BoxFit.cover,
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
                                    Align(
                                      alignment: AlignmentDirectional(
                                        -0.8,
                                        0.11,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00FFFFFF),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                20.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller: _model.rowController,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                if (_model.selectdate)
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      minWidth: 60.0,
                                                    ),
                                                    height: 30.0,
                                                    decoration: BoxDecoration(),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                            0.0,
                                                            -1.3,
                                                          ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                  0.0,
                                                                  0.0,
                                                                ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    15.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                valueOrDefault<
                                                                  String
                                                                >(
                                                                  functions.month(
                                                                    AppState()
                                                                        .dateclick,
                                                                  ),
                                                                  'ไม่ระบุ',
                                                                ),
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      15.0,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      0.9,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ).animateOnPageLoad(
                                                    animationsMap['containerOnPageLoadAnimation3']!,
                                                  ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        7.0,
                                                        0.0,
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
                                                      if (_model.selectdate) {
                                                        _model.selectdate =
                                                            false;
                                                        _model.page = 1;
                                                        safeSetState(() {});
                                                        await _model
                                                            .columnController
                                                            ?.animateTo(
                                                              0,
                                                              duration: Duration(
                                                                milliseconds:
                                                                    300,
                                                              ),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                      } else {
                                                        _model.selectdate =
                                                            true;
                                                        _model.page = 1;
                                                        safeSetState(() {});
                                                        await _model
                                                            .columnController
                                                            ?.animateTo(
                                                              0,
                                                              duration: Duration(
                                                                milliseconds:
                                                                    300,
                                                              ),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: _model.selectdate
                                                            ? Color(0xFFFF0000)
                                                            : Color(0xFF1C1C1C),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.0,
                                                            ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color:
                                                              _model.selectdate
                                                              ? Color(
                                                                  0xFFFF0000,
                                                                )
                                                              : Color(
                                                                  0xFF757575,
                                                                ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  4.0,
                                                                  1.0,
                                                                ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.k_58xy52fz,
                                                              style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                font: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                ),
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              color:
                                                                  Colors.white,
                                                              size: 16.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        7.0,
                                                        0.0,
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
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                context,
                                                              ).unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  MediaQuery.viewInsetsOf(
                                                                    context,
                                                                  ),
                                                              child:
                                                                  FilterWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then(
                                                        (value) =>
                                                            safeSetState(() {}),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF1C1C1C,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.0,
                                                            ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: Color(
                                                            0xFF757575,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              1.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppState()
                                                                    .Filterdistance
                                                                    .toString(),
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_kc51jfwx,
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        7.0,
                                                        0.0,
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
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                context,
                                                              ).unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  MediaQuery.viewInsetsOf(
                                                                    context,
                                                                  ),
                                                              child:
                                                                  FilterWidget(),
                                                            ),
                                                          );
                                                        },
                                                      ).then(
                                                        (value) =>
                                                            safeSetState(() {}),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          0xFF1C1C1C,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10.0,
                                                            ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: Color(
                                                            0xFF757575,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              1.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_psht3tot,
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_3b91k8ff,
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                  ),
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                  context,
                                                                )!.k_3t9g2w44,
                                                                style: Theme.of(context).textTheme.bodyMedium!.override(
                                                                  font: GoogleFonts.openSans(
                                                                    fontWeight: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final styVenuse = AppState()
                                                        .StyleVenuse
                                                        .toList();

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(styVenuse.length, (
                                                        styVenuseIndex,
                                                      ) {
                                                        final styVenuseItem =
                                                            styVenuse[styVenuseIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                7.0,
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
                                                              AppState()
                                                                  .removeFromStyleVenuse(
                                                                    styVenuseItem,
                                                                  );
                                                              safeSetState(
                                                                () {},
                                                              );
                                                            },
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                color: Color(
                                                                  0xFF1C1C1C,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.0,
                                                                    ),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                  color: Color(
                                                                    0xFF757575,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional.fromSTEB(
                                                                      2.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            1.0,
                                                                          ),
                                                                          child: Text(
                                                                            styVenuseItem,
                                                                            style:
                                                                                Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: Theme.of(
                                                                                      context,
                                                                                    ).textTheme.bodyMedium!.fontWeight,
                                                                                    fontStyle: Theme.of(
                                                                                      context,
                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontWeight,
                                                                                  fontStyle: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsetsDirectional.fromSTEB(
                                                                            2.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Color(
                                                                          0xFFFF0000,
                                                                        ),
                                                                        size:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    final styMusic = AppState()
                                                        .StyleMusic
                                                        .toList();

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: List.generate(styMusic.length, (
                                                        styMusicIndex,
                                                      ) {
                                                        final styMusicItem =
                                                            styMusic[styMusicIndex];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.fromSTEB(
                                                                0.0,
                                                                0.0,
                                                                7.0,
                                                                0.0,
                                                              ),
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Color(
                                                                0xFF1C1C1C,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.0,
                                                                  ),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                color: Color(
                                                                  0xFF757575,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional.fromSTEB(
                                                                    2.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
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
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          0.0,
                                                                          1.0,
                                                                        ),
                                                                        child: Text(
                                                                          styMusicItem,
                                                                          style:
                                                                              Theme.of(
                                                                                context,
                                                                              ).textTheme.bodyMedium!.override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontWeight,
                                                                                  fontStyle: Theme.of(
                                                                                    context,
                                                                                  ).textTheme.bodyMedium!.fontStyle,
                                                                                ),
                                                                                color: Colors.white,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontWeight,
                                                                                fontStyle: Theme.of(
                                                                                  context,
                                                                                ).textTheme.bodyMedium!.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                          2.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                        ),
                                                                    child: InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap: () async {
                                                                        AppState().removeFromStyleMusic(
                                                                          styMusicItem,
                                                                        );
                                                                        safeSetState(
                                                                          () {},
                                                                        );
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Color(
                                                                          0xFFFF0000,
                                                                        ),
                                                                        size:
                                                                            14.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_model.selectdate && _model.mapOn)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          15.0,
                                          10.0,
                                          15.0,
                                          0.0,
                                        ),
                                        child:
                                            Container(
                                              width: double.infinity,
                                              height: 70.0,
                                              decoration: BoxDecoration(),
                                              child: Container(
                                                width: 45.0,
                                                height: 60.0,
                                                child:
                                                    custom_widgets.CalendarslideEvent(
                                                      width: 45.0,
                                                      height: 60.0,
                                                      colorPicker: Color(
                                                        0xFFFF0000,
                                                      ),
                                                      dateNow:
                                                          getCurrentTimestamp,
                                                      dateclickwidget: context
                                                          .appState
                                                          .dateclick,
                                                      onselect: () async {
                                                        safeSetState(() {});
                                                      },
                                                    ),
                                              ),
                                            ).animateOnPageLoad(
                                              animationsMap['containerOnPageLoadAnimation4']!,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            if (!_model.mapOn)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (currentUserDocument?.loginVenuesRoom !=
                                        null)
                                      Align(
                                        alignment: AlignmentDirectional(
                                          1.0,
                                          1.0,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                0.0,
                                                0.0,
                                                10.0,
                                                0.0,
                                              ),
                                          child: AuthUserStreamWidget(
                                            builder: (context) {
                                              final firstVenueRoomRef =
                                                  (currentUserDocument
                                                              ?.iDROOMVenues
                                                              ?.toList() ??
                                                          [])
                                                      .firstOrNull;
                                              if (firstVenueRoomRef == null) {
                                                return SizedBox.shrink();
                                              }
                                              return StreamBuilder<
                                                UserInVenuesRecord
                                              >(
                                                stream:
                                                    UserInVenuesRecord.getDocument(
                                                      firstVenueRoomRef,
                                                    ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child: CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  final containerUserInVenuesRecord =
                                                      snapshot.data!;

                                                  return InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        SocialInVenusePage
                                                            .routeName,
                                                      );

                                                      context
                                                              .appState
                                                              .StyleVenuse =
                                                          [];
                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              90.0,
                                                            ),
                                                      ),
                                                      child: Container(
                                                        width: 70.0,
                                                        height: 70.0,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    0.0,
                                                                    0.0,
                                                                  ),
                                                              child: Container(
                                                                width: 70.0,
                                                                height: 70.0,
                                                                decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: Image.network(
                                                                      _safeEventsImageUrl(
                                                                        currentUserDocument
                                                                            ?.logoRoom,
                                                                        fallback:
                                                                            _kEventsFallbackProfileUrl,
                                                                      ),
                                                                    ).image,
                                                                  ),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                        0x34000000,
                                                                      ),
                                                                      offset:
                                                                          Offset(
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    1.05,
                                                                    -1.0,
                                                                  ),
                                                              child: Container(
                                                                width: 25.0,
                                                                height: 25.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            25.0,
                                                                        height:
                                                                            25.0,
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            if (containerUserInVenuesRecord.user
                                                                                    .where(
                                                                                      (
                                                                                        e,
                                                                                      ) => functions.checkdate(
                                                                                        (e
                                                                                                as dynamic)
                                                                                            ?.date,
                                                                                        getCurrentTimestamp,
                                                                                      )!,
                                                                                    )
                                                                                    .toList()
                                                                                    .length !=
                                                                                0)
                                                                              Align(
                                                                                alignment: AlignmentDirectional(
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Container(
                                                                                  width: 23.0,
                                                                                  height: 23.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(
                                                                                      0xFFFF0000,
                                                                                    ),
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        blurRadius: 4.0,
                                                                                        color: Color(
                                                                                          0x4C000000,
                                                                                        ),
                                                                                        offset: Offset(
                                                                                          0.0,
                                                                                          2.0,
                                                                                        ),
                                                                                        spreadRadius: 0.5,
                                                                                      ),
                                                                                    ],
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                                            0.0,
                                                                                            0.0,
                                                                                            0.0,
                                                                                            1.0,
                                                                                          ),
                                                                                          child: Text(
                                                                                            containerUserInVenuesRecord.user
                                                                                                .where(
                                                                                                  (
                                                                                                    e,
                                                                                                  ) => functions.checkdate(
                                                                                                    (e
                                                                                                            as dynamic)
                                                                                                        ?.date,
                                                                                                    getCurrentTimestamp,
                                                                                                  )!,
                                                                                                )
                                                                                                .toList()
                                                                                                .length
                                                                                                .toString(),
                                                                                            style:
                                                                                                Theme.of(
                                                                                                  context,
                                                                                                ).textTheme.bodyMedium!.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontStyle: Theme.of(
                                                                                                      context,
                                                                                                    ).textTheme.bodyMedium!.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: 11.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.bold,
                                                                                                  fontStyle: Theme.of(
                                                                                                    context,
                                                                                                  ).textTheme.bodyMedium!.fontStyle,
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
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                    1.05,
                                                                    1.0,
                                                                  ),
                                                              child: Container(
                                                                width: 25.0,
                                                                height: 25.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                child: Stack(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                      child: Container(
                                                                        width:
                                                                            25.0,
                                                                        height:
                                                                            25.0,
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(
                                                                                0.0,
                                                                                0.0,
                                                                              ),
                                                                              child: Container(
                                                                                width: 27.0,
                                                                                height: 27.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(
                                                                                    0xFF07B53B,
                                                                                  ),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 4.0,
                                                                                      color: Color(
                                                                                        0x4C000000,
                                                                                      ),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        2.0,
                                                                                      ),
                                                                                      spreadRadius: 0.0,
                                                                                    ),
                                                                                  ],
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(
                                                                                        0.0,
                                                                                        0.0,
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                                          1.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                          0.0,
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/ucvx51dhc4gx/message2.png',
                                                                                          width: 16.0,
                                                                                          height: 16.0,
                                                                                          fit: BoxFit.cover,
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ).animateOnActionTrigger(
                      animationsMap['containerOnActionTriggerAnimation']!,
                    );
                  },
                ),
                if (_model.textinput)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      110.0,
                      0.0,
                      0.0,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.textinput = false;
                        safeSetState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(color: Color(0x4E000000)),
                      ),
                    ),
                  ),
                if (_model.textinput)
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.textinput = false;
                      safeSetState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(color: Color(0x4E000000)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventsHeroSearchSheet extends StatefulWidget {
  const _EventsHeroSearchSheet({
    required this.hero,
    required this.header,
    required this.heroHeight,
    required this.safeTopInset,
    required this.children,
  });

  final Widget hero;
  final Widget header;
  final double heroHeight;
  final double safeTopInset;
  final List<Widget> children;

  @override
  State<_EventsHeroSearchSheet> createState() => _EventsHeroSearchSheetState();
}

class _EventsHeroSearchSheetState extends State<_EventsHeroSearchSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double? _lastMinExtent;
  double? _lastMaxExtent;
  bool _reportedCovered = false;
  bool _geometrySyncScheduled = false;

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  void _syncSheetGeometry(double minExtent, double maxExtent) {
    final previousMin = _lastMinExtent;
    final previousMax = _lastMaxExtent;
    if (previousMin == null || previousMax == null) {
      _lastMinExtent = minExtent;
      _lastMaxExtent = maxExtent;
      return;
    }
    if ((previousMin - minExtent).abs() < 0.001 &&
        (previousMax - maxExtent).abs() < 0.001) {
      return;
    }

    final wasClosed =
        _sheetController.isAttached &&
        (_sheetController.size - previousMin).abs() <= 0.02;
    final wasCovered =
        _sheetController.isAttached &&
        (_sheetController.size - previousMax).abs() <= 0.02;
    _lastMinExtent = minExtent;
    _lastMaxExtent = maxExtent;
    if ((!wasClosed && !wasCovered) || _geometrySyncScheduled) return;

    _geometrySyncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _geometrySyncScheduled = false;
      if (!mounted || !_sheetController.isAttached) return;
      await _sheetController.animateTo(
        wasClosed ? minExtent : maxExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _reportCoveredState(DraggableScrollableNotification notification) {
    final atMin = (notification.extent - notification.minExtent).abs() <= 0.002;
    final atMax = (notification.extent - notification.maxExtent).abs() <= 0.002;
    if (atMax && !_reportedCovered) {
      setState(() => _reportedCovered = true);
    } else if (atMin && _reportedCovered) {
      setState(() => _reportedCovered = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportHeight = constraints.maxHeight;
        if (viewportHeight <= 0.0) return const SizedBox.shrink();

        final collapsedPixels = (viewportHeight - widget.heroHeight + 10.0)
            .clamp(190.0, viewportHeight * 0.48)
            .toDouble();
        final minExtent = (collapsedPixels / viewportHeight)
            .clamp(0.20, 0.58)
            .toDouble();
        const maxExtent = 1.0;
        _syncSheetGeometry(minExtent, maxExtent);

        return Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                height: widget.heroHeight,
                child: widget.hero,
              ),
            ),
            widget.header,
            Align(
              alignment: Alignment.bottomCenter,
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  _reportCoveredState(notification);
                  return false;
                },
                child: DraggableScrollableSheet(
                  controller: _sheetController,
                  initialChildSize: minExtent,
                  minChildSize: minExtent,
                  maxChildSize: maxExtent,
                  expand: false,
                  snap: true,
                  snapAnimationDuration: const Duration(milliseconds: 360),
                  shouldCloseOnMinExtent: false,
                  builder: (context, scrollController) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOutCubic,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(_reportedCovered ? 0.0 : 30.0),
                        ),
                      ),
                      child: AnimatedPadding(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsetsDirectional.only(
                          top:
                              15.0 +
                              (_reportedCovered ? widget.safeTopInset : 0.0),
                        ),
                        child: CustomScrollView(
                          controller: scrollController,
                          physics: const ClampingScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate.fixed(
                                widget.children,
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 130.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EventsDesignCanvas extends StatelessWidget {
  const _EventsDesignCanvas({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390.0),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}

class _EventsTopHeader extends StatelessWidget {
  const _EventsTopHeader({
    required this.topInset,
    required this.featuredCount,
    required this.featuredIndex,
    required this.collapsed,
    required this.onLocationPressed,
    required this.onNotificationPressed,
    required this.onProfilePressed,
  });

  final double topInset;
  final int featuredCount;
  final int featuredIndex;
  final bool collapsed;
  final VoidCallback onLocationPressed;
  final VoidCallback onNotificationPressed;
  final VoidCallback onProfilePressed;

  @override
  Widget build(BuildContext context) {
    final visibleCount = featuredCount.clamp(0, 5);
    final visibleIndex = visibleCount == 0
        ? 0
        : featuredIndex.clamp(0, visibleCount - 1);

    return SizedBox(
      width: double.infinity,
      height: topInset + 70.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: collapsed ? Colors.black : Colors.transparent,
                  gradient: collapsed
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xB3000000), Color(0x00000000)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            top: topInset + 8.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(18.5),
              onTap: onLocationPressed,
              child: GlassContainer(
                width: 103.0,
                height: 41.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  11.0,
                  0.0,
                  9.0,
                  0.0,
                ),
                useOwnLayer: true,
                quality: GlassQuality.premium,
                settings: _kEventsHeaderGlassSettings,
                shape: const LiquidRoundedSuperellipse(borderRadius: 20.5),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Colors.white,
                      size: 19.0,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: _EventsScriptText(
                        'BNK',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0x99FFFFFF),
                      size: 17.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (visibleCount > 1)
            Positioned(
              top: topInset + 28.0,
              left: 145.0,
              right: 145.0,
              child: _FeaturedPageIndicator(
                count: visibleCount,
                currentIndex: visibleIndex,
              ),
            ),
          Positioned(
            right: 14.0,
            top: topInset + 8.0,
            child: Row(
              children: [
                GlassButtonGroup(
                  useOwnLayer: true,
                  quality: GlassQuality.premium,
                  settings: _kEventsHeaderGlassSettings,
                  borderRadius: 23.5,
                  showDividers: false,
                  children: [
                    SizedBox(
                      width: _kEventsProfileButtonSize,
                      height: _kEventsProfileButtonSize,
                      child: AuthUserStreamWidget(
                        builder: (context) => NotificationBadgeButton(
                          onTap: onNotificationPressed,
                          backgroundColor: Colors.transparent,
                          iconSize: 21.0,
                          badgeSize: 18.0,
                          showBadgeBorder: false,
                          badgeTop: 3.0,
                          badgeRight: 3.0,
                          abbreviateBadgeCount: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _kEventsProfileButtonSize,
                      height: _kEventsProfileButtonSize,
                      child: Center(
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onProfilePressed,
                          child: SizedBox(
                            width: _kEventsProfileButtonSize,
                            height: _kEventsProfileButtonSize,
                            child: Center(
                              child: SizedBox(
                                width: _kEventsProfileButtonSize - 8.0,
                                height: _kEventsProfileButtonSize - 8.0,
                                child: ClipOval(
                                  child: Image.network(
                                    _safeEventsImageUrl(
                                      currentUserPhoto,
                                      fallback: _kEventsFallbackProfileUrl,
                                    ),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const ColoredBox(
                                              color: Color(0xFF25252A),
                                              child: Icon(
                                                Icons.person_rounded,
                                                color: Colors.white70,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}

class _EventsTopEventsCarousel extends StatefulWidget {
  const _EventsTopEventsCarousel({
    required this.events,
    required this.onEventPressed,
  });

  final List<DataEventsStruct> events;
  final ValueChanged<DataEventsStruct> onEventPressed;

  @override
  State<_EventsTopEventsCarousel> createState() =>
      _EventsTopEventsCarouselState();
}

class _EventsTopEventsCarouselState extends State<_EventsTopEventsCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.94);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) return const SizedBox.shrink();

    final rankedEvents = [...widget.events]
      ..sort((a, b) {
        final popularity = b.capacity.compareTo(a.capacity);
        if (popularity != 0) return popularity;
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return a.date!.compareTo(b.date!);
      });
    final pageCount = (rankedEvents.length / 3).ceil();

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 28.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _EventsScriptText(
                  'Top events',
                  color: Colors.white,
                  fontSize: 38.0,
                  fontWeight: FontWeight.w400,
                  displayEnglish: true,
                  height: 1.0,
                  letterSpacing: -0.2,
                ),
                const _EventsScriptText(
                  'ปัดดู  →',
                  color: Color(0xFFB7B7BE),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 348.0,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: PageView.builder(
                controller: _pageController,
                padEnds: false,
                itemCount: pageCount,
                itemBuilder: (context, pageIndex) {
                  final start = pageIndex * 3;
                  final end = (start + 3).clamp(0, rankedEvents.length);
                  final pageEvents = rankedEvents.sublist(start, end);
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
                    child: Column(
                      children: [
                        for (
                          var index = 0;
                          index < pageEvents.length;
                          index++
                        ) ...[
                          SizedBox(
                            height: 112.0,
                            child: _TopEventRow(
                              event: pageEvents[index],
                              onTap: () =>
                                  widget.onEventPressed(pageEvents[index]),
                            ),
                          ),
                          if (index < pageEvents.length - 1)
                            const SizedBox(height: 6.0),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopEventRow extends StatelessWidget {
  const _TopEventRow({required this.event, required this.onTap});

  final DataEventsStruct event;
  final VoidCallback onTap;

  String get _title {
    final artists = event.nameArtise
        .where((artist) => artist.trim().isNotEmpty)
        .join(' × ');
    return artists.isNotEmpty ? artists : event.nameStore;
  }

  String get _price {
    if (event.free) return 'FREE';
    final price = event.priceDetail.trim();
    if (price.isEmpty) return 'ดูราคา';
    return RegExp(r'[^0-9.,\s]').hasMatch(price) ? price : '$price ฿';
  }

  String get _dateLabel => event.date == null
      ? 'เร็ว ๆ นี้'
      : dateTimeFormat('EEE d MMM', event.date!);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              _safeEventsImageUrl(
                event.poster,
                fallback: _kEventsFallbackPosterUrl,
              ),
              width: 92.0,
              height: 92.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Color(0xFF161616),
                child: SizedBox(
                  width: 92.0,
                  height: 92.0,
                  child: Icon(Icons.event_rounded, color: Colors.white38),
                ),
              ),
            ),
          ),
          const SizedBox(width: 13.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EventsScriptText(
                  _title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  height: 1.16,
                ),
                const SizedBox(height: 5.0),
                _EventsScriptText(
                  _price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: const Color(0xFFF0F0F2),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 3.0),
                _EventsScriptText(
                  _dateLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: const Color(0xFFA1A1A1),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                ),
                if (event.nameStore.trim().isNotEmpty) ...[
                  const SizedBox(height: 3.0),
                  _EventsScriptText(
                    event.nameStore,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: _kEventsVenueRed,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 13.0),
              child: Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFB9B9C2),
                size: 27.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventsCategoryBrowser extends StatelessWidget {
  const _EventsCategoryBrowser({
    required this.categories,
    required this.selectedCategories,
    required this.onCategoryPressed,
  });

  final List<String> categories;
  final List<String> selectedCategories;
  final ValueChanged<String> onCategoryPressed;

  static const _colors = <Color>[
    Color(0xFFF5C542),
    Color(0xFFE86FB0),
    Color(0xFFA9B665),
    Color(0xFFE8933A),
    Color(0xFF56C2B0),
    Color(0xFFE65A5A),
    Color(0xFF8B7CF6),
    Color(0xFF45A3FF),
    Color(0xFFFF6B9A),
    Color(0xFFB7E35A),
  ];

  static const _icons = <IconData>[
    Icons.music_note_rounded,
    Icons.graphic_eq_rounded,
    Icons.palette_outlined,
    Icons.local_cafe_outlined,
    Icons.spa_outlined,
    Icons.theater_comedy_outlined,
    Icons.nightlife_rounded,
    Icons.local_bar_rounded,
    Icons.roofing_rounded,
    Icons.pool_rounded,
    Icons.album_rounded,
    Icons.surround_sound_rounded,
    Icons.celebration_rounded,
    Icons.groups_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    final topRow = <Widget>[];
    final bottomRow = <Widget>[];
    for (var index = 0; index < categories.length; index++) {
      final category = categories[index];
      final chip = Padding(
        padding: const EdgeInsetsDirectional.only(end: 10.0),
        child: _EventCategoryChip(
          label: category,
          color: _colors[index % _colors.length],
          icon: _icons[index % _icons.length],
          selected: selectedCategories.contains(category),
          onTap: () => onCategoryPressed(category),
        ),
      );
      (index.isEven ? topRow : bottomRow).add(chip);
    }

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 20.0, bottom: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
            child: _EventsScriptText(
              'เรียกดูตามหมวดหมู่',
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: topRow),
                if (bottomRow.isNotEmpty) ...[
                  const SizedBox(height: 10.0),
                  Row(children: bottomRow),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCategoryChip extends StatelessWidget {
  const _EventCategoryChip({
    required this.label,
    required this.color,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 36.0,
        padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 13.0, 0.0),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.18) : Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: selected ? color : const Color(0x1AFFFFFF)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Icon(icon, color: color, size: 17.0),
            ),
            const SizedBox(width: 7.0),
            _EventsScriptText(
              label,
              maxLines: 1,
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

class _EventsGroupedByDay extends StatelessWidget {
  const _EventsGroupedByDay({
    required this.events,
    required this.onEventPressed,
  });

  final List<DataEventsStruct> events;
  final ValueChanged<DataEventsStruct> onEventPressed;

  static const _thaiMonths = <String>[
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];

  static const _thaiWeekdays = <String>[
    'วันจันทร์',
    'วันอังคาร',
    'วันพุธ',
    'วันพฤหัสบดี',
    'วันศุกร์',
    'วันเสาร์',
    'วันอาทิตย์',
  ];

  DateTime? _dayOf(DateTime? date) {
    if (date == null) return null;
    return DateTime(date.year, date.month, date.day);
  }

  String _dayLabel(DateTime? day) {
    if (day == null) return 'เร็ว ๆ นี้';
    return '${day.day} ${_thaiMonths[day.month - 1]}';
  }

  String _weekdayLabel(DateTime day) => _thaiWeekdays[day.weekday - 1];

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 44.0, 20.0, 140.0),
        child: Center(
          child: _EventsScriptText(
            'ไม่พบ Event ที่ตรงกับการค้นหา',
            textAlign: TextAlign.center,
            color: const Color(0xFF8D8D8D),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final sortedEvents = [...events]
      ..sort((a, b) {
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return a.date!.compareTo(b.date!);
      });
    final groupedEvents = <DateTime?, List<DataEventsStruct>>{};
    for (final event in sortedEvents) {
      groupedEvents.putIfAbsent(_dayOf(event.date), () => []).add(event);
    }

    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 120.0),
      child: Column(
        children: groupedEvents.entries.map((entry) {
          final day = entry.key;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  20.0,
                  28.0,
                  20.0,
                  12.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    _EventsScriptText(
                      _dayLabel(day),
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                      displayEnglish: true,
                    ),
                    if (day != null) ...[
                      const SizedBox(width: 8.0),
                      _EventsScriptText(
                        '/ ${_weekdayLabel(day)}',
                        color: const Color(0xFF7D7D7D),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: entry.value
                      .map(
                        (event) => _GroupedEventRow(
                          event: event,
                          onTap: () => onEventPressed(event),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _GroupedEventRow extends StatelessWidget {
  const _GroupedEventRow({required this.event, required this.onTap});

  final DataEventsStruct event;
  final VoidCallback onTap;

  String get _title {
    final artists = event.nameArtise
        .where((artist) => artist.trim().isNotEmpty)
        .join(' × ');
    return artists.isNotEmpty ? artists : event.nameStore;
  }

  String get _likes {
    final count = event.capacity;
    if (count >= 1000) {
      final compact = count / 1000;
      return '${compact.toStringAsFixed(compact >= 10 ? 0 : 1)}K';
    }
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    final locationLabel = event.hasDistance()
        ? '${event.distance.toStringAsFixed(1)} km'
        : event.nameStore;
    final timeLabel = event.date == null
        ? 'ยังไม่ระบุเวลา'
        : '${dateTimeFormat('Hm', event.date!)} น.';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                _safeEventsImageUrl(
                  event.poster,
                  fallback: _kEventsFallbackPosterUrl,
                ),
                width: 96.0,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const ColoredBox(
                    color: Color(0xFF161616),
                    child: SizedBox(width: 96.0, height: 126.0),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: Color(0xFF161616),
                  child: SizedBox(
                    width: 96.0,
                    height: 126.0,
                    child: Icon(Icons.event_rounded, color: Colors.white38),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFFB9B9C2),
                      size: 27.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _EventsScriptText(
                    _title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 19.0,
                    height: 1.25,
                    fontWeight: FontWeight.w900,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Flexible(
                        child: _EventsScriptText(
                          event.nameStore,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: _kEventsVenueRed,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (event.hasCapacity()) ...[
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.favorite_border_rounded,
                          color: Color(0xFFA1A1A1),
                          size: 13.0,
                        ),
                        const SizedBox(width: 4.0),
                        _EventsScriptText(
                          _likes,
                          color: const Color(0xFFA1A1A1),
                          fontSize: 12.5,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFA1A1A1),
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: _EventsScriptText(
                          locationLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: const Color(0xFFA1A1A1),
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      const Icon(
                        Icons.schedule_rounded,
                        color: Color(0xFFA1A1A1),
                        size: 14.0,
                      ),
                      const SizedBox(width: 6.0),
                      _EventsScriptText(
                        timeLabel,
                        color: const Color(0xFFA1A1A1),
                        fontSize: 13.0,
                      ),
                    ],
                  ),
                  if (event.musicstyle.trim().isNotEmpty) ...[
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        11.0,
                        5.0,
                        11.0,
                        5.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(color: const Color(0x1AFFFFFF)),
                      ),
                      child: _EventsScriptText(
                        event.musicstyle,
                        color: const Color(0xFFDDDDDD),
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventsSearchControls extends StatelessWidget {
  const _EventsSearchControls({
    required this.controller,
    required this.focusNode,
    required this.favoriteSelected,
    required this.dateSelected,
    required this.distance,
    required this.onSearchChanged,
    required this.onFilterPressed,
    required this.onFavoritePressed,
    required this.onMapPressed,
    required this.onDatePressed,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool favoriteSelected;
  final bool dateSelected;
  final double distance;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterPressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onMapPressed;
  final VoidCallback onDatePressed;

  @override
  Widget build(BuildContext context) {
    final searchHint = AppLocalizations.of(context)!.k_k93w5ytl;
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: const Color(0x981D1D1D),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            15.0,
                            0.0,
                            15.0,
                            2.0,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(
                              context,
                            ).extension<CustomColors>()!.primaryBtnText,
                            size: 22.0,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(0.5, 0.8),
                            child: TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              onChanged: (value) => EasyDebounce.debounce(
                                '_model.textController',
                                const Duration(milliseconds: 500),
                                () => onSearchChanged(value),
                              ),
                              onFieldSubmitted: (_) => focusNode.unfocus(),
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                isDense: false,
                                border: InputBorder.none,
                                hintText: searchHint,
                                hintStyle: _eventsBodyTextStyle(
                                  color: const Color(0xFF9D9D9D),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                suffixIcon: controller.text.isNotEmpty
                                    ? InkWell(
                                        onTap: () {
                                          controller.clear();
                                          onSearchChanged('');
                                        },
                                        child: const Icon(
                                          Icons.clear,
                                          color: Color(0xFF757575),
                                          size: 22.0,
                                        ),
                                      )
                                    : null,
                              ),
                              style: _eventsBodyTextStyle(
                                color: const Color(0xFFBDBDBD),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                          child: VerticalDivider(thickness: 1.0),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            4.0,
                            0.0,
                            12.0,
                            0.0,
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: onFilterPressed,
                            child: Image.network(
                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/munday-f3fumu/assets/4mhd403jg5z2/fillter.png',
                              width: 30.0,
                              height: 28.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: onFavoritePressed,
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: const Color(0x981D1D1D),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(2.0, 2.0),
                                  spreadRadius: 3.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: favoriteSelected
                                  ? _kEventsPrimaryRed
                                  : Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: onMapPressed,
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: const Color(0x981D1D1D),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color(0x981D1D1D),
                        width: 2.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/7089161_google_maps_icon.png',
                      width: 32.0,
                      height: 32.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 10.0),
            child: SizedBox(
              width: double.infinity,
              height: 20.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _SearchFilterChip(
                      label: 'Date',
                      selected: dateSelected,
                      trailing: Icons.keyboard_arrow_down_rounded,
                      onTap: onDatePressed,
                    ),
                    const SizedBox(width: 7.0),
                    _SearchFilterChip(
                      label: '${distance.toStringAsFixed(1)} km',
                      onTap: onFilterPressed,
                    ),
                    const SizedBox(width: 7.0),
                    _SearchFilterChip(
                      label: 'FREE - 2000฿',
                      onTap: onFilterPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchFilterChip extends StatelessWidget {
  const _SearchFilterChip({
    required this.label,
    required this.onTap,
    this.trailing,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? trailing;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 20.0,
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 1.0),
        decoration: BoxDecoration(
          color: selected ? _kEventsPrimaryRed : const Color(0xFF161616),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: selected ? _kEventsPrimaryRed : const Color(0xFF757575),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: _eventsBodyTextStyle(color: Colors.white, fontSize: 12.0),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 4.0),
              Icon(trailing, color: Colors.white, size: 14.0),
            ],
          ],
        ),
      ),
    );
  }
}

class _FeaturedEventsHero extends StatefulWidget {
  const _FeaturedEventsHero({
    required this.events,
    required this.topInset,
    required this.onPageChanged,
    required this.onEventTap,
  });

  final List<EventsRecord> events;
  final double topInset;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<EventsRecord> onEventTap;

  @override
  State<_FeaturedEventsHero> createState() => _FeaturedEventsHeroState();
}

class _FeaturedEventsHeroState extends State<_FeaturedEventsHero> {
  late final PageController _pageController;
  int _currentIndex = 0;
  bool _muted = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(covariant _FeaturedEventsHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_currentIndex >= widget.events.length && widget.events.isNotEmpty) {
      _currentIndex = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) _pageController.jumpToPage(0);
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) return const SizedBox.shrink();

    final safeIndex = _currentIndex.clamp(0, widget.events.length - 1);
    final screenSize = MediaQuery.sizeOf(context);
    final heroHeight = _eventsFeaturedHeroHeight(
      screenSize: screenSize,
      topInset: widget.topInset,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      height: heroHeight,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.events.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _muted = true;
              });
              widget.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              final event = widget.events[index];
              final videoPath = _featuredVideoPath(event, mockIndex: index);
              if (videoPath != null) {
                return _buildVideoHero(
                  context,
                  event,
                  videoPath,
                  index == safeIndex,
                );
              }
              return _buildImageHero(context, event);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideoHero(
    BuildContext context,
    EventsRecord event,
    String videoPath,
    bool active,
  ) {
    final size = MediaQuery.sizeOf(context);
    final height = _eventsFeaturedHeroHeight(
      screenSize: size,
      topInset: widget.topInset,
    );
    final posterUrl = _isVideoMediaPath(event.poster)
        ? _kEventsFallbackPosterUrl
        : _safeEventsImageUrl(
            event.poster,
            fallback: _kEventsFallbackPosterUrl,
          );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onEventTap(event),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: const Color(0xFF111217)),
          ),
          MundayVideoPlayer(
            key: ValueKey('$videoPath-$active'),
            path: videoPath,
            videoType: videoPath.startsWith('assets/')
                ? VideoType.asset
                : VideoType.network,
            width: size.width,
            height: height,
            aspectRatio: size.width / height,
            autoPlay: active,
            looping: true,
            showControls: false,
            allowFullScreen: false,
            volume: active && !_muted ? 1.0 : 0.0,
          ),
          const Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            height: 150.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x00000000), Color(0xFF000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 18.0,
            child: _FeaturedEventInfoCard(event: event),
          ),
          Positioned(
            left: 14.0,
            top:
                widget.topInset -
                _kEventsHeaderHeight +
                8.0 +
                _kEventsProfileButtonSize +
                8.0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _muted = !_muted),
              child: Container(
                width: _kEventsProfileButtonSize,
                height: _kEventsProfileButtonSize,
                alignment: Alignment.center,
                child: Icon(
                  _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 26.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageHero(BuildContext context, EventsRecord event) {
    final posterUrl = _safeEventsImageUrl(
      event.poster,
      fallback: _kEventsFallbackPosterUrl,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRect(
          child: ImageFiltered(
            imageFilter: ui.ImageFilter.blur(sigmaX: 28.0, sigmaY: 28.0),
            child: Transform.scale(
              scale: 1.18,
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                errorBuilder: (context, error, stackTrace) =>
                    const ColoredBox(color: Colors.black),
              ),
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xE6000000), Color(0xA6000000), Color(0xF2000000)],
              stops: [0.0, 0.48, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                16.0,
                0.0,
                16.0,
                12.0,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onEventTap(event),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: widget.topInset + 12.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              posterUrl,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const ColoredBox(
                                  color: Color(0xFF17181E),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const ColoredBox(
                                    color: Color(0xFF17181E),
                                    child: Center(
                                      child: Icon(
                                        Icons.event_rounded,
                                        color: Colors.white70,
                                        size: 52.0,
                                      ),
                                    ),
                                  ),
                            ),
                            const Positioned(
                              left: 14.0,
                              bottom: 14.0,
                              child: _FeaturedLabel(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    _FeaturedEventInfoCard(event: event),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturedPageIndicator extends StatelessWidget {
  const _FeaturedPageIndicator({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final selected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: selected ? 16.0 : 7.0,
          height: 7.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            color: selected ? _kEventsPrimaryRed : Colors.white,
            borderRadius: BorderRadius.circular(99.0),
          ),
        );
      }),
    );
  }
}

class _FeaturedLabel extends StatelessWidget {
  const _FeaturedLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xB3000000),
        borderRadius: BorderRadius.circular(99.0),
        border: Border.all(color: const Color(0x33FFFFFF)),
      ),
      child: _EventsScriptText(
        'FEATURED',
        color: Colors.white,
        fontSize: 10.0,
        fontWeight: FontWeight.w800,
        displayEnglish: true,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _FeaturedEventInfoCard extends StatelessWidget {
  const _FeaturedEventInfoCard({required this.event});

  final EventsRecord event;

  String _venueName(VenuesRecord? venue) {
    final venueName = venue?.nameVenuse.trim() ?? '';
    if (venueName.isNotEmpty) return venueName;
    if (event.nameStore.trim().isNotEmpty) return event.nameStore.trim();
    return 'สถานที่จัดงาน';
  }

  String get _eventName {
    final artists = event.nameArtise
        .where((artist) => artist.trim().isNotEmpty)
        .join(' • ');
    if (artists.isNotEmpty) return artists;
    return 'Featured event';
  }

  String _venueImageUrl(VenuesRecord? venue) {
    final logo = venue?.logo.trim() ?? '';
    if (logo.isNotEmpty) return logo;
    final background = venue?.bg.trim() ?? '';
    return background;
  }

  String get _eventDay =>
      event.date == null ? '--' : dateTimeFormat('d', event.date!);

  String get _eventMonth => event.date == null
      ? 'เร็ว ๆ นี้'
      : dateTimeFormat('MMM', event.date!).toUpperCase();

  @override
  Widget build(BuildContext context) {
    final venueRef = event.iDVenues;
    if (venueRef == null) return _buildCard(context, null);

    return StreamBuilder<VenuesRecord>(
      stream: VenuesRecord.getDocument(venueRef),
      builder: (context, snapshot) => _buildCard(context, snapshot.data),
    );
  }

  Widget _buildCard(BuildContext context, VenuesRecord? venue) {
    final venueImageUrl = _venueImageUrl(venue);
    return Container(
      constraints: const BoxConstraints(minHeight: 76.0),
      child: Row(
        children: [
          SizedBox(
            width: 54.0,
            height: 54.0,
            child: ClipOval(
              child: venueImageUrl.isEmpty
                  ? const ColoredBox(
                      color: Color(0xFF202027),
                      child: Icon(
                        Icons.storefront_rounded,
                        color: Colors.white70,
                        size: 25.0,
                      ),
                    )
                  : Image.network(
                      _safeEventsImageUrl(
                        venueImageUrl,
                        fallback: _kEventsFallbackProfileUrl,
                      ),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(
                            color: Color(0xFF202027),
                            child: Icon(
                              Icons.storefront_rounded,
                              color: Colors.white70,
                              size: 25.0,
                            ),
                          ),
                    ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EventsScriptText(
                  _eventName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 18.5,
                  fontWeight: FontWeight.w900,
                  height: 1.22,
                ),
                const SizedBox(height: 4.0),
                _EventsScriptText(
                  _venueName(venue),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: const Color(0xFFA1A1A1),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            width: 54.0,
            height: 54.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kEventsPrimaryRed,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EventsScriptText(
                  _eventDay,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  displayEnglish: true,
                  height: 0.95,
                ),
                const SizedBox(height: 2.0),
                _EventsScriptText(
                  _eventMonth,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: event.date == null ? 9.0 : 14.0,
                  fontWeight: FontWeight.w500,
                  displayEnglish: true,
                  letterSpacing: 0.5,
                  height: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventDetailData {
  const _EventDetailData({
    required this.eventData,
    this.eventRecord,
    this.venueRecord,
  });

  final DataEventsStruct eventData;
  final EventsRecord? eventRecord;
  final VenuesRecord? venueRecord;

  SupabaseDocRef? get venueRef => eventData.iDVenuse ?? eventRecord?.iDVenues;

  String? get distanceValue =>
      eventData.hasDistance() ? eventData.distance.toString() : null;

  String get distanceLabel {
    if (!eventData.hasDistance()) {
      return 'ไม่ระบุ';
    }
    return '${eventData.distance.toStringAsFixed(1)} กม.';
  }

  DateTime? get eventDate => eventRecord?.date ?? eventData.date;

  String get eventDateLabel {
    final date = eventDate;
    if (date == null) {
      return 'ยังไม่ระบุวันเวลา';
    }

    final day = functions.dateEventday(date)?.toString() ?? '';
    final month = functions.dateMonthTH(date) ?? '';
    final time = dateTimeFormat('Hm', date);
    return '$day $month • $time';
  }

  List<String> get artists {
    final recordArtists = eventRecord?.nameArtise ?? const <String>[];
    final source = recordArtists.isNotEmpty
        ? recordArtists
        : eventData.nameArtise;
    return source.where((name) => name.trim().isNotEmpty).toList();
  }

  String get eventTitle {
    if (artists.isNotEmpty) {
      return artists.join(', ');
    }
    return venueName;
  }

  String get venueName {
    final venueName = venueRecord?.nameVenuse.trim();
    if (venueName != null && venueName.isNotEmpty) {
      return venueName;
    }

    final eventStore = eventRecord?.nameStore.trim();
    if (eventStore != null && eventStore.isNotEmpty) {
      return eventStore;
    }

    final dataStore = eventData.nameStore.trim();
    if (dataStore.isNotEmpty) {
      return dataStore;
    }

    return 'ร้านของ event นี้';
  }

  String get venueImageUrl {
    final logo = venueRecord?.logo.trim();
    if (logo != null && logo.isNotEmpty) {
      return _safeEventsImageUrl(logo, fallback: _kEventsFallbackProfileUrl);
    }

    final bg = venueRecord?.bg.trim();
    if (bg != null && bg.isNotEmpty) {
      return _safeEventsImageUrl(bg, fallback: _kEventsFallbackProfileUrl);
    }

    return _kEventsFallbackProfileUrl;
  }

  String get posterUrl {
    final poster = eventRecord?.poster.trim();
    if (poster != null && poster.isNotEmpty) {
      return _safeEventsImageUrl(poster, fallback: _kEventsFallbackPosterUrl);
    }

    return _safeEventsImageUrl(
      eventData.poster,
      fallback: _kEventsFallbackPosterUrl,
    );
  }

  bool get isFree =>
      eventRecord?.free ?? (eventData.hasFree() ? eventData.free : false);

  String get priceLabel {
    if (isFree) {
      return 'ฟรี';
    }

    final recordPrice = eventRecord?.priceDetail.trim();
    if (recordPrice != null && recordPrice.isNotEmpty) {
      return recordPrice;
    }

    final dataPrice = eventData.priceDetail.trim();
    if (dataPrice.isNotEmpty) {
      return dataPrice;
    }

    return 'ราคาไม่ระบุ';
  }

  String get priceSummaryLabel {
    if (isFree) {
      return 'ฟรี';
    }

    if (priceLabel == 'ราคาไม่ระบุ') {
      return priceLabel;
    }

    final normalized = priceLabel.toLowerCase();
    if (normalized.startsWith('from') || priceLabel.startsWith('เริ่ม')) {
      return priceLabel;
    }

    return 'From $priceLabel';
  }

  String get bookingButtonLabel {
    if (isFree) {
      return 'จองฟรี';
    }

    if (priceLabel == 'ราคาไม่ระบุ') {
      return 'ดูตัวเลือก';
    }

    return 'จองจาก $priceLabel';
  }

  String get availabilityLabel {
    if (isFree) {
      return 'Free entry available';
    }

    if (tableCount != null) {
      return 'Best tables available';
    }

    return 'ตรวจสอบที่นั่งว่าง';
  }

  int? get currentCapacity {
    if (eventRecord?.hasCapacity() ?? false) {
      return eventRecord!.capacity;
    }
    return eventData.hasCapacity() ? eventData.capacity : null;
  }

  int? get maxCapacity {
    if (eventRecord?.hasMaxCapacity() ?? false) {
      return eventRecord!.maxCapacity;
    }
    return eventData.hasMaxCapacity() ? eventData.maxCapacity : null;
  }

  String get capacityLabel {
    final current = currentCapacity;
    final max = maxCapacity;
    if (current != null && max != null && max > 0) {
      return '$current/$max คน';
    }
    if (max != null && max > 0) {
      return 'สูงสุด $max คน';
    }
    if (current != null) {
      return '$current คน';
    }
    return 'ไม่ระบุ';
  }

  int? get tableCount {
    final count = venueRecord?.tableId.length ?? 0;
    return count > 0 ? count : null;
  }

  String get tableCountLabel {
    final count = tableCount;
    if (count == null) {
      return 'ยังไม่ระบุ';
    }
    return '$count โต๊ะ';
  }

  String get musicStyle {
    final recordStyle = eventRecord?.musicstyle.trim();
    if (recordStyle != null && recordStyle.isNotEmpty) {
      return recordStyle;
    }

    final dataStyle = eventData.musicstyle.trim();
    if (dataStyle.isNotEmpty) {
      return dataStyle;
    }

    final venueStyles = venueRecord?.styleMusic ?? const <String>[];
    return venueStyles.isNotEmpty ? venueStyles.join(', ') : 'ไม่ระบุ';
  }

  String get detailText {
    final detail = eventRecord?.detail.trim();
    if (detail != null && detail.isNotEmpty) {
      return detail;
    }
    return 'ยังไม่มีรายละเอียดเพิ่มเติมสำหรับ event นี้';
  }

  String get openCloseTime {
    final value = venueRecord?.openCloseTime.trim();
    return value != null && value.isNotEmpty ? value : 'ยังไม่ระบุเวลาเปิด';
  }

  String get ratingLabel {
    final rating = venueRecord?.rating ?? 0.0;
    return rating > 0 ? rating.toStringAsFixed(1) : 'ยังไม่มีคะแนน';
  }

  String get doorsOpenLabel {
    if (openCloseTime != 'ยังไม่ระบุเวลาเปิด') {
      return openCloseTime;
    }

    return 'Based on venue schedule';
  }

  String get showStartsLabel {
    final date = eventDate;
    if (date == null) {
      return 'Based on selection';
    }

    return dateTimeFormat('Hm', date);
  }

  List<String> get detailParagraphs {
    final paragraphs = detailText
        .split(RegExp(r'\n\s*\n|\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return paragraphs.isNotEmpty ? paragraphs : [detailText];
  }

  List<String> get highlights {
    final items = <String>[];

    if (artists.isNotEmpty) {
      items.add('การแสดงโดย ${artists.join(', ')}');
    }
    if (musicStyle != 'ไม่ระบุ') {
      items.add('แนวเพลง $musicStyle');
    }
    if (tableCount != null) {
      items.add('มีโต๊ะสำหรับ event นี้ $tableCountLabel');
    }
    final max = maxCapacity;
    if (max != null && max > 0) {
      items.add('รองรับผู้ร่วมงานสูงสุด $maxCapacityLabel');
    }
    if (venueName != 'ร้านของ event นี้') {
      items.add('จัดที่ $venueName');
    }

    return items;
  }

  String get maxCapacityLabel {
    final max = maxCapacity;
    if (max == null || max <= 0) {
      return 'ไม่ระบุ';
    }
    return '$max คน';
  }

  List<String> get importantItems {
    return [
      'จำนวนโต๊ะ ราคา และที่นั่งว่างอาจเปลี่ยนตามวันที่เลือก',
      'เงื่อนไขการเข้า event และ dress code ขึ้นกับร้าน',
      isFree
          ? 'สิทธิ์ฟรีอาจมีจำนวนจำกัดหรือมีเงื่อนไขเพิ่มเติม'
          : 'ราคาเริ่มต้นอาจยังไม่รวมเงื่อนไขอื่นของร้าน',
    ];
  }

  List<String> get tags {
    final values = <String>[
      musicStyle,
      ...?eventRecord?.styleVenues,
      ...?venueRecord?.styleVenuse,
    ];

    final normalized = <String>[];
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty &&
          trimmed != 'ไม่ระบุ' &&
          !normalized.contains(trimmed)) {
        normalized.add(trimmed);
      }
    }
    return normalized.take(6).toList();
  }

  List<String> get venuePhotos {
    final photos = <String>[];
    for (final url in [...?venueRecord?.photos, ...?venueRecord?.promotion]) {
      final trimmed = url.trim();
      if (trimmed.isNotEmpty && !photos.contains(trimmed)) {
        photos.add(trimmed);
      }
    }
    return photos;
  }

  LatLng? get venuePosition =>
      eventRecord?.location ?? venueRecord?.position ?? eventData.position;

  String? get googleMapsUrl {
    final position = venuePosition;
    if (position == null) {
      return null;
    }
    return 'https://www.google.com/maps/search/?api=1'
        '&query=${position.latitude},${position.longitude}';
  }

  String? get calendarUrl {
    final date = eventDate;
    if (date == null) {
      return null;
    }
    final start = DateFormat("yyyyMMdd'T'HHmmss").format(date);
    final end = DateFormat(
      "yyyyMMdd'T'HHmmss",
    ).format(date.add(const Duration(hours: 3)));
    return Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': eventTitle,
      'dates': '$start/$end',
      'details': detailText,
      'location': venueName,
    }).toString();
  }

  String get shareText =>
      '$eventTitle • $venueName\n$eventDateLabel\n$posterUrl';

  List<_EventContactLink> get contactLinks {
    if (venueRecord == null || !venueRecord!.hasLinkContact()) {
      return const [];
    }
    final contact = venueRecord!.linkContact;
    final links = <_EventContactLink>[];

    if (contact.ig.trim().isNotEmpty) {
      links.add(
        _EventContactLink(
          icon: FontAwesomeIcons.instagram,
          iconColor: const Color(0xFFE1306C),
          label: '@${contact.ig.trim()}',
          subtitle: 'Follow on Instagram',
          url: functions.addsocial(
            'instagram://user?username=',
            contact.ig.trim(),
          )!,
        ),
      );
    }
    if (contact.facebook.trim().isNotEmpty) {
      links.add(
        _EventContactLink(
          icon: Icons.facebook_rounded,
          iconColor: const Color(0xFF1877F2),
          label: contact.facebook.trim(),
          subtitle: 'Follow on Facebook',
          url: functions.addsocial('fb://profile/', contact.facebook.trim())!,
        ),
      );
    }
    if (contact.line.trim().isNotEmpty) {
      final lineUrl = functions.linkLine(contact.line.trim());
      if (lineUrl != null) {
        links.add(
          _EventContactLink(
            icon: FontAwesomeIcons.line,
            iconColor: const Color(0xFF06C755),
            label: contact.line.trim(),
            subtitle: 'ติดต่อทาง LINE',
            url: lineUrl,
          ),
        );
      }
    }
    if (contact.tiktok.trim().isNotEmpty) {
      links.add(
        _EventContactLink(
          icon: Icons.tiktok_rounded,
          iconColor: Colors.white,
          label: '@${contact.tiktok.trim()}',
          subtitle: 'Follow on TikTok',
          url: functions.addsocial(
            'snssdk1233://user/',
            contact.tiktok.trim(),
          )!,
        ),
      );
    }
    if (contact.phone.trim().isNotEmpty) {
      links.add(
        _EventContactLink(
          icon: Icons.call_rounded,
          iconColor: const Color(0xFFFF3B3B),
          label: contact.phone.trim(),
          subtitle: 'โทรติดต่อร้าน',
          url: functions.addsocial('tel:', contact.phone.trim())!,
        ),
      );
    }

    return links;
  }
}

class _EventContactLink {
  const _EventContactLink({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.url,
  });

  final dynamic icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final String url;
}

class _EventDetailSheet extends StatelessWidget {
  const _EventDetailSheet({
    required this.detailFuture,
    required this.fallbackEventData,
    required this.topSafeInset,
    required this.onViewVenue,
  });

  final Future<_EventDetailData> detailFuture;
  final DataEventsStruct fallbackEventData;
  final double topSafeInset;
  final ValueChanged<_EventDetailData> onViewVenue;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.18,
      maxChildSize: 1.0,
      shouldCloseOnMinExtent: true,
      builder: (context, scrollController) {
        return FutureBuilder<_EventDetailData>(
          future: detailFuture,
          initialData: _EventDetailData(eventData: fallbackEventData),
          builder: (context, snapshot) {
            final detailData =
                snapshot.data ?? _EventDetailData(eventData: fallbackEventData);

            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.black),
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: _EventDetailHero(
                          posterUrl: detailData.posterUrl,
                          shareText: detailData.shareText,
                          topSafeInset: topSafeInset,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _buildContent(context, detailData),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _EventBookingBar(
                      detailData: detailData,
                      onPressed: detailData.venueRef != null
                          ? () => onViewVenue(detailData)
                          : null,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, _EventDetailData detailData) {
    final tags = detailData.tags;
    final venuePhotos = detailData.venuePhotos;
    final contactLinks = detailData.contactLinks;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(18.0, 18.0, 18.0, 122.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detailData.venueName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: _kEventsVenueRed,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            detailData.eventTitle,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              height: 1.08,
              letterSpacing: 0.0,
            ),
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 14.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: tags.map((tag) => _EventTag(label: tag)).toList(),
            ),
          ],
          const SizedBox(height: 18.0),
          _EventDateTimeCard(detailData: detailData),
          const SizedBox(height: 12.0),
          _buildVenueContextCard(detailData),
          if (detailData.venueRecord?.hasRefUserInVenues() ?? false) ...[
            const SizedBox(height: 12.0),
            _EventAttendeesSection(
              userInVenuesRef: detailData.venueRecord!.refUserInVenues!,
              eventDate: detailData.eventDate,
            ),
          ],
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: _EventInfoCard(
                  label: 'ENTRY',
                  value: detailData.isFree ? 'ฟรี' : detailData.priceLabel,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _EventInfoCard(
                  label: 'แนวเพลง',
                  value: detailData.musicStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          _buildScheduleCard(detailData),
          if (!detailData.isFree) ...[
            const SizedBox(height: 18.0),
            _buildPaymentBanner(),
          ],
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                child: _EventMetricTile(
                  icon: Icons.groups_rounded,
                  label: 'ผู้เข้าร่วม',
                  value: detailData.capacityLabel,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _EventMetricTile(
                  icon: Icons.table_bar_rounded,
                  label: 'โต๊ะของ event',
                  value: detailData.tableCountLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          _EventSection(
            title: 'รายละเอียด',
            child: _buildParagraphs(detailData.detailParagraphs),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'Highlights',
            child: _buildBulletList(detailData.highlights),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'เกี่ยวกับร้าน',
            child: _buildAboutVenueCard(detailData),
          ),
          if (venuePhotos.isNotEmpty) ...[
            const SizedBox(height: 24.0),
            _EventSection(
              title: 'ภาพจากร้าน',
              child: _EventVenuePhotoStrip(photos: venuePhotos),
            ),
          ],
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'สถานที่และเวลาเปิด',
            child: _buildLocationPanel(detailData),
          ),
          const SizedBox(height: 24.0),
          _EventSection(
            title: 'สิ่งที่ควรรู้',
            child: _buildBulletList(detailData.importantItems),
          ),
          if (contactLinks.isNotEmpty) ...[
            const SizedBox(height: 24.0),
            _EventSection(
              title: 'ช่องทางติดต่อ',
              child: Column(
                children: [
                  for (var index = 0; index < contactLinks.length; index++)
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: index == contactLinks.length - 1 ? 0.0 : 10.0,
                      ),
                      child: _EventContactLinkRow(link: contactLinks[index]),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScheduleCard(_EventDetailData detailData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFFE7E8EE),
                size: 21.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Timing and schedule',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          _EventScheduleRow(
            title: 'Doors open',
            subtitle: detailData.doorsOpenLabel,
          ),
          const SizedBox(height: 16.0),
          _EventScheduleRow(
            title: 'Show starts',
            subtitle: detailData.showStartsLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.fromSTEB(14.0, 12.0, 14.0, 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3B0F0F),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded, color: Color(0xFFFF6B6B), size: 26.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'จองโต๊ะหรือบัตรล่วงหน้า',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.0,
                  ),
                ),
                Text(
                  'เลือกแพ็กเกจและตรวจสอบราคาในหน้าร้าน',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE0B8B8),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParagraphs(List<String> paragraphs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(paragraphs.length, (index) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: index == paragraphs.length - 1 ? 0.0 : 10.0,
          ),
          child: Text(
            paragraphs[index],
            style: GoogleFonts.openSans(
              color: const Color(0xFFE4E5EA),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.45,
              letterSpacing: 0.0,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            bottom: index == items.length - 1 ? 0.0 : 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4E5EA),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  items[index],
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE4E5EA),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLocationPanel(_EventDetailData detailData) {
    final mapsUrl = detailData.googleMapsUrl;
    final position = detailData.venuePosition;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.schedule_rounded,
              color: Color(0xFFB8BBC7),
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                detailData.openCloseTime,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            const Icon(
              Icons.location_on_rounded,
              color: Color(0xFFFF4B4B),
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                detailData.eventData.hasDistance()
                    ? '${detailData.venueName} • ห่าง ${detailData.distanceLabel}'
                    : detailData.venueName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: mapsUrl == null ? null : () => launchURL(mapsUrl),
            child: SizedBox(
              width: double.infinity,
              height: 180.0,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (position != null)
                    IgnorePointer(
                      child: custom_widgets.Mapshow(
                        locationVenuse: position,
                        zoomstart: 15.0,
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF121212),
                        border: Border.all(color: const Color(0x22FFFFFF)),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _EventMapPreviewPainter(),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.location_pin,
                              color: Color(0xFFFF3030),
                              size: 38.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (mapsUrl != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            6.0,
                            10.0,
                            6.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xCC000000),
                            borderRadius: BorderRadius.circular(99.0),
                          ),
                          child: Text(
                            'แตะเพื่อเปิดใน Maps',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.0,
                            ),
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
    );
  }

  Widget _buildVenueContextCard(_EventDetailData detailData) {
    final canOpenVenue = detailData.venueRef != null;

    return InkWell(
      borderRadius: BorderRadius.circular(18.0),
      onTap: canOpenVenue ? () => onViewVenue(detailData) : null,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: const Color(0x22FFFFFF)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Image.network(
                detailData.venueImageUrl,
                width: 56.0,
                height: 56.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 56.0,
                  height: 56.0,
                  color: const Color(0xFF2A2C35),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailData.venueName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '${detailData.tableCountLabel} • ${detailData.openCloseTime} • ${detailData.ratingLabel}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: const Color(0xFFB8BBC7),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
            ),
            if (canOpenVenue) ...[
              const SizedBox(width: 8.0),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFB8BBC7),
                size: 24.0,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAboutVenueCard(_EventDetailData detailData) {
    final canOpenVenue = detailData.venueRef != null;
    final bg = detailData.venueRecord?.bg.trim();
    final coverUrl = bg != null && bg.isNotEmpty
        ? _safeEventsImageUrl(bg, fallback: _kEventsFallbackProfileUrl)
        : detailData.venueImageUrl;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 140.0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  coverUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF2A2C35),
                    child: const Center(
                      child: Icon(
                        Icons.storefront_rounded,
                        color: Colors.white70,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    detailData.venueImageUrl,
                    width: 48.0,
                    height: 48.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 48.0,
                      height: 48.0,
                      color: const Color(0xFF2A2C35),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white70,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailData.venueName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${detailData.ratingLabel} • ${detailData.openCloseTime}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          color: const Color(0xFFB8BBC7),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                if (canOpenVenue) ...[
                  const SizedBox(width: 10.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () => onViewVenue(detailData),
                    child: Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0,
                        8.0,
                        12.0,
                        8.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x22FFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'ดูหน้าร้าน',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventDetailHero extends StatefulWidget {
  const _EventDetailHero({
    required this.posterUrl,
    required this.shareText,
    required this.topSafeInset,
  });

  final String posterUrl;
  final String shareText;
  final double topSafeInset;

  @override
  State<_EventDetailHero> createState() => _EventDetailHeroState();
}

class _EventDetailHeroState extends State<_EventDetailHero> {
  double? _posterAspect;
  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolvePosterAspect();
  }

  @override
  void didUpdateWidget(covariant _EventDetailHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.posterUrl != widget.posterUrl) {
      _resolvePosterAspect();
    }
  }

  void _resolvePosterAspect() {
    final listener = _imageListener;
    if (listener != null) {
      _imageStream?.removeListener(listener);
    }
    final stream = NetworkImage(
      widget.posterUrl,
    ).resolve(createLocalImageConfiguration(context));
    final newListener = ImageStreamListener((info, _) {
      if (!mounted) {
        return;
      }
      setState(() {
        _posterAspect = info.image.width / info.image.height;
      });
    }, onError: (error, stackTrace) {});
    _imageStream = stream;
    _imageListener = newListener;
    stream.addListener(newListener);
  }

  @override
  void dispose() {
    final listener = _imageListener;
    if (listener != null) {
      _imageStream?.removeListener(listener);
    }
    super.dispose();
  }

  Widget _buildBackdrop() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          widget.posterUrl,
          fit: BoxFit.cover,
          color: const Color(0xAA000000),
          colorBlendMode: BlendMode.darken,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF141414),
            child: const Center(
              child: Icon(
                Icons.event_rounded,
                color: Colors.white70,
                size: 54.0,
              ),
            ),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xD9000000), Color(0x88000000), Color(0xF0000000)],
              stops: [0.0, 0.58, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 26.0,
                    color: Color(0x99000000),
                    offset: Offset(0.0, 14.0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  widget.posterUrl,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Container(
                      color: const Color(0xFF141414),
                      child: const Center(
                        child: Icon(
                          Icons.event_rounded,
                          color: Colors.white70,
                          size: 54.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final posterTopInset = widget.topSafeInset + 58.0;
    const horizontalInset = 18.0;
    const posterBottomInset = 16.0;

    final posterWidth = screenSize.width - (horizontalInset * 2);
    final aspect = _posterAspect;
    final posterHeight = aspect == null
        ? screenSize.height * 0.42
        : posterWidth / aspect;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: double.infinity,
      height: posterTopInset + posterHeight + posterBottomInset,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackdrop(),
          Positioned.fill(
            left: horizontalInset,
            top: posterTopInset,
            right: horizontalInset,
            bottom: posterBottomInset,
            child: _buildPoster(),
          ),
          Positioned(
            top: widget.topSafeInset + 8.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                width: 44.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(99.0),
                ),
              ),
            ),
          ),
          Positioned(
            left: 14.0,
            top: widget.topSafeInset + 20.0,
            child: _EventHeroCircleButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            right: 14.0,
            top: widget.topSafeInset + 20.0,
            child: _EventHeroCircleButton(
              icon: Icons.ios_share_rounded,
              onTap: () => Share.share(widget.shareText),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventScheduleRow extends StatelessWidget {
  const _EventScheduleRow({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 4.0),
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B3B),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6.0,
                  color: const Color(0xFFFF3B3B).withValues(alpha: 0.45),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: GoogleFonts.openSans(
                  color: const Color(0xFFAEB1BD),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EventBookingBar extends StatelessWidget {
  const _EventBookingBar({required this.detailData, required this.onPressed});

  final _EventDetailData detailData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(18.0, 12.0, 18.0, 12.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x00000000), Color(0xF2000000), Color(0xFF000000)],
          stops: [0.0, 0.34, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailData.priceSummaryLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  detailData.availabilityLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFFF3B3B),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14.0),
          SizedBox(
            width: 150.0,
            height: 52.0,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                disabledBackgroundColor: const Color(0xFF555762),
                disabledForegroundColor: const Color(0xFFC7C8CE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                detailData.bookingButtonLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventMapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final waterPaint = Paint()..color = const Color(0xFFBFE7F1);
    final landPaint = Paint()..color = const Color(0xFFE9EEF0);
    final roadPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 7.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final roadAccentPaint = Paint()
      ..color = const Color(0xFFFFD86B)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(Offset.zero & size, landPaint);

    final waterPath = Path()
      ..moveTo(0, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.03,
        size.width * 0.48,
        size.height * 0.26,
      )
      ..quadraticBezierTo(
        size.width * 0.74,
        size.height * 0.58,
        size.width,
        size.height * 0.42,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    final roadOne = Path()
      ..moveTo(size.width * 0.04, size.height * 0.76)
      ..cubicTo(
        size.width * 0.26,
        size.height * 0.52,
        size.width * 0.48,
        size.height * 0.88,
        size.width * 0.96,
        size.height * 0.62,
      );
    canvas.drawPath(roadOne, roadPaint);
    canvas.drawPath(roadOne, roadAccentPaint);

    final roadTwo = Path()
      ..moveTo(size.width * 0.16, 0)
      ..lineTo(size.width * 0.32, size.height)
      ..moveTo(size.width * 0.72, 0)
      ..lineTo(size.width * 0.58, size.height);
    canvas.drawPath(roadTwo, roadPaint..strokeWidth = 4.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EventMetricTile extends StatelessWidget {
  const _EventMetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 82.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: const Color(0xFFFF4B4B), size: 22.0),
          const SizedBox(height: 9.0),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: const Color(0xFFAEB1BD),
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              height: 1.12,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventSection extends StatelessWidget {
  const _EventSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(height: 10.0),
        child,
      ],
    );
  }
}

class _EventTag extends StatelessWidget {
  const _EventTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(11.0, 7.0, 11.0, 7.0),
      decoration: BoxDecoration(
        color: const Color(0xFF201D22),
        borderRadius: BorderRadius.circular(99.0),
        border: Border.all(color: const Color(0x33FF4B4B)),
      ),
      child: Text(
        label,
        style: GoogleFonts.openSans(
          color: const Color(0xFFFFDADA),
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
        ),
      ),
    );
  }
}

class _EventHeroCircleButton extends StatelessWidget {
  const _EventHeroCircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 44.0,
      height: 44.0,
      useOwnLayer: true,
      quality: GlassQuality.premium,
      settings: _kEventsHeaderGlassSettings,
      shape: const LiquidOval(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Center(child: Icon(icon, color: Colors.white, size: 20.0)),
      ),
    );
  }
}

class _EventDateTimeCard extends StatelessWidget {
  const _EventDateTimeCard({required this.detailData});

  final _EventDetailData detailData;

  @override
  Widget build(BuildContext context) {
    final calendarUrl = detailData.calendarUrl;

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: const Color(0x1AFF4B4B),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFFFF6B6B),
              size: 21.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailData.eventDateLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  detailData.priceSummaryLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFB8BBC7),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
          if (calendarUrl != null) ...[
            const SizedBox(width: 10.0),
            InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () => launchURL(calendarUrl),
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  12.0,
                  8.0,
                  12.0,
                  8.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'ปฏิทิน',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EventInfoCard extends StatelessWidget {
  const _EventInfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: const Color(0xFF8E91A0),
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventVenuePhotoStrip extends StatelessWidget {
  const _EventVenuePhotoStrip({required this.photos});

  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Image.network(
              _safeEventsImageUrl(photos[index], fallback: ''),
              width: 112.0,
              height: 150.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 112.0,
                height: 150.0,
                color: const Color(0xFF2A2C35),
                child: const Icon(Icons.image_rounded, color: Colors.white70),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EventContactLinkRow extends StatelessWidget {
  const _EventContactLinkRow({required this.link});

  final _EventContactLink link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: () => launchURL(link.url),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 14.0, 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0x22FFFFFF)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0x14FFFFFF),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: 24.0,
                child: Center(
                  child: link.icon is FaIconData
                      ? FaIcon(
                          link.icon as FaIconData,
                          color: link.iconColor,
                          size: 19.0,
                        )
                      : Icon(
                          link.icon as IconData,
                          color: link.iconColor,
                          size: 20.0,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    link.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.0,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    link.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: const Color(0xFFB8BBC7),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.open_in_new_rounded,
              color: Color(0xFFB8BBC7),
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _EventAttendeesSection extends StatelessWidget {
  const _EventAttendeesSection({
    required this.userInVenuesRef,
    required this.eventDate,
  });

  final SupabaseDocRef userInVenuesRef;
  final DateTime? eventDate;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserInVenuesRecord>(
      stream: UserInVenuesRecord.getDocument(userInVenuesRef),
      builder: (context, snapshot) {
        final record = snapshot.data;
        if (record == null) {
          return const SizedBox.shrink();
        }

        final referenceDate = eventDate ?? getCurrentTimestamp;
        final attendees = record.user
            .where(
              (entry) =>
                  functions.checkdate(entry.date, referenceDate) ?? false,
            )
            .map((entry) => entry.user)
            .toList();
        if (attendees.isEmpty) {
          return const SizedBox.shrink();
        }

        final avatarCount = attendees.length.clamp(0, 5);
        final names = attendees
            .take(3)
            .map((user) => user.name.trim())
            .where((name) => name.isNotEmpty)
            .toList();
        final others = attendees.length - names.length;
        final namesLabel = names.isEmpty
            ? ''
            : others > 0
            ? '${names.join(', ')} และอีก $others คน'
            : names.join(', ');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'คนที่จะไปด้วย',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: const Color(0x22FFFFFF)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 36.0 + (avatarCount - 1) * 20.0,
                    height: 36.0,
                    child: Stack(
                      children: [
                        for (var index = 0; index < avatarCount; index++)
                          Positioned(
                            left: index * 20.0,
                            child: Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF2A2A2A),
                                backgroundImage: NetworkImage(
                                  _safeEventsImageUrl(
                                    attendees[index].photoprofile,
                                    fallback: _kEventsFallbackProfileUrl,
                                  ),
                                ),
                                onBackgroundImageError: (error, stackTrace) {},
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${attendees.length} คนกำลังจะไป',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.0,
                          ),
                        ),
                        if (namesLabel.isNotEmpty) ...[
                          const SizedBox(height: 3.0),
                          Text(
                            namesLabel,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              color: const Color(0xFFB8BBC7),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
