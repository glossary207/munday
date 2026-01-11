import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/option_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'check_cheers_model.dart';
export 'check_cheers_model.dart';

class CheckCheersWidget extends StatefulWidget {
  const CheckCheersWidget({
    super.key,
    required this.datatore,
  });

  final List<dynamic>? datatore;

  @override
  State<CheckCheersWidget> createState() => _CheckCheersWidgetState();
}

class _CheckCheersWidgetState extends State<CheckCheersWidget>
    with TickerProviderStateMixin {
  late CheckCheersModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckCheersModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await currentUserReference!.update(createUsersRecordData(
        readcheers: (currentUserDocument?.usercheerme.toList() ?? []).length,
      ));
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0, 1.571),
            end: Offset(0, 0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 300.0.ms,
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
    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 120.0, 10.0, 0.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 570.0,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF0E0E0E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 2.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '46da8ms1' /* Cheers  Match */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 26.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2.0,
                    thickness: 1.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '0d3y4v1l' /* มีคน Cheers คุณ */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.openSans(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: Container(
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Color(0xFF1D1D1D),
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Icon(
                                          Icons.people_rounded,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            (currentUserDocument?.usercheerme
                                                        .toList() ??
                                                    [])
                                                .length
                                                .toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 5.0, 10.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              if ((currentUserDocument?.usercheerme.toList() ??
                                          [])
                                      .length !=
                                  0)
                                AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final cheers = functions
                                              .showUserCheersMe(
                                                  (currentUserDocument
                                                              ?.usercheerme
                                                              .toList() ??
                                                          [])
                                                      .toList(),
                                                  widget.datatore?.toList())
                                              ?.toList() ??
                                          [];

                                      return GridView.builder(
                                        padding: EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          80.0,
                                        ),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                          childAspectRatio: 0.8,
                                        ),
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        itemCount: cheers.length,
                                        itemBuilder: (context, cheersIndex) {
                                          final cheersItem =
                                              cheers[cheersIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if ((currentUserDocument
                                                              ?.openseeuser
                                                              .toList() ??
                                                          [])
                                                      .contains(DatauserStruct
                                                              .maybeFromMap(
                                                                  cheersItem)
                                                          ?.userinstore) ||
                                                  valueOrDefault<bool>(
                                                      currentUserDocument
                                                          ?.seeusercheers,
                                                      false) ||
                                                  (currentUserDocument
                                                              ?.cheersEnd
                                                              .toList() ??
                                                          [])
                                                      .contains(DatauserStruct
                                                              .maybeFromMap(
                                                                  cheersItem)
                                                          ?.userinstore)) {
                                                FFAppState().addToAddviewID(
                                                    DatauserStruct.maybeFromMap(
                                                            cheersItem)!
                                                        .userinstore!
                                                        .id);
                                                safeSetState(() {});
                                              } else {
                                                if (valueOrDefault(
                                                        currentUserDocument
                                                            ?.freeseeuser,
                                                        0) <=
                                                    0) {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    useSafeArea: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: OptionWidget(),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                } else {
                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToSupabase(
                                                      {
                                                        'openseeuser':
                                                            FieldValue
                                                                .arrayUnion([
                                                          DatauserStruct
                                                                  .maybeFromMap(
                                                                      cheersItem)
                                                              ?.userinstore
                                                        ]),
                                                        'freeseeuser':
                                                            FieldValue
                                                                .increment(
                                                                    -(1)),
                                                      },
                                                    ),
                                                  });
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    valueOrDefault<String>(
                                                      DatauserStruct
                                                              .maybeFromMap(
                                                                  cheersItem)
                                                          ?.photoprofile,
                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/k5229q5inuat/DALL%C2%B7E_2024-01-12_21.02.17_-_A_beautiful_Asian_woman_is_happily_typing_a_message_on_her_mobile_phone._Shes_in_a_dimly_lit_bar%2C_with_soft_red_lighting_emanating_from_the_bars_lig.png',
                                                    ),
                                                  ).image,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(12.0),
                                                  bottomRight:
                                                      Radius.circular(12.0),
                                                  topLeft:
                                                      Radius.circular(12.0),
                                                  topRight:
                                                      Radius.circular(12.0),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  if ((currentUserDocument
                                                                  ?.openseeuser
                                                                  .toList() ??
                                                              [])
                                                          .contains(DatauserStruct
                                                                  .maybeFromMap(
                                                                      cheersItem)
                                                              ?.userinstore) ||
                                                      valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.seeusercheers,
                                                          false) ||
                                                      (currentUserDocument
                                                                  ?.cheersEnd
                                                                  .toList() ??
                                                              [])
                                                          .contains(DatauserStruct
                                                                  .maybeFromMap(
                                                                      cheersItem)
                                                              ?.userinstore))
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        15.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                DatauserStruct
                                                                        .maybeFromMap(
                                                                            cheersItem)
                                                                    ?.name,
                                                                'ไม่ระบุ',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      child:
                                                          custom_widgets.Blur(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        off: (currentUserDocument
                                                                        ?.openseeuser
                                                                        .toList() ??
                                                                    [])
                                                                .contains(DatauserStruct
                                                                        .maybeFromMap(
                                                                            cheersItem)
                                                                    ?.userinstore) ||
                                                            valueOrDefault<
                                                                    bool>(
                                                                currentUserDocument
                                                                    ?.seeusercheers,
                                                                false) ||
                                                            (currentUserDocument
                                                                        ?.cheersEnd
                                                                        .toList() ??
                                                                    [])
                                                                .contains(DatauserStruct
                                                                        .maybeFromMap(
                                                                            cheersItem)
                                                                    ?.userinstore),
                                                      ),
                                                    ),
                                                  ),
                                                  if (!((currentUserDocument
                                                                  ?.openseeuser
                                                                  .toList() ??
                                                              [])
                                                          .contains(DatauserStruct
                                                                  .maybeFromMap(
                                                                      cheersItem)
                                                              ?.userinstore) ||
                                                      valueOrDefault<bool>(
                                                          currentUserDocument
                                                              ?.seeusercheers,
                                                          false) ||
                                                      (currentUserDocument
                                                                  ?.cheersEnd
                                                                  .toList() ??
                                                              [])
                                                          .contains(DatauserStruct
                                                                  .maybeFromMap(
                                                                      cheersItem)
                                                              ?.userinstore)))
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      4.0),
                                                          child: Text(
                                                            valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.freeseeuser,
                                                                    0)
                                                                .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      3.0,
                                                                      0.0,
                                                                      3.0,
                                                                      4.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              's757cb9p' /* x */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ).animateOnPageLoad(animationsMap[
                                              'containerOnPageLoadAnimation']!);
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 4.0))
                    .addToEnd(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: 120.0,
            decoration: BoxDecoration(),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.0, -1.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 10.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close_sharp,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 35.0,
              ),
            ),
          ),
        ),
        if (valueOrDefault<bool>(currentUserDocument?.seeusercheers, false) ==
            false)
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: AuthUserStreamWidget(
                builder: (context) => Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xFF0E0E0E)],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: OptionWidget(),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF0E0E0E),
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                color: Color(0xFF202020),
                                width: 3.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 35.0,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/ez5qwjya52q4/eye.png',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 25.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '4fxmvmsu' /* ดูว่าใคร Cheers คุณ */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
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
            ),
          ),
      ],
    );
  }
}
