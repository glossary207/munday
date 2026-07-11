import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class KeepAliveWidgetWrapper extends ConsumerStatefulWidget {
  const KeepAliveWidgetWrapper({Key? key, required this.builder})
    : super(key: key);

  final WidgetBuilder builder;

  @override
  ConsumerState<KeepAliveWidgetWrapper> createState() =>
      _KeepAliveWidgetWrapperState();
}

class _KeepAliveWidgetWrapperState extends ConsumerState<KeepAliveWidgetWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context);
  }
}
