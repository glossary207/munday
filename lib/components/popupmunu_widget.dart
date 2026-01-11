import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'popupmunu_model.dart';
export 'popupmunu_model.dart';

class PopupmunuWidget extends StatefulWidget {
  const PopupmunuWidget({super.key});

  @override
  State<PopupmunuWidget> createState() => _PopupmunuWidgetState();
}

class _PopupmunuWidgetState extends State<PopupmunuWidget> {
  late PopupmunuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PopupmunuModel());

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
