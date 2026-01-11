// Automatic FlutterFlow imports
import '/backend/backend.dart';
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import "package:f_f_story_view_live_zhm3f3/backend/schema/structs/index.dart"
    as f_f_story_view_live_zhm3f3_data_schema;
import "package:f_f_story_view_live_zhm3f3/backend/schema/enums/enums.dart"
    as f_f_story_view_live_zhm3f3_enums;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Slidephoto extends StatefulWidget {
  const Slidephoto({
    super.key,
    this.width,
    this.height,
    this.dataphoto,
  });

  final double? width;
  final double? height;
  final List<String>? dataphoto;

  @override
  State<Slidephoto> createState() => _SlidephotoState();
}

class _SlidephotoState extends State<Slidephoto> {
  int currentIndex = 0;
  late PageController _pageController;
  List<bool>? viewedImages;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController
    _pageController = PageController();

    // Initialize the list to keep track of viewed images
    viewedImages = List<bool>.filled(widget.dataphoto?.length ?? 0, false);

    // Mark the first image as viewed
    if (viewedImages != null && viewedImages!.isNotEmpty) {
      viewedImages![0] = true;
    }
  }

  @override
  void dispose() {
    // Dispose of the PageController
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Assume a default aspect ratio since we cannot get the actual dimensions
    double aspectRatio = 16 / 9;

    return Container(
      width: widget.width,
      // Adjust the height to maintain the aspect ratio
      height: widget.width != null ? widget.width! / aspectRatio : null,
      child: Column(
        children: [
          // The PageView for sliding images
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.dataphoto?.length ?? 0,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                  // Mark the image as viewed
                  if (viewedImages != null &&
                      index < viewedImages!.length &&
                      !viewedImages![index]) {
                    viewedImages![index] = true;
                  }
                });
              },
              itemBuilder: (BuildContext context, int index) {
                String? photoUrl = widget.dataphoto?[index];
                return Image.network(
                  photoUrl ?? '',
                  width: widget.width,
                  fit: BoxFit
                      .fitWidth, // Fills the width, maintains aspect ratio
                  errorBuilder: (context, error, stackTrace) {
                    // Handle image loading errors
                    return Center(child: Text('Image not available'));
                  },
                );
              },
            ),
          ),
          // The indicator row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.dataphoto?.length ?? 0,
                (int index) {
                  Color dotColor;
                  if (index == currentIndex) {
                    dotColor = Colors.red; // Current image
                  } else if (viewedImages != null && viewedImages![index]) {
                    dotColor = Colors.grey; // Viewed images
                  } else {
                    dotColor = Colors.grey[700]!; // Not yet viewed images
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
