import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'tapbarsilver_model.dart';
export 'tapbarsilver_model.dart';

class TapbarsilverWidget extends StatefulWidget {
  const TapbarsilverWidget({super.key});

  @override
  State<TapbarsilverWidget> createState() => _TapbarsilverWidgetState();
}

class _TapbarsilverWidgetState extends State<TapbarsilverWidget> {
  late TapbarsilverModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TapbarsilverModel());

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
