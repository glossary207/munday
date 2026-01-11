import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'testsheetmenu_model.dart';
export 'testsheetmenu_model.dart';

class TestsheetmenuWidget extends StatefulWidget {
  const TestsheetmenuWidget({super.key});

  @override
  State<TestsheetmenuWidget> createState() => _TestsheetmenuWidgetState();
}

class _TestsheetmenuWidgetState extends State<TestsheetmenuWidget> {
  late TestsheetmenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestsheetmenuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
