import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:collection/collection.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'block_model.dart';
export 'block_model.dart';

class BlockWidget extends StatefulWidget {
  const BlockWidget({
    super.key,
    required this.iduser,
  });

  final SupabaseDocRef? iduser;

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  late BlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlockModel());

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
      height: 280.0,
      decoration: BoxDecoration(
        color: Color(0xFF131313),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);

                  await currentUserReference!.update({
                    ...mapToSupabase(
                      {
                        'Blockuser': FieldValue.arrayUnion([widget.iduser]),
                        'usermassage': FieldValue.arrayRemove([widget.iduser]),
                        'usermassageRead':
                            FieldValue.arrayRemove([widget.iduser]),
                      },
                    ),
                  });

                  await widget.iduser!.update({
                    ...mapToSupabase(
                      {
                        'BlockEDuser':
                            FieldValue.arrayUnion([currentUserReference]),
                        'usermassage':
                            FieldValue.arrayRemove([currentUserReference]),
                        'usermassageRead':
                            FieldValue.arrayRemove([currentUserReference]),
                        'Report': FieldValue.increment(1),
                      },
                    ),
                  });
                  _model.aaaCopy = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'usersend',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'userrecive',
                          isEqualTo: widget.iduser,
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  _model.bbbCopy = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'usersend',
                          isEqualTo: widget.iduser,
                        )
                        .where(
                          'userrecive',
                          isEqualTo: currentUserReference,
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  if (_model.aaaCopy?.reference != null) {
                    await _model.aaaCopy!.reference.delete();
                  } else {
                    await _model.bbbCopy!.reference.delete();
                  }

                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  '4xgiypcj' /* รายงาน พฤติกรรมไม่เหมาะสม */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFB50000),
                  textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);

                  await currentUserReference!.update({
                    ...mapToSupabase(
                      {
                        'Blockuser': FieldValue.arrayUnion([widget.iduser]),
                        'usermassage': FieldValue.arrayRemove([widget.iduser]),
                        'usermassageRead':
                            FieldValue.arrayRemove([widget.iduser]),
                      },
                    ),
                  });

                  await widget.iduser!.update({
                    ...mapToSupabase(
                      {
                        'BlockEDuser':
                            FieldValue.arrayUnion([currentUserReference]),
                        'usermassage':
                            FieldValue.arrayRemove([currentUserReference]),
                        'usermassageRead':
                            FieldValue.arrayRemove([currentUserReference]),
                      },
                    ),
                  });
                  _model.aaa = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'usersend',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'userrecive',
                          isEqualTo: widget.iduser,
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  _model.bbb = await queryRoomRecordOnce(
                    queryBuilder: (roomRecord) => roomRecord
                        .where(
                          'usersend',
                          isEqualTo: widget.iduser,
                        )
                        .where(
                          'userrecive',
                          isEqualTo: currentUserReference,
                        ),
                    singleRecord: true,
                  ).then((s) => s.firstOrNull);
                  if (_model.aaa?.reference != null) {
                    await _model.aaa!.reference.delete();
                  } else {
                    await _model.bbb!.reference.delete();
                  }

                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: FFLocalizations.of(context).getText(
                  '2zyj6fm1' /* Block การมองเห็น */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFB50000),
                  textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  '6pmw7gnn' /* ยกเลิก */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF232323),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
