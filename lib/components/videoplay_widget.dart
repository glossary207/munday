import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'videoplay_model.dart';
export 'videoplay_model.dart';

class VideoplayWidget extends StatefulWidget {
  const VideoplayWidget({
    super.key,
    required this.datavideo,
  });

  final List<String>? datavideo;

  @override
  State<VideoplayWidget> createState() => _VideoplayWidgetState();
}

class _VideoplayWidgetState extends State<VideoplayWidget> {
  late VideoplayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideoplayModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0x59000000),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final video = widget.datavideo!.toList();

                          return Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage:
                                              max(0, min(0, video.length - 1))),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: video.length,
                                  itemBuilder: (context, videoIndex) {
                                    final videoItem = video[videoIndex];
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: FlutterFlowVideoPlayer(
                                            path: videoItem,
                                            videoType: VideoType.network,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1.0,
                                            autoPlay: true,
                                            looping: false,
                                            showControls: false,
                                            allowFullScreen: false,
                                            allowPlaybackSpeedMenu: false,
                                            lazyLoad: false,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 100.0),
                                    child: smooth_page_indicator
                                        .SmoothPageIndicator(
                                      controller: _model.pageViewController ??=
                                          PageController(
                                              initialPage: max(
                                                  0, min(0, video.length - 1))),
                                      count: video.length,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) async {
                                        await _model.pageViewController!
                                            .animateToPage(
                                          i,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                        safeSetState(() {});
                                      },
                                      effect: smooth_page_indicator
                                          .ExpandingDotsEffect(
                                        expansionFactor: 3.0,
                                        spacing: 10.0,
                                        radius: 8.0,
                                        dotWidth: 11.0,
                                        dotHeight: 11.0,
                                        dotColor: Colors.white,
                                        activeDotColor: Color(0xFFFF0000),
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
