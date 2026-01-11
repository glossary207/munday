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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

/// AppBarWidget (BG + scrollable area + optional dimming/gradient)
/// ---------------------------------------------------------------
/// * BG image stays behind content
/// * dimthelight == true  →  draws a 30% black overlay (#4C000000) + 100‑px
///   bottom gradient (black → transparent)
/// * scrollable area (SliverAppBar + homepage) is padded from top by maxscroll
/// * background colour of SliverAppBar is user‑controlled
/// ---------------------------------------------------------------

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
    this.width,
    this.height,
    this.backgroundColorSliverAppBar,
    this.expandedHeightAppBAr,
    this.shareborderRadius,
    required this.homepage,
    required this.pageSimpleAppBar,
    required this.pageSliverAppBar,
    this.photoBG,
    this.heightBG,
    required this.maxscroll,
    this.dimthelight = true,
  });

  final double? width;
  final double? height;
  final Color? backgroundColorSliverAppBar;
  final double? expandedHeightAppBAr;
  final double? shareborderRadius;

  final Widget Function() homepage;
  final Widget Function() pageSimpleAppBar;
  final Widget Function() pageSliverAppBar;

  final String? photoBG;
  final double? heightBG;
  final double maxscroll;

  /// if true  → show overlay + gradient
  final bool dimthelight;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  late final ScrollController _scrollController;
  bool _wasShrink = false;

  double get _expandedHeight => widget.expandedHeightAppBAr ?? 300;

  bool get _isShrink =>
      _scrollController.hasClients &&
      _scrollController.offset > (_expandedHeight - kToolbarHeight);

  /* ───────── listeners ───────── */
  void _scrollListener() {
    final shrink = _isShrink;
    if (shrink != _wasShrink) {
      _wasShrink = shrink;
      FFAppState().update(() => FFAppState().logtap = !shrink);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    FFAppState().update(() => FFAppState().logtap = true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  /* ───────── BG helper ───────── */
  Widget _buildBackground() {
    if (widget.photoBG == null) return const SizedBox.shrink();

    final imgProvider = widget.photoBG!.startsWith('http')
        ? NetworkImage(widget.photoBG!)
        : AssetImage(widget.photoBG!) as ImageProvider;

    final bgHeight = widget.heightBG ?? 300;

    return SizedBox(
      width: double.infinity,
      height: bgHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: imgProvider, fit: BoxFit.cover),
          if (widget.dimthelight) ...[
            Container(color: const Color(0x4C000000)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFF000000), Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /* ───────── Main scrollable ───────── */
  Widget _buildScrollable() {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              surface: Colors.transparent,
              background: Colors.transparent,
            ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: _expandedHeight,
              backgroundColor: widget.backgroundColorSliverAppBar,
              shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.circular(widget.shareborderRadius ?? 0),
              ),
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: SafeArea(
                  top: false,
                  bottom: false,
                  child: widget.pageSliverAppBar(),
                ),
              ),
              actions: _isShrink ? [widget.pageSimpleAppBar()] : null,
            ),
          ],
          body: widget.homepage(),
        ),
      ),
    );
  }

  /* ───────── build ───────── */
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          Padding(
            padding: EdgeInsets.only(top: widget.maxscroll),
            child: _buildScrollable(),
          ),
        ],
      ),
    );
  }
}
