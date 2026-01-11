import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'part_app_bar_model.dart';
export 'part_app_bar_model.dart';

class PartAppBarWidget extends StatefulWidget {
  const PartAppBarWidget({super.key});

  @override
  State<PartAppBarWidget> createState() => _PartAppBarWidgetState();
}

class _PartAppBarWidgetState extends State<PartAppBarWidget> {
  late PartAppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PartAppBarModel());

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
