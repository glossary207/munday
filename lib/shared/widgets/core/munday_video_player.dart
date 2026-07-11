import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '/core/utils/app_util.dart' show routeObserver;

const kDefaultAspectRatio = 16 / 9;

enum VideoType { asset, network }

Set<VideoPlayerController> _videoPlayers = Set();

class MundayVideoPlayer extends ConsumerStatefulWidget {
  const MundayVideoPlayer({
    super.key,
    required this.path,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
    this.pauseOnNavigate = true,
    this.volume = 1.0,
    this.onVideoCompleted,
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;
  final bool pauseOnNavigate;
  final double volume;
  final VoidCallback? onVideoCompleted;

  @override
  ConsumerState<MundayVideoPlayer> createState() => _MundayVideoPlayerState();
}

class _MundayVideoPlayerState extends ConsumerState<MundayVideoPlayer>
    with RouteAware {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _loggedError = false;
  bool _subscribedRoute = false;
  bool _isFullScreen = false;
  bool _completedFired = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    if (_subscribedRoute) {
      routeObserver.unsubscribe(this);
    }
    _disposeCurrentPlayer();
    super.dispose();
  }

  @override
  void didUpdateWidget(MundayVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _disposeCurrentPlayer();
      _initializePlayer();
    } else if (oldWidget.volume != widget.volume) {
      _videoPlayerController?.setVolume(widget.volume);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      _subscribedRoute = true;
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _videoPlayerController?.pause();
    }
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.sizeOf(context).width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
      ? width / aspectRatio
      : widget.height!;

  double get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio ??
      kDefaultAspectRatio;

  void _disposeCurrentPlayer() {
    _videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future _initializePlayer() async {
    _videoPlayerController = widget.videoType == VideoType.network
        ? VideoPlayerController.networkUrl(Uri.parse(widget.path))
        : VideoPlayerController.asset(widget.path);
    if (kIsWeb && widget.autoPlay) {
      // Browsers generally don't allow autoplay unless it's muted.
      // Ideally this should be configurable, but for now we just automatically
      // mute on web.
      // See https://pub.dev/packages/video_player_web#autoplay
      _videoPlayerController!.setVolume(0);
    } else {
      _videoPlayerController!.setVolume(widget.volume);
    }
    if (!widget.lazyLoad) {
      await _videoPlayerController?.initialize();
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
    );

    _videoPlayers.add(_videoPlayerController!);
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.hasError && !_loggedError) {
        print(
          'Error playing video: ${_videoPlayerController!.value.errorDescription}',
        );
        _loggedError = true;
      }
      if (!_videoPlayerController!.value.isPlaying &&
          _videoPlayerController!.value.position >=
              _videoPlayerController!.value.duration &&
          _videoPlayerController!.value.duration > Duration.zero) {
        if (!_completedFired) {
          _completedFired = true;
          if (widget.onVideoCompleted != null) {
            widget.onVideoCompleted!();
          }
        }
      }
      // Stop all other players when one video is playing.
      if (_videoPlayerController!.value.isPlaying) {
        _completedFired = false;
        _videoPlayers.forEach((otherPlayer) {
          if (otherPlayer != _videoPlayerController &&
              otherPlayer.value.isPlaying &&
              mounted) {
            setState(() {
              otherPlayer.pause();
            });
          }
        });
      }
    });

    _chewieController!.addListener(() {
      // On web, Chewie has issues when exiting fullscreen. As a workaround,
      // reset the video player when exiting fullscreen, as suggested here:
      // https://github.com/fluttercommunity/chewie/issues/688#issuecomment-1790033300.
      if (kIsWeb && !_chewieController!.isFullScreen && _isFullScreen) {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          final position = _videoPlayerController!.value.position;
          _disposeCurrentPlayer();
          await _initializePlayer();
          _videoPlayerController!.seekTo(position);
        });
      }
      _isFullScreen = _chewieController!.isFullScreen;
    });
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => ClipRect(
    child: FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: height,
        width: width,
        child:
            _chewieController != null &&
                (widget.lazyLoad ||
                    _chewieController!
                        .videoPlayerController
                        .value
                        .isInitialized)
            ? (widget.showControls
                  ? Chewie(controller: _chewieController!)
                  : ClipRect(
                      child: SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            width:
                                _chewieController!
                                        .videoPlayerController
                                        .value
                                        .size
                                        .width >
                                    0
                                ? _chewieController!
                                      .videoPlayerController
                                      .value
                                      .size
                                      .width
                                : 100,
                            height:
                                _chewieController!
                                        .videoPlayerController
                                        .value
                                        .size
                                        .height >
                                    0
                                ? _chewieController!
                                      .videoPlayerController
                                      .value
                                      .size
                                      .height
                                : 100,
                            child: VideoPlayer(
                              _chewieController!.videoPlayerController,
                            ),
                          ),
                        ),
                      ),
                    ))
            : (_chewieController != null &&
                  _chewieController!.videoPlayerController.value.hasError)
            ? Text('Error playing video')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Loading'),
                ],
              ),
      ),
    ),
  );
}
