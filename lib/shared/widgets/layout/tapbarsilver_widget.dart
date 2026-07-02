import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'tapbarsilver_model.dart';
export 'tapbarsilver_model.dart';

class TapbarsilverWidget extends ConsumerStatefulWidget {
  const TapbarsilverWidget({super.key});

  @override
  ConsumerState<TapbarsilverWidget> createState() => _TapbarsilverWidgetState();
}

class _TapbarsilverWidgetState extends ConsumerState<TapbarsilverWidget> {
  late TapbarsilverModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = TapbarsilverModel()..internalInit(context);

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
