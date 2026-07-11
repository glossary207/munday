import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'table_model.dart';
import 'package:munday/core/theme/theme.dart';
export 'table_model.dart';

class TableWidget extends ConsumerStatefulWidget {
  const TableWidget({
    super.key,
    required this.offon,
    required this.codename,
    required this.tagcolor,
  });

  final bool? offon;
  final String? codename;
  final Color? tagcolor;

  @override
  ConsumerState<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends ConsumerState<TableWidget> {
  late TableModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = TableModel()..internalInit(context);

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
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 5.0,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: widget.tagcolor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(widget.codename, '-'),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.fontStyle,
                                ),
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
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Container(
              width: 5.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: Color(0xFF404040),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: Container(
              width: 5.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: Color(0xFF404040),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Container(
              width: 25.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: Color(0xFF404040),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Container(
              width: 25.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: Color(0xFF404040),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
              ),
            ),
          ),
          if (widget.offon ?? true)
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(color: Color(0x58000000)),
            ),
        ],
      ),
    );
  }
}
