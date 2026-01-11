import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/popupuser_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'showpeople_model.dart';
export 'showpeople_model.dart';

class ShowpeopleWidget extends StatefulWidget {
  const ShowpeopleWidget({
    super.key,
    required this.refdoc,
    required this.date,
  });

  final SupabaseDocRef? refdoc;
  final DateTime? date;

  @override
  State<ShowpeopleWidget> createState() => _ShowpeopleWidgetState();
}

class _ShowpeopleWidgetState extends State<ShowpeopleWidget> {
  late ShowpeopleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowpeopleModel());

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

    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: StreamBuilder<UserInVenuesRecord>(
        stream: UserInVenuesRecord.getDocument(widget.refdoc!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFF0000),
                  ),
                ),
              ),
            );
          }

          final gridViewUserInVenuesRecord = snapshot.data!;

          return Builder(
            builder: (context) {
              final datauser = gridViewUserInVenuesRecord.user
                  .where((e) => functions.checkdate(e.date, widget.date)!)
                  .toList()
                  .map((e) => e.user)
                  .toList()
                  .sortedList(keyOf: (e) => e.view, desc: false)
                  .toList();

              return RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () async {
                  safeSetState(() {});
                },
                child: GridView.builder(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    10.0,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.83,
                  ),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemCount: datauser.length,
                  itemBuilder: (context, datauserIndex) {
                    final datauserItem = datauser[datauserIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (datauserItem.userinstore != currentUserReference) {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PopupuserWidget(
                                  offchat: false,
                                  show: false,
                                  listref: functions.addref1(
                                      gridViewUserInVenuesRecord.user
                                          .where((e) => functions.checkdate(
                                              e.date, widget.date)!)
                                          .toList()
                                          .map((e) => e.user.userinstore)
                                          .withoutNulls
                                          .toList(),
                                      datauserItem.userinstore)!,
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));

                          FFAppState()
                              .addToAddviewID(datauserItem.userinstore!.id);
                          safeSetState(() {});
                          if (FFAppState().addviewID.length > 5) {
                            await UpdateotheruserviewCall.call(
                              viewsList: FFAppState().addviewID,
                            );

                            FFAppState().addviewID = [];
                            FFAppState().update(() {});
                          }
                        } else {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: PopupuserWidget(
                                  offchat: false,
                                  show: false,
                                  listref: functions.addref1(
                                      gridViewUserInVenuesRecord.user
                                          .where((e) => functions.checkdate(
                                              e.date, widget.date)!)
                                          .toList()
                                          .map((e) => e.user.userinstore)
                                          .withoutNulls
                                          .toList(),
                                      datauserItem.userinstore)!,
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.17,
                              height: MediaQuery.sizeOf(context).width * 0.17,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(90.0),
                                      bottomRight: Radius.circular(90.0),
                                      topLeft: Radius.circular(90.0),
                                      topRight: Radius.circular(90.0),
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        datauserItem.photoprofile,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                      ),
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 20.0),
                              child: Text(
                                valueOrDefault<String>(
                                  datauserItem.name,
                                  'ไม่ระบุ',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
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
          );
        },
      ),
    );
  }
}
