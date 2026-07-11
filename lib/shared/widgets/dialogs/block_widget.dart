import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'block_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'block_model.dart';

class BlockWidget extends ConsumerStatefulWidget {
  const BlockWidget({super.key, required this.iduser});

  final SupabaseDocRef? iduser;

  @override
  ConsumerState<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends ConsumerState<BlockWidget> {
  late BlockModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = BlockModel()..internalInit(context);

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
            offset: Offset(0.0, -3.0),
          ),
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
              child: MundayButton(
                onPressed: () async {
                  Navigator.pop(context);

                  await currentUserReference!.update({
                    ...mapToSupabase({
                      'Blockuser': FieldValue.arrayUnion([widget.iduser]),
                      'usermassage': FieldValue.arrayRemove([widget.iduser]),
                      'usermassageRead': FieldValue.arrayRemove([
                        widget.iduser,
                      ]),
                    }),
                  });

                  await widget.iduser!.update({
                    ...mapToSupabase({
                      'BlockEDuser': FieldValue.arrayUnion([
                        currentUserReference,
                      ]),
                      'usermassage': FieldValue.arrayRemove([
                        currentUserReference,
                      ]),
                      'usermassageRead': FieldValue.arrayRemove([
                        currentUserReference,
                      ]),
                      'Report': FieldValue.increment(1),
                    }),
                  });
                  _model.aaaCopy =
                      await queryChatRoomsRecordOnce(
                        queryBuilder: (q) => q.where(
                          'user_ids',
                          arrayContains: currentUserReference,
                        ),
                        singleRecord: true,
                      ).then(
                        (s) => s
                            .where((r) => r.userIds.contains(widget.iduser?.id))
                            .firstOrNull,
                      );
                  if (_model.aaaCopy?.reference != null) {
                    await _model.aaaCopy!.reference.delete();
                  }

                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: AppLocalizations.of(context)!.k_4xgiypcj,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ),
                  color: Color(0xFFB50000),
                  textStyle: Theme.of(context).textTheme.bodyLarge!.override(
                    font: GoogleFonts.openSans(
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontWeight,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontStyle,
                    ),
                    color: Theme.of(
                      context,
                    ).extension<CustomColors>()!.primaryText,
                    letterSpacing: 0.0,
                    fontWeight: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.fontWeight,
                    fontStyle: Theme.of(context).textTheme.bodyLarge!.fontStyle,
                  ),
                  elevation: 2.0,
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: MundayButton(
                onPressed: () async {
                  Navigator.pop(context);

                  await currentUserReference!.update({
                    ...mapToSupabase({
                      'Blockuser': FieldValue.arrayUnion([widget.iduser]),
                      'usermassage': FieldValue.arrayRemove([widget.iduser]),
                      'usermassageRead': FieldValue.arrayRemove([
                        widget.iduser,
                      ]),
                    }),
                  });

                  await widget.iduser!.update({
                    ...mapToSupabase({
                      'BlockEDuser': FieldValue.arrayUnion([
                        currentUserReference,
                      ]),
                      'usermassage': FieldValue.arrayRemove([
                        currentUserReference,
                      ]),
                      'usermassageRead': FieldValue.arrayRemove([
                        currentUserReference,
                      ]),
                    }),
                  });
                  _model.aaa =
                      await queryChatRoomsRecordOnce(
                        queryBuilder: (q) => q.where(
                          'user_ids',
                          arrayContains: currentUserReference,
                        ),
                        singleRecord: true,
                      ).then(
                        (s) => s
                            .where((r) => r.userIds.contains(widget.iduser?.id))
                            .firstOrNull,
                      );
                  if (_model.aaa?.reference != null) {
                    await _model.aaa!.reference.delete();
                  }

                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: AppLocalizations.of(context)!.k_2zyj6fm1,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ),
                  color: Color(0xFFB50000),
                  textStyle: Theme.of(context).textTheme.bodyLarge!.override(
                    font: GoogleFonts.openSans(
                      fontWeight: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontWeight,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.fontStyle,
                    ),
                    color: Theme.of(
                      context,
                    ).extension<CustomColors>()!.primaryText,
                    letterSpacing: 0.0,
                    fontWeight: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.fontWeight,
                    fontStyle: Theme.of(context).textTheme.bodyLarge!.fontStyle,
                  ),
                  elevation: 2.0,
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: MundayButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: AppLocalizations.of(context)!.k_6pmw7gnn,
                options: MundayButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ),
                  color: Color(0xFF232323),
                  textStyle: Theme.of(context).textTheme.titleSmall!.override(
                    font: GoogleFonts.lexendDeca(
                      fontWeight: FontWeight.normal,
                      fontStyle: Theme.of(
                        context,
                      ).textTheme.titleSmall!.fontStyle,
                    ),
                    color: Theme.of(
                      context,
                    ).extension<CustomColors>()!.primaryText,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: Theme.of(
                      context,
                    ).textTheme.titleSmall!.fontStyle,
                  ),
                  elevation: 0.0,
                  borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
