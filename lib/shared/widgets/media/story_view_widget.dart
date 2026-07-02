import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munday/core/state/app_state.dart';
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'story_view_model.dart';
export 'story_view_model.dart';

class StoryViewWidget extends ConsumerStatefulWidget {
  const StoryViewWidget({super.key});

  @override
  ConsumerState<StoryViewWidget> createState() => _StoryViewWidgetState();
}

class _StoryViewWidgetState extends ConsumerState<StoryViewWidget> {
  late StoryViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = StoryViewModel()..internalInit(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: custom_widgets.FullPageStory(
        width: double.infinity,
        height: double.infinity,
        storyItemList: context.appState.storylist,
      ),
    );
  }
}
