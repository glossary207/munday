import '/backend/schema/structs/index.dart';
import '/components/showpromotion_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rowpromotion_model.dart';
export 'rowpromotion_model.dart';

class RowpromotionWidget extends StatefulWidget {
  const RowpromotionWidget({
    super.key,
    required this.dataPro,
    required this.todaycheck,
  });

  final List<PromotionDataSubStruct>? dataPro;
  final bool? todaycheck;

  @override
  State<RowpromotionWidget> createState() => _RowpromotionWidgetState();
}

class _RowpromotionWidgetState extends State<RowpromotionWidget> {
  late RowpromotionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RowpromotionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    return Builder(
      builder: (context) {
        final dd = functions
                .sourcedatadatepromotion(widget.dataPro?.toList(),
                    FFAppState().dateclick, !widget.todaycheck!)
                ?.toList() ??
            [];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(dd.length, (ddIndex) {
              final ddItem = dd[ddIndex];
              return Flexible(
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: ShowpromotionWidget(
                            photo: functions.selectpicture(
                                ddIndex,
                                functions
                                    .sourcedatadatepromotion(
                                        widget.dataPro?.toList(),
                                        FFAppState().dateclick,
                                        !widget.todaycheck!)
                                    ?.map((e) => e.photo)
                                    .toList()
                                    .toList())!,
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            ddItem.photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (functions.checkdayactivepromotion(
                              ddItem.mon,
                              ddItem.tue,
                              ddItem.wed,
                              ddItem.thu,
                              ddItem.fri,
                              ddItem.sat,
                              ddItem.sun,
                              FFAppState().dateclick) ??
                          true)
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFF0000),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x34000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(0.0),
                                ),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 1.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.0, 0.0, 2.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'kzrbch3h' /* Today */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              letterSpacing: 0.3,
                                              fontWeight: FontWeight.w500,
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
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
