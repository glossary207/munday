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
import 'package:munday/core/theme/theme.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Slidephoto extends ConsumerStatefulWidget {
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
  ConsumerState<Slidephoto> createState() => _SlidephotoState();
}

class _SlidephotoState extends ConsumerState<Slidephoto> {
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
