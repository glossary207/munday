// Automatic FlutterFlow imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/core/utils/app_util.dart';
import '/shared/widgets/index.dart'; // Imports other custom widgets
import '/core/utils/index.dart'; // Imports custom actions
import '/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:story_view/story_view.dart';
import 'package:munday/core/theme/theme.dart';

/// fullpage
class FullPageStory extends ConsumerStatefulWidget {
  const FullPageStory({
    super.key,
    this.width,
    this.height,
    required this.storyItemList,
  });

  final double? width;
  final double? height;
  final List<StoryItemStruct> storyItemList;

  @override
  ConsumerState<FullPageStory> createState() => _FullPageStoryState();
}

class _FullPageStoryState extends ConsumerState<FullPageStory> {
  final StoryController controller = StoryController();

  StoryItem storyItemSwitch(StoryItemStruct storyItem) {
    return switch (storyItem.type) {
      StoryItemEnum.text => StoryItem.text(
          title: storyItem.title,
          backgroundColor: storyItem.backgroundColor ?? Colors.white,
        ),
      StoryItemEnum.inlineImage => StoryItem.inlineImage(
          url: storyItem.url,
          controller: controller,
          caption: Text(
            storyItem.caption,
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.black54,
              fontSize: 17,
            ),
          ),
        ),
      StoryItemEnum.pageImage =>
        StoryItem.pageImage(url: storyItem.url, controller: controller),
      StoryItemEnum.pageVideo => StoryItem.pageVideo(
          storyItem.url,
          controller: controller,
        ),
    };
  }

  @override
  void dispose() {
    // 1. หยุดวิดีโอทันทีเมื่อปิดหน้า (แก้ปัญหาเสียงไหล)
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: StoryView(
        storyItems: widget.storyItemList
            .map<StoryItem>((e) => storyItemSwitch(e))
            .toList(),
        onStoryShow: (storyItem, index) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
          // 2. สั่งปิดหน้าเมื่อเล่นจบทุกคลิป
          if (mounted) {
            Navigator.of(context).pop();
          }
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: controller,
        // ลบ indicatorBackgroundColor ที่ error ออกแล้วครับ
      ),
    );
  }
}
