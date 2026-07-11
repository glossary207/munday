import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/l10n/app_localizations.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/core/munday_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'delchat_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'delchat_model.dart';

class DelchatWidget extends ConsumerStatefulWidget {
  const DelchatWidget({
    super.key,
    required this.chatID,
    required this.room,
    required this.who,
    required this.testmessage,
    required this.photomessage,
    required this.time,
  });

  final int? chatID;
  final SupabaseDocRef? room;
  final SupabaseDocRef? who;
  final String? testmessage;
  final String? photomessage;
  final DateTime? time;

  @override
  ConsumerState<DelchatWidget> createState() => _DelchatWidgetState();
}

class _DelchatWidgetState extends ConsumerState<DelchatWidget> {
  late DelchatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = DelchatModel()..internalInit(context);

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
      height: 228.0,
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
                },
                text: AppLocalizations.of(context)!.k_quxzlxti,
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
                text: AppLocalizations.of(context)!.k_biyxjvln,
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
