import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'header_appbar_menu_model.dart';
export 'header_appbar_menu_model.dart';

class HeaderAppbarMenuWidget extends StatefulWidget {
  const HeaderAppbarMenuWidget({super.key});

  @override
  State<HeaderAppbarMenuWidget> createState() => _HeaderAppbarMenuWidgetState();
}

class _HeaderAppbarMenuWidgetState extends State<HeaderAppbarMenuWidget> {
  late HeaderAppbarMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderAppbarMenuModel());

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
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }
}
