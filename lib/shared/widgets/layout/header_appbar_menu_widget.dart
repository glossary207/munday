import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'header_appbar_menu_model.dart';
export 'header_appbar_menu_model.dart';

class HeaderAppbarMenuWidget extends ConsumerStatefulWidget {
  const HeaderAppbarMenuWidget({super.key});

  @override
  ConsumerState<HeaderAppbarMenuWidget> createState() => _HeaderAppbarMenuWidgetState();
}

class _HeaderAppbarMenuWidgetState extends ConsumerState<HeaderAppbarMenuWidget> {
  late HeaderAppbarMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = HeaderAppbarMenuModel()..internalInit(context);

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
