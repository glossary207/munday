import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/core/munday_animations.dart';
import '/shared/widgets/core/munday_icon_button.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'dart:ui';
import '/core/utils/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'filter_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'filter_model.dart';

class FilterWidget extends ConsumerStatefulWidget {
  const FilterWidget({super.key});

  @override
  ConsumerState<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends ConsumerState<FilterWidget>
    with TickerProviderStateMixin {
  late FilterModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = FilterModel()..internalInit(context);

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0x6D000000)],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      '',
                    ).image,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.879,
                    height: MediaQuery.sizeOf(context).height * 1.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2C2C2C), Colors.black],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 30.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: MundayIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30.0,
                                      borderWidth: 1.0,
                                      buttonSize: 50.0,
                                      fillColor: Color(0xC7434343),
                                      icon: Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.k_61ovuoqq,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .override(
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
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .primaryText,
                                            fontSize: 24.0,
                                            letterSpacing: 1.0,
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
                            Container(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 40.0, 0.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 455.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .k_ax962ez4,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontStyle,
                                                          ),
                                                          color: Theme.of(
                                                                  context)
                                                              .extension<
                                                                  CustomColors>()!
                                                              .primaryBtnText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                          fontStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Text(
                                                          _model.sliderValue
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .extension<
                                                                            CustomColors>()!
                                                                        .primaryBtnText,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .fontStyle,
                                                                  ),
                                                        ),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_q0tqvw1e,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: Theme.of(
                                                                      context)
                                                                  .extension<
                                                                      CustomColors>()!
                                                                  .primaryBtnText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Slider.adaptive(
                                              activeColor: Color(0xFFFF0000),
                                              inactiveColor: Colors.white,
                                              min: 1.0,
                                              max: 1000000.0,
                                              value: _model.sliderValue ??=
                                                  context.appState.Filterdistance,
                                              label: _model.sliderValue
                                                  ?.toStringAsFixed(1),
                                              divisions: 1999998,
                                              onChanged: (newValue) {
                                                newValue = double.parse(newValue
                                                    .toStringAsFixed(1));
                                                safeSetState(() => _model
                                                    .sliderValue = newValue);
                                                EasyDebounce.debounce(
                                                  '_model.sliderValue',
                                                  Duration(milliseconds: 300),
                                                  () async {
                                                    context.appState.Filterdistance =
                                                        _model.sliderValue!;
                                                    safeSetState(() {});
                                                  },
                                                );
                                              },
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_nlvb3wjv,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: Theme.of(
                                                                      context)
                                                                  .extension<
                                                                      CustomColors>()!
                                                                  .primaryBtnText,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 15.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: MundayButton(
                                                        onPressed: () async {
                                                          if (functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Pub') ==
                                                              false) {
                                                            AppState()
                                                                .addToStyleVenuse(
                                                                    'Pub');
                                                            safeSetState(() {});
                                                          } else {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                    'Pub');
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .k_gy667nbh,
                                                        options:
                                                            MundayButtonOptions(
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Pub')!
                                                              ? Color(
                                                                  0xFFDE0000)
                                                              : Colors.white,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions.checklist(
                                                                            AppState()
                                                                                .StyleVenuse
                                                                                .toList(),
                                                                            'Pub')!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: MundayButton(
                                                        onPressed: () async {
                                                          if (functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Bar') ==
                                                              false) {
                                                            AppState()
                                                                .addToStyleVenuse(
                                                                    'Bar');
                                                            safeSetState(() {});
                                                          } else {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                    'Bar');
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .k_u6srszey,
                                                        options:
                                                            MundayButtonOptions(
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Bar')!
                                                              ? Color(
                                                                  0xFFDE0000)
                                                              : Colors.white,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions.checklist(
                                                                            AppState()
                                                                                .StyleVenuse
                                                                                .toList(),
                                                                            'Bar')!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: MundayButton(
                                                        onPressed: () async {
                                                          if (functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Chill') ==
                                                              false) {
                                                            AppState()
                                                                .addToStyleVenuse(
                                                                    'Chill');
                                                            safeSetState(() {});
                                                          } else {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                    'Chill');
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .k_eeyxdmdw,
                                                        options:
                                                            MundayButtonOptions(
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Chill')!
                                                              ? Color(
                                                                  0xFFDE0000)
                                                              : Colors.white,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions.checklist(
                                                                            AppState()
                                                                                .StyleVenuse
                                                                                .toList(),
                                                                            'Chill')!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: MundayButton(
                                                        onPressed: () async {
                                                          if (functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'CraftBeer') ==
                                                              false) {
                                                            AppState()
                                                                .addToStyleVenuse(
                                                                    'CraftBeer');
                                                            safeSetState(() {});
                                                          } else {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                    'CraftBeer');
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .k_rl0ga10m,
                                                        options:
                                                            MundayButtonOptions(
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'CraftBeer')!
                                                              ? Color(
                                                                  0xFFDE0000)
                                                              : Colors.white,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions.checklist(
                                                                            AppState()
                                                                                .StyleVenuse
                                                                                .toList(),
                                                                            'CraftBeer')!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: MundayButton(
                                                        onPressed: () async {
                                                          if (functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Out Door') ==
                                                              false) {
                                                            AppState()
                                                                .addToStyleVenuse(
                                                                    'Out Door');
                                                            safeSetState(() {});
                                                          } else {
                                                            AppState()
                                                                .removeFromStyleVenuse(
                                                                    'Out Door');
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .k_s9yaj8wb,
                                                        options:
                                                            MundayButtonOptions(
                                                          height: 25.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: functions.checklist(
                                                                  AppState()
                                                                      .StyleVenuse
                                                                      .toList(),
                                                                  'Out Door')!
                                                              ? Color(
                                                                  0xFFDE0000)
                                                              : Colors.white,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontWeight,
                                                                      fontStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleSmall!
                                                                          .fontStyle,
                                                                    ),
                                                                    color: functions.checklist(
                                                                            AppState()
                                                                                .StyleVenuse
                                                                                .toList(),
                                                                            'Out Door')!
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 20.0, 0.0, 15.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .k_s7cwbfue,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .override(
                                                              font: GoogleFonts
                                                                  .openSans(
                                                                fontWeight: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontWeight,
                                                                fontStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .fontStyle,
                                                              ),
                                                              color: Theme.of(
                                                                      context)
                                                                  .extension<
                                                                      CustomColors>()!
                                                                  .primaryBtnText,
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .fontStyle,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: MundayButton(
                                                    onPressed: () async {
                                                      if (functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'LiveMusic') ==
                                                          false) {
                                                        AppState()
                                                            .addToStyleMusic(
                                                                'LiveMusic');
                                                        safeSetState(() {});
                                                      } else {
                                                        AppState()
                                                            .removeFromStyleMusic(
                                                                'LiveMusic');
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .k_rmzseyr4,
                                                    options: MundayButtonOptions(
                                                      height: 25.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'LiveMusic')!
                                                          ? Color(0xFFDE0000)
                                                          : Colors.white,
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: functions.checklist(
                                                                    AppState()
                                                                        .StyleMusic
                                                                        .toList(),
                                                                    'LiveMusic')!
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .fontStyle,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: MundayButton(
                                                    onPressed: () async {
                                                      if (functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'Hiphop') ==
                                                          false) {
                                                        AppState()
                                                            .addToStyleMusic(
                                                                'Hiphop');
                                                        safeSetState(() {});
                                                      } else {
                                                        AppState()
                                                            .removeFromStyleMusic(
                                                                'Hiphop');
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .k_zchvxgoo,
                                                    options: MundayButtonOptions(
                                                      width: 80.0,
                                                      height: 25.0,
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'Hiphop')!
                                                          ? Color(0xFFDE0000)
                                                          : Colors.white,
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: functions.checklist(
                                                                    AppState()
                                                                        .StyleMusic
                                                                        .toList(),
                                                                    'Hiphop')!
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .fontStyle,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: MundayButton(
                                                    onPressed: () async {
                                                      if (functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'ลูกทุ่ง') ==
                                                          false) {
                                                        AppState()
                                                            .addToStyleMusic(
                                                                'ลูกทุ่ง');
                                                        safeSetState(() {});
                                                      } else {
                                                        AppState()
                                                            .removeFromStyleMusic(
                                                                'ลูกทุ่ง');
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .k_qtwraypg,
                                                    options: MundayButtonOptions(
                                                      height: 25.0,
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: functions.checklist(
                                                              AppState()
                                                                  .StyleMusic
                                                                  .toList(),
                                                              'ลูกทุ่ง')!
                                                          ? Color(0xFFDE0000)
                                                          : Colors.white,
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .override(
                                                            font: GoogleFonts
                                                                .openSans(
                                                              fontWeight: Theme
                                                                      .of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontWeight,
                                                              fontStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .fontStyle,
                                                            ),
                                                            color: functions.checklist(
                                                                    AppState()
                                                                        .StyleMusic
                                                                        .toList(),
                                                                    'ลูกทุ่ง')!
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall!
                                                                    .fontWeight,
                                                            fontStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .fontStyle,
                                                          ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: MundayButton(
                                                      onPressed: () async {
                                                        if (functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'เพื่อชีวิต') ==
                                                            false) {
                                                          AppState()
                                                              .addToStyleMusic(
                                                                  'เพื่อชีวิต');
                                                          safeSetState(() {});
                                                        } else {
                                                          AppState()
                                                              .removeFromStyleMusic(
                                                                  'เพื่อชีวิต');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .k_hddmmpbl,
                                                      options: MundayButtonOptions(
                                                        width: 80.0,
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color: functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'เพื่อชีวิต')!
                                                            ? Color(0xFFDE0000)
                                                            : Colors.white,
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: functions.checklist(
                                                                          AppState()
                                                                              .StyleMusic
                                                                              .toList(),
                                                                          'เพื่อชีวิต')!
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontStyle,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: MundayButton(
                                                      onPressed: () async {
                                                        if (functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'EDM') ==
                                                            false) {
                                                          AppState()
                                                              .addToStyleMusic(
                                                                  'EDM');
                                                          safeSetState(() {});
                                                        } else {
                                                          AppState()
                                                              .removeFromStyleMusic(
                                                                  'EDM');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .k_kcsysckt,
                                                      options: MundayButtonOptions(
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color: functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'EDM')!
                                                            ? Color(0xFFDE0000)
                                                            : Colors.white,
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: functions.checklist(
                                                                          AppState()
                                                                              .StyleMusic
                                                                              .toList(),
                                                                          'EDM')!
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontStyle,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: MundayButton(
                                                      onPressed: () async {
                                                        if (functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'Jazz') ==
                                                            false) {
                                                          AppState()
                                                              .addToStyleMusic(
                                                                  'Jazz');
                                                          safeSetState(() {});
                                                        } else {
                                                          AppState()
                                                              .removeFromStyleMusic(
                                                                  'Jazz');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .k_3kdu52bs,
                                                      options: MundayButtonOptions(
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color: functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'Jazz')!
                                                            ? Color(0xFFDE0000)
                                                            : Colors.white,
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: functions.checklist(
                                                                          AppState()
                                                                              .StyleMusic
                                                                              .toList(),
                                                                          'Jazz')!
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontStyle,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: MundayButton(
                                                      onPressed: () async {
                                                        if (functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'Rock') ==
                                                            false) {
                                                          AppState()
                                                              .addToStyleMusic(
                                                                  'Rock');
                                                          safeSetState(() {});
                                                        } else {
                                                          AppState()
                                                              .removeFromStyleMusic(
                                                                  'Rock');
                                                          safeSetState(() {});
                                                        }
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .k_22jap4o5,
                                                      options: MundayButtonOptions(
                                                        height: 25.0,
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color: functions.checklist(
                                                                AppState()
                                                                    .StyleMusic
                                                                    .toList(),
                                                                'Rock')!
                                                            ? Color(0xFFDE0000)
                                                            : Colors.white,
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontWeight,
                                                                    fontStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall!
                                                                        .fontStyle,
                                                                  ),
                                                                  color: functions.checklist(
                                                                          AppState()
                                                                              .StyleMusic
                                                                              .toList(),
                                                                          'Rock')!
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontWeight,
                                                                  fontStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .fontStyle,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.appState.Filterdistance = 15.0;
                    context.appState.StyleVenuse = [];
                    context.appState.StyleMusic = [];
                    safeSetState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.k_ms1qtkw9,
                    style: Theme.of(context).textTheme.bodyMedium!.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500,
                            fontStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontStyle,
                          ),
                          color: Color(0x98FFFFFF),
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              Theme.of(context).textTheme.bodyMedium!.fontStyle,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(),
                  child: Container(
                    width: double.infinity,
                    height: 130.0,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Color(0x51000000)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 12.0, 20.0, 50.0),
                          child: Container(
                            width: double.infinity,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFF0000),
                                            Color(0xFFC10000)
                                          ],
                                          stops: [0.0, 1.0],
                                          begin:
                                              AlignmentDirectional(0.0, -1.0),
                                          end: AlignmentDirectional(0, 1.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(45.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .k_zqtx4gzg,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
