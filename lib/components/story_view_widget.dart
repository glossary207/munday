import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'story_view_model.dart';
export 'story_view_model.dart';

class StoryViewWidget extends StatefulWidget {
  const StoryViewWidget({super.key});

  @override
  State<StoryViewWidget> createState() => _StoryViewWidgetState();
}

class _StoryViewWidgetState extends State<StoryViewWidget> {
  late StoryViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoryViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: custom_widgets.FullPageStory(
        width: double.infinity,
        height: double.infinity,
        storyItemList: FFAppState().storylist,
      ),
    );
  }
}
