import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/shared/widgets/misc/account_page_widget.dart';
import '/shared/widgets/layout/header_appbar_menu_widget.dart';
import '/shared/widgets/layout/tapbarsilver_widget.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import '/core/utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appbarsilver_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'appbarsilver_model.dart';

class AppbarsilverWidget extends ConsumerStatefulWidget {
  const AppbarsilverWidget({super.key, required this.image});

  final String? image;

  @override
  ConsumerState<AppbarsilverWidget> createState() => _AppbarsilverWidgetState();
}

class _AppbarsilverWidgetState extends ConsumerState<AppbarsilverWidget> {
  late AppbarsilverModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = AppbarsilverModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 1.0,
              child: custom_widgets.AppBarWidget(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1.0,
                backgroundColorSliverAppBar: Colors.transparent,
                expandedHeightAppBAr: functions.addtapsilverscale(
                  MediaQuery.sizeOf(context).width,
                  170.0,
                ),
                photoBG: widget.image,
                heightBG: MediaQuery.sizeOf(context).width,
                maxscroll: 150.0,
                dimthelight: true,
                homepage: () => AccountPageWidget(),
                pageSimpleAppBar: () => TapbarsilverWidget(),
                pageSliverAppBar: () => HeaderAppbarMenuWidget(),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25.0,
                    color: Color(0xA6000000),
                    offset: Offset(0.0, -3.0),
                    spreadRadius: 10.0,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Color(0xFF131313), Color(0xFF050505)],
                  stops: [0.0, 1.0],
                  begin: AlignmentDirectional(0.0, -1.0),
                  end: AlignmentDirectional(0, 1.0),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 16.0, 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        5.0,
                        0.0,
                        5.0,
                        0.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                15.0,
                                0.0,
                                5.0,
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.k_zay1saue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 25.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: Theme.of(
                                              context,
                                            ).textTheme.titleMedium!.fontStyle,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                15.0,
                                0.0,
                                0.0,
                              ),
                              child: Container(
                                width: 140.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90.0),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.k_jph82c73,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .fontStyle,
                                                  ),
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(
                                        -1.0,
                                        0.0,
                                      ),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF0000),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: FaIcon(
                                              FontAwesomeIcons.minus,
                                              color: Colors.white,
                                              size: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF0000),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(
                                            0.0,
                                            0.0,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  1.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: FaIcon(
                                              FontAwesomeIcons.plus,
                                              color: Colors.white,
                                              size: 18.0,
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
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: MundayButton(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: AppLocalizations.of(context)!.k_r5xcsk95,
                            icon: Icon(Icons.add, size: 15.0),
                            options: MundayButtonOptions(
                              width: double.infinity,
                              height: 50.0,
                              padding: EdgeInsets.all(0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              iconColor: Colors.white,
                              color: Color(0xFFFF0000),
                              textStyle: Theme.of(context).textTheme.titleSmall!
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: Theme.of(
                                        context,
                                      ).textTheme.titleSmall!.fontWeight,
                                      fontStyle: Theme.of(
                                        context,
                                      ).textTheme.titleSmall!.fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: Theme.of(
                                      context,
                                    ).textTheme.titleSmall!.fontWeight,
                                    fontStyle: Theme.of(
                                      context,
                                    ).textTheme.titleSmall!.fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 12.0)),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
              ),
            ),
          ),
          if (false)
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).width,
              child: custom_widgets.ContainerOnOffCondition(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                heightfalse: 150.0,
              ),
            ),
        ],
      ),
    );
  }
}
