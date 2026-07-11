import 'package:provider/provider.dart';
import '/features/auth/data/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/dialogs/profilepopup_widget.dart';
import '/shared/widgets/media/showphoto_copy_widget.dart';
import '/shared/widgets/layout/nav_bar_widget.dart';
import '/shared/widgets/misc/review_widget.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:munday/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'main_model.dart';
part "components/main_header_widget.dart";
part "components/main_categories_widget.dart";
part "components/main_events_widget.dart";
part "components/main_venues_spotlight_widget.dart";

const _kMainFallbackPosterUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

const _kMainFallbackProfileUrl =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';

String _safeMainImageUrl(String? url, {required String fallback}) {
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

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  static String routeName = 'Main';
  static String routePath = 'main';

  @override
  ConsumerState<MainPage> createState() => _MainWidgetState();
}

class _MainWidgetState extends ConsumerState<MainPage>
    with TickerProviderStateMixin {
  late MainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = MainModel()..internalInit(context);

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.wlid = MediaQuery.sizeOf(context).width;
      safeSetState(() {});
      if (valueOrDefault<bool>(currentUserDocument?.popupEditProfile, false) &&
          context.appState.lockeditprofilepopup) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: const ProfilepopupWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        context.appState.lockeditprofilepopup = false;
        safeSetState(() {});
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: const ShowphotoCopyWidget(),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
    });

    getCurrentUserLocation(
      defaultLocation: const LatLng(0.0, 0.0),
      cached: true,
    ).then((loc) {
      context.appState.locationsearch = loc;
      safeSetState(() => currentUserLocationValue = loc);
    });
    getCurrentUserLocation(defaultLocation: const LatLng(0.0, 0.0)).then((loc) {
      context.appState.locationsearch = loc;
      safeSetState(() => currentUserLocationValue = loc);
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
            begin: const Offset(0.0, 0.0),
            end: const Offset(320.0, 0.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0, 0),
            end: const Offset(0, 0.436),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(1.0, 1.0),
            end: const Offset(0.85, 0.85),
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
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
      'containerOnPageLoadAnimation2': AnimationInfo(
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
    if (currentUserLocationValue == null) {
      return Container(
        color: Theme.of(context).extension<CustomColors>()!.primaryBackground,
        child: const Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          bottom: false,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 50.0,
                        color: Color(0xC0000000),
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                MainHeaderWidget(
                                  model: _model,
                                  scaffoldKey: scaffoldKey,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                ),
                                MainCategoriesWidget(model: _model),
                                MainEventsWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                ),
                                MainVenuesSpotlightWidget(
                                  model: _model,
                                  currentUserLocationValue:
                                      currentUserLocationValue,
                                  animationsMap: animationsMap,
                                  onStateChanged: () => safeSetState(() {}),
                                ),
                              ]..add(const SizedBox(height: 120.0)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (currentUserDocument?.loginVenuesRoom != null)
                                Align(
                                  alignment: const AlignmentDirectional(
                                    1.0,
                                    1.0,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          10.0,
                                          0.0,
                                        ),
                                    child: AuthUserStreamWidget(
                                      builder: (context) {
                                        final firstVenueRoomRef =
                                            (currentUserDocument?.iDROOMVenues
                                                        .toList() ??
                                                    [])
                                                .firstOrNull;
                                        if (firstVenueRoomRef == null) {
                                          return const SizedBox.shrink();
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
                                              return const Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.transparent),
                                                  ),
                                                ),
                                              );
                                            }

                                            final containerUserInVenuesRecord =
                                                snapshot.data!;

                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  SocialInVenusePage.routeName,
                                                );

                                                context.appState.StyleVenuse =
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
                                                      const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              0.0,
                                                              0.0,
                                                            ),
                                                        child: Container(
                                                          width: 70.0,
                                                          height: 70.0,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: Image.network(
                                                                _safeMainImageUrl(
                                                                  currentUserDocument
                                                                      ?.logoRoom,
                                                                  fallback:
                                                                      _kMainFallbackProfileUrl,
                                                                ),
                                                              ).image,
                                                            ),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius: 4.0,
                                                                color: Color(
                                                                  0x34000000,
                                                                ),
                                                                offset: Offset(
                                                                  0.0,
                                                                  2.0,
                                                                ),
                                                              ),
                                                            ],
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                              1.05,
                                                              -1.0,
                                                            ),
                                                        child: Container(
                                                          width: 25.0,
                                                          height: 25.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Container(
                                                                  width: 25.0,
                                                                  height: 25.0,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      if (containerUserInVenuesRecord
                                                                          .user
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
                                                                          .isNotEmpty)
                                                                        Align(
                                                                          alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            0.0,
                                                                          ),
                                                                          child: Container(
                                                                            width:
                                                                                23.0,
                                                                            height:
                                                                                23.0,
                                                                            decoration: const BoxDecoration(
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
                                                                                  alignment: const AlignmentDirectional(
                                                                                    0.0,
                                                                                    0.0,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                                                              fontWeight: FontWeight.w800,
                                                                                              fontStyle: Theme.of(
                                                                                                context,
                                                                                              ).textTheme.bodyMedium!.fontStyle,
                                                                                            ),
                                                                                            fontSize: 11.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w800,
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
                                                            const AlignmentDirectional(
                                                              1.05,
                                                              1.0,
                                                            ),
                                                        child: Container(
                                                          width: 25.0,
                                                          height: 25.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                      0.0,
                                                                      0.0,
                                                                    ),
                                                                child: Container(
                                                                  width: 25.0,
                                                                  height: 25.0,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            const AlignmentDirectional(
                                                                              0.0,
                                                                              0.0,
                                                                            ),
                                                                        child: Container(
                                                                          width:
                                                                              27.0,
                                                                          height:
                                                                              27.0,
                                                                          decoration: const BoxDecoration(
                                                                            color: Color(
                                                                              0xFF07B53B,
                                                                            ),
                                                                            image:
                                                                                null,
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
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child: Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: const AlignmentDirectional(
                                                                                  0.0,
                                                                                  0.0,
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsetsDirectional.fromSTEB(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarIconButton extends ConsumerWidget {
  final String assetPath;
  final bool showBadge;
  final double iconSize;

  const _AppBarIconButton({
    required this.assetPath,
    this.showBadge = false,
    this.iconSize = 22.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(assetPath, width: iconSize, height: iconSize),
          ),
          if (showBadge)
            Positioned(
              top: 6.0,
              right: 6.0,
              child: Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE52020),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
