import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/shared/widgets/cards/card33_user_grid_widget.dart';
import '/shared/widgets/dialogs/edit_image_modal_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:f_f_story_view_live_zhm3f3/app_state.dart'
    as f_f_story_view_live_zhm3f3_app_state;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
    required this.fromSeting,
  });

  final bool? fromSeting;

  static String routeName = 'Profile';
  static String routePath = 'profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  static const int _photoshowSlotCount = 6;
  static const String _profileMainHeroPrefix = 'profile_photo_main';
  static const String _profilePreviewHeroPrefix = 'profile_photo_preview';
  static const String _photoshowPlaceholderUrl =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png';

  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  List<String?>? _photoshowDraftUrls;
  bool _isSavingPhotoshow = false;
  bool _instagramFollowersLoading = false;
  int? _instagramFollowersCount;
  int _instagramRequestToken = 0;
  String _instagramLookupInput = '';

  String? _normalizedPhotoUrl(String? url) {
    final trimmed = url?.trim() ?? '';
    return trimmed.isEmpty ? null : trimmed;
  }

  String _currentInstagramHandle() {
    final persistedHandle = FFAppState().profileInstagramHandle.trim();
    if (persistedHandle.isNotEmpty) {
      return persistedHandle;
    }
    return valueOrDefault(currentUserDocument?.idig, '').trim();
  }

  void _storeInstagramHandle(String value) {
    final trimmedValue = value.trim();
    FFAppState().update(() {
      FFAppState().profileInstagramHandle = trimmedValue;
    });
  }

  String _normalizeInstagramInput(String? rawInput) {
    var value = (rawInput ?? '').trim();
    if (value.isEmpty) {
      return '';
    }

    value = value.replaceFirst(RegExp(r'^@+'), '');

    if (value.contains('instagram.com')) {
      try {
        final parsedUrl = Uri.parse(
          value.startsWith('http') ? value : 'https://$value',
        );
        value = parsedUrl.pathSegments
                .where((segment) => segment.isNotEmpty)
                .firstOrNull ??
            '';
      } catch (_) {}
    }

    value = value.replaceFirst(RegExp(r'^@+'), '');
    value = value.split(RegExp(r'[/?#]')).first.trim();
    return value;
  }

  void _syncInstagramFollowersForInput(String? rawInput) {
    final nextInput = _normalizeInstagramInput(rawInput);
    if (_instagramLookupInput == nextInput) {
      return;
    }
    _instagramLookupInput = nextInput;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _refreshInstagramFollowers(nextInput);
    });
  }

  Future<void> _refreshInstagramFollowers(String rawInput) async {
    final requestToken = ++_instagramRequestToken;
    final hasUsername = rawInput.trim().isNotEmpty;
    if (!hasUsername) {
      setState(() {
        _instagramFollowersLoading = false;
        _instagramFollowersCount = null;
      });
      return;
    }

    setState(() {
      _instagramFollowersLoading = true;
    });

    var followersCount = 0;
    var hasFollowersCount = false;
    try {
      final response =
          await GetInstagramProfileInfoCall.call(username: rawInput);
      if (!mounted || requestToken != _instagramRequestToken) {
        return;
      }

      if (response.succeeded) {
        final backendFollowersCount =
            GetInstagramProfileInfoCall.followersCount(response.jsonBody);
        if (backendFollowersCount != null) {
          followersCount = backendFollowersCount;
          hasFollowersCount = true;
        }
      }
    } catch (_) {}

    if (!mounted || requestToken != _instagramRequestToken) {
      return;
    }

    if (!hasFollowersCount) {
      try {
        final publicResponse =
            await GetInstagramPublicProfileCall.call(username: rawInput);
        if (!mounted || requestToken != _instagramRequestToken) {
          return;
        }
        final publicFollowersCount =
            GetInstagramPublicProfileCall.followersCount(
                publicResponse.jsonBody);
        if (publicResponse.succeeded && publicFollowersCount != null) {
          followersCount = publicFollowersCount;
          hasFollowersCount = true;
        }
      } catch (_) {}
    }

    if (!mounted || requestToken != _instagramRequestToken) {
      return;
    }

    setState(() {
      _instagramFollowersLoading = false;
      _instagramFollowersCount = hasFollowersCount ? followersCount : null;
    });
  }

  String _instagramFollowersText() {
    if ((_model.textController3?.text.trim() ?? '').isEmpty) {
      return '';
    }
    if (_instagramFollowersLoading) {
      return '...';
    }
    if (_instagramFollowersCount == null) {
      return '-';
    }
    return formatNumber(
      _instagramFollowersCount,
      formatType: FormatType.compact,
    );
  }

  void _clearInstagramHandle() {
    EasyDebounce.cancel('_profileInstagramFollowersLookup');
    setState(() {
      _model.textController3?.clear();
      _instagramLookupInput = '';
      _instagramFollowersLoading = false;
      _instagramFollowersCount = null;
    });
    _storeInstagramHandle('');
  }

  Widget _buildInstagramSection() {
    final followersText = _instagramFollowersText();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 10.0),
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(0xFF1D1D1D),
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    15.0,
                    0.0,
                    10.0,
                    0.0,
                  ),
                  child: TextFormField(
                    controller: _model.textController3,
                    focusNode: _model.textFieldFocusNode3,
                    autofocus: false,
                    obscureText: false,
                    onChanged: (_) {
                      _storeInstagramHandle(_model.textController3?.text ?? '');
                      EasyDebounce.debounce(
                        '_profileInstagramFollowersLookup',
                        const Duration(milliseconds: 500),
                        () => _syncInstagramFollowersForInput(
                          _model.textController3?.text,
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: FFLocalizations.of(context).getText(
                        'eihlwqu6' /* Name Instagram */,
                      ),
                      hintStyle: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    validator:
                        _model.textController3Validator.asValidator(context),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _clearInstagramHandle,
                child: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      axisAlignment: -1.0,
                      child: child,
                    ),
                  );
                },
                child: followersText.isEmpty
                    ? const SizedBox.shrink(key: ValueKey('empty'))
                    : Container(
                        key: ValueKey('followers_$followersText'),
                        height: 50.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF131313),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(18.0),
                            topRight: Radius.circular(18.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 7.0,
                              ),
                              child: Text(
                                followersText,
                                style: GoogleFonts.openSans(
                                  color: _instagramFollowersCount == null &&
                                          !_instagramFollowersLoading
                                      ? const Color(0xFF9A9A9A)
                                      : Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.person_sharp,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _profileHeroTag(String prefix, String url) => '${prefix}_$url';

  _PhotoshowGalleryItem? _profileGalleryItem({
    Object? heroTagOverride,
  }) {
    final resolvedUrl = _normalizedPhotoUrl(currentUserPhoto);
    if (resolvedUrl == null) {
      return null;
    }
    return _PhotoshowGalleryItem(
      url: resolvedUrl,
      heroTag:
          heroTagOverride ?? _profileHeroTag(_profileMainHeroPrefix, resolvedUrl),
      isProfile: true,
    );
  }

  List<_PhotoshowGalleryItem> _photoshowGalleryItems({
    Object? profileHeroTagOverride,
  }) {
    final photoshowUrls = _effectivePhotoshowUrls();
    final galleryItems = <_PhotoshowGalleryItem>[];
    final profileItem = _profileGalleryItem(
      heroTagOverride: profileHeroTagOverride,
    );
    if (profileItem != null) {
      galleryItems.add(profileItem);
    }
    for (var index = 0; index < photoshowUrls.length; index++) {
      final resolvedUrl = _normalizedPhotoUrl(photoshowUrls[index]);
      if (resolvedUrl == null) {
        continue;
      }
      galleryItems.add(
        _PhotoshowGalleryItem(
          url: resolvedUrl,
          heroTag: 'photo${index + 1}_$resolvedUrl',
          isProfile: false,
        ),
      );
    }
    return galleryItems;
  }

  Future<void> _openPhotoshowViewer(
    String? url,
    Object heroTag, {
    Object? profileHeroTagOverride,
  }) async {
    final resolvedUrl = _normalizedPhotoUrl(url);
    if (resolvedUrl == null) {
      return;
    }
    final galleryItems = _photoshowGalleryItems(
      profileHeroTagOverride: profileHeroTagOverride,
    );
    final initialIndex = galleryItems.indexWhere(
      (item) => item.heroTag == heroTag,
    );
    if (galleryItems.isEmpty || initialIndex < 0) {
      return;
    }
    await Navigator.push(
      context,
      PageRouteBuilder<void>(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) =>
            _PhotoshowGalleryViewer(
          items: galleryItems,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  Future<void> _openProfileGalleryViewer(Object heroTag) async {
    final profileItem = _profileGalleryItem(
      heroTagOverride: heroTag,
    );
    if (profileItem == null) {
      return;
    }
    await _openPhotoshowViewer(
      profileItem.url,
      heroTag,
      profileHeroTagOverride: heroTag,
    );
  }

  Widget _buildPhotoshowImage(String? url, Object heroTag) {
    final resolvedUrl = _normalizedPhotoUrl(url);
    if (resolvedUrl == null) {
      return const SizedBox.expand();
    }
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async => _openPhotoshowViewer(resolvedUrl, heroTag),
      child: Hero(
        tag: heroTag,
        transitionOnUserGestures: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Image.network(
            resolvedUrl,
            width: 300.0,
            height: 200.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  List<String?> _photoshowUrlsFromDocument() {
    final photoshow = currentUserDocument?.photoshow;
    return <String?>[
      _normalizedPhotoUrl(photoshow?.photo1),
      _normalizedPhotoUrl(photoshow?.photo2),
      _normalizedPhotoUrl(photoshow?.photo3),
      _normalizedPhotoUrl(photoshow?.photo4),
      _normalizedPhotoUrl(photoshow?.photo5),
      _normalizedPhotoUrl(photoshow?.photo6),
    ];
  }

  List<String?> _effectivePhotoshowUrls() => List<String?>.from(
        _photoshowDraftUrls ?? _photoshowUrlsFromDocument(),
      );

  UserphotoshowStruct _photoshowStructFromUrls(
    List<String?> urls, {
    bool clearUnsetFields = true,
  }) {
    String? valueAt(int index) =>
        index < urls.length ? _normalizedPhotoUrl(urls[index]) : null;

    return createUserphotoshowStruct(
      photo1: valueAt(0),
      photo2: valueAt(1),
      photo3: valueAt(2),
      photo4: valueAt(3),
      photo5: valueAt(4),
      photo6: valueAt(5),
      clearUnsetFields: clearUnsetFields,
    );
  }

  Future<void> _persistPhotoshowUrls(
    List<String?> urls, {
    required String errorMessage,
  }) async {
    if (currentUserReference == null) {
      return;
    }

    final sanitizedUrls = List<String?>.generate(
      _photoshowSlotCount,
      (index) => index < urls.length ? _normalizedPhotoUrl(urls[index]) : null,
    );
    final previousDraft = _photoshowDraftUrls == null
        ? null
        : List<String?>.from(_photoshowDraftUrls!);

    safeSetState(() {
      _photoshowDraftUrls = List<String?>.from(sanitizedUrls);
      _isSavingPhotoshow = true;
    });

    try {
      await currentUserReference!.update(createUsersRecordData(
        photoshow: _photoshowStructFromUrls(
          sanitizedUrls,
          clearUnsetFields: true,
        ),
      ));
    } catch (error) {
      debugPrint('Failed to persist photoshow urls: $error');
      safeSetState(() {
        _photoshowDraftUrls = previousDraft;
      });
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
    } finally {
      if (mounted) {
        safeSetState(() {
          _isSavingPhotoshow = false;
        });
      }
    }
  }

  Future<void> _savePhotoshowImage(int slot, String imageUrl) async {
    final photoshowUrls = _effectivePhotoshowUrls();
    final targetIndex = slot - 1;
    if (targetIndex < 0 || targetIndex >= _photoshowSlotCount) {
      return;
    }
    photoshowUrls[targetIndex] = _normalizedPhotoUrl(imageUrl);
    await _persistPhotoshowUrls(
      photoshowUrls,
      errorMessage: 'อัปโหลดรูปไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
    );
  }

  Future<void> _removePhotoshowImage(int slot) async {
    final photoshowUrls = _effectivePhotoshowUrls();
    final targetIndex = slot - 1;
    if (targetIndex < 0 || targetIndex >= _photoshowSlotCount) {
      return;
    }
    photoshowUrls[targetIndex] = null;
    await _persistPhotoshowUrls(
      photoshowUrls,
      errorMessage: 'ลบรูปไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
    );
  }

  Future<void> _reorderPhotoshowImages(int fromIndex, int toIndex) async {
    if (fromIndex == toIndex) {
      return;
    }

    final photoshowUrls = _effectivePhotoshowUrls();
    if (fromIndex < 0 ||
        fromIndex >= photoshowUrls.length ||
        toIndex < 0 ||
        toIndex >= photoshowUrls.length) {
      return;
    }

    final movingUrl = photoshowUrls[fromIndex];
    if (movingUrl == null) {
      return;
    }

    photoshowUrls[fromIndex] = photoshowUrls[toIndex];
    photoshowUrls[toIndex] = movingUrl;

    await _persistPhotoshowUrls(
      photoshowUrls,
      errorMessage: 'จัดลำดับรูปไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
    );
  }

  Future<void> _pickAndUploadPhotoshowImage(int slot) async {
    final selectedMedia = await selectMedia(
      maxWidth: 800.0,
      maxHeight: 800.0,
      imageQuality: 90,
      mediaSource: MediaSource.photoGallery,
      multiImage: false,
    );
    if (selectedMedia == null ||
        !selectedMedia.every(
          (media) => validateFileFormat(media.storagePath, context),
        )) {
      return;
    }
    if (!mounted) {
      return;
    }

    FFUploadedFile? selectedImage;
    try {
      showUploadMessage(
        context,
        'Preparing image...',
        showLoading: true,
      );
      selectedImage = selectedMedia.isNotEmpty
          ? FFUploadedFile(
              name: selectedMedia.first.storagePath.split('/').last,
              bytes: selectedMedia.first.bytes,
              height: selectedMedia.first.dimensions?.height,
              width: selectedMedia.first.dimensions?.width,
              blurHash: selectedMedia.first.blurHash,
              originalFilename: selectedMedia.first.originalFilename,
            )
          : null;
    } finally {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    }

    if (selectedImage == null ||
        !(selectedImage.bytes?.isNotEmpty ?? false) ||
        !mounted) {
      return;
    }

    final croppedImageUrl = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x00000000),
      enableDrag: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: SizedBox(
              height: double.infinity,
              child: EditImageModalWidget(
                croppShape: 'square',
                cropPercentage: 0.8,
                selectedImage: selectedImage,
                direct: 0,
              ),
            ),
          ),
        );
      },
    );

    if (!mounted || !(croppedImageUrl?.isNotEmpty ?? false)) {
      return;
    }

    await _savePhotoshowImage(slot, croppedImageUrl!);
  }

  Widget _buildPhotoshowTileSurface({
    required int index,
    required String? imageUrl,
    required bool isActiveTarget,
  }) {
    final resolvedUrl = _normalizedPhotoUrl(imageUrl);
    final hasPhoto = resolvedUrl != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(_photoshowPlaceholderUrl).image,
        ),
        border: isActiveTarget
            ? Border.all(
                color: const Color(0xFF00D333),
                width: 2.5,
              )
            : null,
      ),
      child: Stack(
        children: [
          _buildPhotoshowImage(
            resolvedUrl,
            'photo${index + 1}_${resolvedUrl ?? 'empty'}',
          ),
          if (!hasPhoto)
            Align(
              alignment: const AlignmentDirectional(1.05, -1.04),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  8.0,
                  8.0,
                  0.0,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: _isSavingPhotoshow
                      ? null
                      : () => _pickAndUploadPhotoshowImage(index + 1),
                  child: Container(
                    width: 23.0,
                    height: 23.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D333),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                          spreadRadius: 1.0,
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          if (hasPhoto && _model.editphoto)
            Align(
              alignment: const AlignmentDirectional(1.05, -1.04),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  8.0,
                  8.0,
                  0.0,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: _isSavingPhotoshow
                      ? null
                      : () => _removePhotoshowImage(index + 1),
                  child: Container(
                    width: 23.0,
                    height: 23.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2D38),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                          spreadRadius: 1.0,
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          if (_isSavingPhotoshow)
            const Positioned.fill(
              child: IgnorePointer(
                child: ColoredBox(
                  color: Color(0x22000000),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhotoshowTile(int index, List<String?> photoshowUrls) {
    final resolvedUrl = _normalizedPhotoUrl(photoshowUrls[index]);
    final dragEnabled = resolvedUrl != null &&
        !_isSavingPhotoshow &&
        photoshowUrls.where((url) => _normalizedPhotoUrl(url) != null).length > 1;
    final targetEnabled = !_isSavingPhotoshow;

    return LayoutBuilder(
      builder: (context, constraints) {
        return DragTarget<int>(
          onWillAcceptWithDetails: (details) =>
              targetEnabled && details.data != index,
          onAcceptWithDetails: (details) async {
            await _reorderPhotoshowImages(details.data, index);
          },
          builder: (context, candidateData, rejectedData) {
            final tile = _buildPhotoshowTileSurface(
              index: index,
              imageUrl: resolvedUrl,
              isActiveTarget: candidateData.isNotEmpty,
            );

            if (!dragEnabled) {
              return tile;
            }

            return LongPressDraggable<int>(
              data: index,
              delay: const Duration(milliseconds: 140),
              dragAnchorStrategy: pointerDragAnchorStrategy,
              feedbackOffset: Offset.zero,
              feedback: Material(
                color: Colors.transparent,
                child: Transform.translate(
                  offset: Offset(
                    -constraints.maxWidth / 2,
                    -constraints.maxHeight / 2,
                  ),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: _buildPhotoshowTileSurface(
                      index: index,
                      imageUrl: resolvedUrl,
                      isActiveTarget: false,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Opacity(
                opacity: 0.35,
                child: _buildPhotoshowTileSurface(
                  index: index,
                  imageUrl: resolvedUrl,
                  isActiveTarget: false,
                ),
              ),
              child: tile,
            );
          },
        );
      },
    );
  }

  Widget _buildPhotoshowSection() {
    return AuthUserStreamWidget(
      builder: (context) {
        final photoshowUrls = _effectivePhotoshowUrls();
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            20.0,
            0.0,
            20.0,
            0.0,
          ),
          child: Container(
            width: double.infinity,
            height: 260.0,
            decoration: const BoxDecoration(
              color: Color(0xFF0E0E0E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250.0,
                  child: AbsorbPointer(
                    absorbing: _isSavingPhotoshow,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1.5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: _photoshowSlotCount,
                      itemBuilder: (context, index) =>
                          _buildPhotoshowTile(index, photoshowUrls),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.editphoto = false;
      safeSetState(() {});
      if (!FFAppState().relock) {
        FFAppState().namestorelink =
            valueOrDefault(currentUserDocument?.checkin, '');
        FFAppState().ActivePromotion = false;
        FFAppState().apiready = true;
        FFAppState().relock = true;
        safeSetState(() {});
      }
    });

    _model.textController1 ??=
        TextEditingController(text: currentUserDisplayName);
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textFieldFocusNode1!.addListener(
      () async {
        await currentUserReference!.update(createUsersRecordData(
          displayName: _model.textController1.text,
        ));
        _model.datachange = true;
      },
    );
    _model.textController2 ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.caption, ''));
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textFieldFocusNode2!.addListener(
      () async {
        await currentUserReference!.update(createUsersRecordData(
          caption: _model.textController2.text,
        ));
        _model.datachange = true;
      },
    );
    final initialInstagramHandle = _currentInstagramHandle();
    _model.textController3 ??=
        TextEditingController(text: initialInstagramHandle);
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textFieldFocusNode3!.addListener(
      () async {
        if (_model.textFieldFocusNode3?.hasFocus ?? false) {
          return;
        }
        _storeInstagramHandle(_model.textController3?.text ?? '');
        _syncInstagramFollowersForInput(_model.textController3?.text);
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (FFAppState().profileInstagramHandle.isEmpty &&
          initialInstagramHandle.isNotEmpty) {
        _storeInstagramHandle(initialInstagramHandle);
      }
      _syncInstagramFollowersForInput(_model.textController3?.text);
    });
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    EasyDebounce.cancel('_profileInstagramFollowersLookup');
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<f_f_story_view_live_zhm3f3_app_state.FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) {
        if (currentUserDocument == null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: PopScope(
            canPop: false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.black,
              body: SafeArea(
                top: true,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          25.0, 5.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (widget.fromSeting!) {
                                            context.pushNamed(
                                                MainWidget.routeName);
                                          } else {
                                            context.safePop();
                                          }

                                          if (_model.datachange) {
                                            await UpdateprofileCall.call(
                                              nameupdated:
                                                  currentUserDisplayName,
                                              captionupdated: valueOrDefault(
                                                  currentUserDocument?.caption,
                                                  ''),
                                              photoprofileupdated:
                                                  currentUserPhoto,
                                              storeid: currentUserDocument
                                                  ?.checkinID?.id,
                                              uid: currentUserReference?.id,
                                            );
                                          }
                                          if ((currentUserDisplayName != '') &&
                                              (currentUserPhoto != '') &&
                                              functions.checkphotoshow(
                                                  currentUserDocument
                                                      ?.photoshow.photo1,
                                                  currentUserDocument
                                                      ?.photoshow.photo2,
                                                  currentUserDocument
                                                      ?.photoshow.photo3,
                                                  currentUserDocument
                                                      ?.photoshow.photo4,
                                                  currentUserDocument
                                                      ?.photoshow.photo5,
                                                  currentUserDocument
                                                      ?.photoshow.photo6)!) {
                                            await currentUserDocument!
                                                .checkinID!
                                                .update({
                                              ...mapToSupabase(
                                                {
                                                  'goodprofile':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ]),
                                                },
                                              ),
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 5.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'wkp4og0j' /* Profile */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 25.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        borderWidth: 1.0,
                                        icon: Icon(
                                          Icons.more_vert_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 30.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed(
                                              AccountSettingsWidget.routeName);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 5.0, 20.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF131313),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 12.0, 20.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 90.0,
                                          height: 90.0,
                                          decoration: BoxDecoration(),
                                          child: Stack(
                                            children: [
                                              Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) {
                                                      final resolvedUrl =
                                                          _normalizedPhotoUrl(
                                                              currentUserPhoto);
                                                      final mainHeroTag =
                                                          resolvedUrl == null
                                                              ? null
                                                              : _profileHeroTag(
                                                                  _profileMainHeroPrefix,
                                                                  resolvedUrl,
                                                                );
                                                      final profileItem =
                                                          _profileGalleryItem(
                                                        heroTagOverride:
                                                            mainHeroTag,
                                                      );
                                                      final imageUrl =
                                                          profileItem?.url ??
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';
                                                      final avatar =
                                                          Container(
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image:
                                                                Image.network(
                                                              imageUrl,
                                                            ).image,
                                                          ),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      );

                                                      if (profileItem == null) {
                                                        return avatar;
                                                      }

                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: mainHeroTag ==
                                                                null
                                                            ? null
                                                            : () =>
                                                                _openProfileGalleryViewer(
                                                                  mainHeroTag,
                                                                ),
                                                        child: Hero(
                                                          tag: profileItem
                                                              .heroTag,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: avatar,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 1.0),
                                                    child: Container(
                                                      width: 32.0,
                                                      height: 32.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF171717),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                final selectedMedia =
                                                                    await selectMedia(
                                                                  maxWidth:
                                                                      800.00,
                                                                  maxHeight:
                                                                      800.00,
                                                                  imageQuality:
                                                                      90,
                                                                  mediaSource:
                                                                      MediaSource
                                                                          .photoGallery,
                                                                  multiImage:
                                                                      false,
                                                                );
                                                                if (selectedMedia !=
                                                                        null &&
                                                                    selectedMedia.every((m) =>
                                                                        validateFileFormat(
                                                                            m.storagePath,
                                                                            context))) {
                                                                  safeSetState(() =>
                                                                      _model.isDataUploading_uploadDataMainEditpopup =
                                                                          true);
                                                                  var selectedUploadedFiles =
                                                                      <FFUploadedFile>[];

                                                                  try {
                                                                    selectedUploadedFiles = selectedMedia
                                                                        .map((m) => FFUploadedFile(
                                                                              name: m.storagePath.split('/').last,
                                                                              bytes: m.bytes,
                                                                              height: m.dimensions?.height,
                                                                              width: m.dimensions?.width,
                                                                              blurHash: m.blurHash,
                                                                              originalFilename: m.originalFilename,
                                                                            ))
                                                                        .toList();
                                                                  } finally {
                                                                    _model.isDataUploading_uploadDataMainEditpopup =
                                                                        false;
                                                                  }
                                                                  if (selectedUploadedFiles
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length) {
                                                                    safeSetState(
                                                                        () {
                                                                      _model.uploadedLocalFile_uploadDataMainEditpopup =
                                                                          selectedUploadedFiles
                                                                              .first;
                                                                    });
                                                                  } else {
                                                                    safeSetState(
                                                                        () {});
                                                                    return;
                                                                  }
                                                                }

                                                                if ((_model
                                                                        .uploadedLocalFile_uploadDataMainEditpopup
                                                                        .bytes
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    barrierColor:
                                                                        Color(
                                                                            0x00000000),
                                                                    enableDrag:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                double.infinity,
                                                                            child:
                                                                                EditImageModalWidget(
                                                                              croppShape: 'square',
                                                                              cropPercentage: 0.8,
                                                                              selectedImage: _model.uploadedLocalFile_uploadDataMainEditpopup,
                                                                              direct: 0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(() =>
                                                                          _model.singleCroppedImage1 =
                                                                              value));

                                                                  if ((_model
                                                                          .singleCroppedImage1
                                                                          ?.isNotEmpty ??
                                                                      false)) {
                                                                    await currentUserReference!
                                                                        .update(
                                                                            createUsersRecordData(
                                                                      photoUrl:
                                                                          _model
                                                                              .singleCroppedImage1,
                                                                    ));
                                                                    _model.datachange =
                                                                        true;
                                                                  }
                                                                }

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Container(
                                                                width: 24.0,
                                                                height: 24.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .pen,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 13.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 200.0,
                                                        height: 35.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              TextFormField(
                                                            controller: _model
                                                                .textController1,
                                                            focusNode: _model
                                                                .textFieldFocusNode1,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              hintText:
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                '6ju9gvsj' /* Your name */,
                                                              ),
                                                              hintStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .roboto(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            23.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF383838),
                                                                  width: 1.3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                              ),
                                                              focusedBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF383838),
                                                                  width: 1.3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                              ),
                                                              errorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF383838),
                                                                  width: 1.3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF383838),
                                                                  width: 1.3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0.0),
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          8.0),
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      23.0,
                                                                  letterSpacing:
                                                                      0.6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      0.0,
                                                                ),
                                                            validator: _model
                                                                .textController1Validator
                                                                .asValidator(
                                                                    context),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    5.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 200.0,
                                                          height: 35.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child:
                                                              AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                TextFormField(
                                                              controller: _model
                                                                  .textController2,
                                                              focusNode: _model
                                                                  .textFieldFocusNode2,
                                                              autofocus: false,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                hintText:
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                  'cy6tkoqn' /* Your caption */,
                                                                ),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                      lineHeight:
                                                                          0.0,
                                                                    ),
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF383838),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                ),
                                                                focusedBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF383838),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                ),
                                                                errorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF383838),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                ),
                                                                focusedErrorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF383838),
                                                                    width: 1.3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0.0),
                                                                ),
                                                                contentPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                    lineHeight:
                                                                        0.0,
                                                                  ),
                                                              validator: _model
                                                                  .textController2Validator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['containerOnPageLoadAnimation']!),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      25.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'f6ab0k03' /* Profile preview */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 25.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 7.0, 0.0),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20.0,
                                        ),
                                      ),
                                      AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          valueOrDefault(
                                                  currentUserDocument?.view, 0)
                                              .toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 87.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF131313),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.88, 0.0),
                                          child: Container(
                                            width: 57.0,
                                            height: 57.0,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                              children: [
                                                AuthUserStreamWidget(
                                                  builder: (context) {
                                                    final resolvedUrl =
                                                        _normalizedPhotoUrl(
                                                            currentUserPhoto);
                                                    final previewHeroTag =
                                                        resolvedUrl == null
                                                            ? null
                                                            : _profileHeroTag(
                                                                _profilePreviewHeroPrefix,
                                                                resolvedUrl,
                                                              );
                                                    final profileItem =
                                                        _profileGalleryItem(
                                                      heroTagOverride:
                                                          previewHeroTag,
                                                    );
                                                    final imageUrl =
                                                        profileItem?.url ??
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png';
                                                    final previewImage =
                                                        ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90.0),
                                                      child: Image.network(
                                                        imageUrl,
                                                        width: 57.0,
                                                        height: 57.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );

                                                    if (profileItem == null) {
                                                      return previewImage;
                                                    }

                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: previewHeroTag ==
                                                              null
                                                          ? null
                                                          : () =>
                                                              _openProfileGalleryViewer(
                                                                previewHeroTag,
                                                              ),
                                                      child: Hero(
                                                        tag:
                                                            profileItem.heroTag,
                                                        transitionOnUserGestures:
                                                            true,
                                                        child: previewImage,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.1, 1.1),
                                                  child: Container(
                                                    width: 19.0,
                                                    height: 18.0,
                                                    decoration: BoxDecoration(),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Container(
                                                            width: 19.0,
                                                            height: 19.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF171717),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: 12.0,
                                                                    height:
                                                                        12.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF00D333),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: Image
                                                                            .network(
                                                                          '',
                                                                        ).image,
                                                                      ),
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                0.65, -0.1),
                                            child: Container(
                                              height: 54.0,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 0.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.03,
                                                                        0.33),
                                                                child:
                                                                    AuthUserStreamWidget(
                                                                  builder:
                                                                      (context) =>
                                                                          Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      currentUserDisplayName,
                                                                      'ไม่ระบุ',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              17.0,
                                                                          letterSpacing:
                                                                              0.6,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -0.16,
                                                                      0.91),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            1.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    AuthUserStreamWidget(
                                                                  builder:
                                                                      (context) =>
                                                                          Text(
                                                                    valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.caption,
                                                                        ''),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 2,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  20.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 1.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  _model.editphoto =
                                                                      !_model
                                                                          .editphoto;
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .pen,
                                                                  color: _model
                                                                              .editphoto ==
                                                                          true
                                                                      ? Color(
                                                                          0xFFFF2D38)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  size: 17.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              _buildPhotoshowSection(),
                              if (false)
                                Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 260.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0E0E0E),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 250.0,
                                        decoration: BoxDecoration(),
                                        child: GridView(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 1.5,
                                            mainAxisSpacing: 1.5,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        _buildPhotoshowImage(
                                                      currentUserDocument!
                                                          .photoshow
                                                          .photo1,
                                                      'photo1_${currentUserDocument!.photoshow.photo1}',
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo1 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo1 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    800.00,
                                                                maxHeight:
                                                                    800.00,
                                                                imageQuality:
                                                                    90,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData1popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  showUploadMessage(
                                                                    context,
                                                                    'Uploading file...',
                                                                    showLoading:
                                                                        true,
                                                                  );
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .hideCurrentSnackBar();
                                                                  _model.isDataUploading_uploadData1popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData1popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                  showUploadMessage(
                                                                      context,
                                                                      'Success!');
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  showUploadMessage(
                                                                      context,
                                                                      'Failed to upload data');
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData1popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData1popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage2 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage2
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    1,
                                                                    _model
                                                                        .singleCroppedImage2!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo1 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo1 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo1: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        _buildPhotoshowImage(
                                                      currentUserDocument!
                                                          .photoshow
                                                          .photo2,
                                                      'photo2_${currentUserDocument!.photoshow.photo2}',
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo2 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo2 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    800.00,
                                                                maxHeight:
                                                                    800.00,
                                                                imageQuality:
                                                                    90,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData2popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadData2popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData2popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData2popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData2popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage3 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage3
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    2,
                                                                    _model
                                                                        .singleCroppedImage3!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo2 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo2 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo2: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        _buildPhotoshowImage(
                                                      currentUserDocument!
                                                          .photoshow
                                                          .photo3,
                                                      'photo3_${currentUserDocument!.photoshow.photo3}',
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo3 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo3 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    700.00,
                                                                maxHeight:
                                                                    700.00,
                                                                imageQuality:
                                                                    90,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData3popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadData3popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData3popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData3popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData3popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage4 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage4
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    3,
                                                                    _model
                                                                        .singleCroppedImage4!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo3 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo3 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo3: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          _buildPhotoshowImage(
                                                        currentUserDocument!
                                                            .photoshow
                                                            .photo4,
                                                        'photo4_${currentUserDocument!.photoshow.photo4}',
                                                      ),
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo4 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo4 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    800.00,
                                                                maxHeight:
                                                                    800.00,
                                                                imageQuality:
                                                                    90,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData4popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadData4popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData4popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData4popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData4popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage5 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage5
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    4,
                                                                    _model
                                                                        .singleCroppedImage5!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo4 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo4 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo4: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        _buildPhotoshowImage(
                                                      currentUserDocument!
                                                          .photoshow
                                                          .photo5,
                                                      'photo5_${currentUserDocument!.photoshow.photo5}',
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo5 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo5 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    800.00,
                                                                maxHeight:
                                                                    800.00,
                                                                imageQuality:
                                                                    90,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData5popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadData5popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData5popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData5popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData5popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage6 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage6
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    5,
                                                                    _model
                                                                        .singleCroppedImage6!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo5 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo5 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo5: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: Image.network(
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
                                                  ).image,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  AuthUserStreamWidget(
                                                    builder: (context) =>
                                                        _buildPhotoshowImage(
                                                      currentUserDocument!
                                                          .photoshow
                                                          .photo6,
                                                      'photo6_${currentUserDocument!.photoshow.photo6}',
                                                    ),
                                                  ),
                                                  if (currentUserDocument
                                                              ?.photoshow
                                                              .photo6 ==
                                                          null ||
                                                      currentUserDocument
                                                              ?.photoshow
                                                              .photo6 ==
                                                          '')
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final selectedMedia =
                                                                  await selectMedia(
                                                                maxWidth:
                                                                    700.00,
                                                                maxHeight:
                                                                    700.00,
                                                                imageQuality:
                                                                    80,
                                                                mediaSource:
                                                                    MediaSource
                                                                        .photoGallery,
                                                                multiImage:
                                                                    false,
                                                              );
                                                              if (selectedMedia !=
                                                                      null &&
                                                                  selectedMedia.every((m) =>
                                                                      validateFileFormat(
                                                                          m.storagePath,
                                                                          context))) {
                                                                safeSetState(() =>
                                                                    _model.isDataUploading_uploadData6popup =
                                                                        true);
                                                                var selectedUploadedFiles =
                                                                    <FFUploadedFile>[];

                                                                try {
                                                                  selectedUploadedFiles =
                                                                      selectedMedia
                                                                          .map((m) =>
                                                                              FFUploadedFile(
                                                                                name: m.storagePath.split('/').last,
                                                                                bytes: m.bytes,
                                                                                height: m.dimensions?.height,
                                                                                width: m.dimensions?.width,
                                                                                blurHash: m.blurHash,
                                                                                originalFilename: m.originalFilename,
                                                                              ))
                                                                          .toList();
                                                                } finally {
                                                                  _model.isDataUploading_uploadData6popup =
                                                                      false;
                                                                }
                                                                if (selectedUploadedFiles
                                                                        .length ==
                                                                    selectedMedia
                                                                        .length) {
                                                                  safeSetState(
                                                                      () {
                                                                    _model.uploadedLocalFile_uploadData6popup =
                                                                        selectedUploadedFiles
                                                                            .first;
                                                                  });
                                                                } else {
                                                                  safeSetState(
                                                                      () {});
                                                                  return;
                                                                }
                                                              }

                                                              if ((_model
                                                                      .uploadedLocalFile_uploadData6popup
                                                                      .bytes
                                                                      ?.isNotEmpty ??
                                                                  false)) {
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  barrierColor:
                                                                      Color(
                                                                          0x00000000),
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              double.infinity,
                                                                          child:
                                                                              EditImageModalWidget(
                                                                            croppShape:
                                                                                'square',
                                                                            cropPercentage:
                                                                                0.8,
                                                                            selectedImage:
                                                                                _model.uploadedLocalFile_uploadData6popup,
                                                                            direct:
                                                                                0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.singleCroppedImage7 =
                                                                            value));

                                                                if ((_model
                                                                        .singleCroppedImage7
                                                                        ?.isNotEmpty ??
                                                                    false)) {
                                                                  await _savePhotoshowImage(
                                                                    6,
                                                                    _model
                                                                        .singleCroppedImage7!,
                                                                  );
                                                                }
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF00D333),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if ((currentUserDocument
                                                                  ?.photoshow
                                                                  .photo6 !=
                                                              null &&
                                                          currentUserDocument
                                                                  ?.photoshow
                                                                  .photo6 !=
                                                              '') &&
                                                      _model.editphoto)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.05, -1.04),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    8.0,
                                                                    0.0),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                photoshow:
                                                                    createUserphotoshowStruct(
                                                                  photo6: '',
                                                                  clearUnsetFields:
                                                                      false,
                                                                ),
                                                              ));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Container(
                                                              width: 23.0,
                                                              height: 23.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFFF2D38),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        4.0,
                                                                    color: Color(
                                                                        0x33000000),
                                                                    offset:
                                                                        Offset(
                                                                      0.0,
                                                                      2.0,
                                                                    ),
                                                                    spreadRadius:
                                                                        1.0,
                                                                  )
                                                                ],
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                                size: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ).animateOnPageLoad(
                              animationsMap['columnOnPageLoadAnimation']!),
                          _buildInstagramSection(),
                        ].addToEnd(SizedBox(height: 80.0)),
                      ),
                    ),
                    if (((currentUserDocument?.cheersEnd.toList() ?? [])
                                .length !=
                            (currentUserDocument?.showprofilecheers.toList() ??
                                    [])
                                .length) &&
                        ((currentUserDocument?.cheersEnd.toList() ?? [])
                                .length !=
                            0))
                      AuthUserStreamWidget(
                        builder: (context) {
                          final cheersEndList =
                              currentUserDocument?.cheersEnd.toList() ?? [];
                          final showProfileLength = (currentUserDocument
                                      ?.showprofilecheers
                                      .toList() ??
                                  [])
                              .length;
                          final nextRef =
                              cheersEndList.elementAtOrNull(showProfileLength);
                          if (nextRef == null) return SizedBox.shrink();
                          return StreamBuilder<UsersRecord>(
                            stream: UsersRecord.getDocument(nextRef),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.transparent,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final card33UserGridUsersRecord = snapshot.data!;

                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(HomePageWidget.routeName);

                                  await currentUserReference!.update({
                                    ...mapToSupabase(
                                      {
                                        'showprofilecheers':
                                            FieldValue.arrayUnion([
                                          card33UserGridUsersRecord.reference
                                        ]),
                                      },
                                    ),
                                  });
                                },
                                child: wrapWithModel(
                                  model: _model.card33UserGridModel,
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: Card33UserGridWidget(
                                    name: valueOrDefault<String>(
                                      card33UserGridUsersRecord.displayName,
                                      'ไม่ระบุ',
                                    ),
                                    image: valueOrDefault<String>(
                                      card33UserGridUsersRecord.photoUrl,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/wxo4ctrb4v72/profile.png',
                                    ),
                                    uid: card33UserGridUsersRecord.reference,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PhotoshowGalleryItem {
  const _PhotoshowGalleryItem({
    required this.url,
    required this.heroTag,
    required this.isProfile,
  });

  final String url;
  final Object heroTag;
  final bool isProfile;
}

class _PhotoshowGalleryViewer extends StatefulWidget {
  const _PhotoshowGalleryViewer({
    required this.items,
    required this.initialIndex,
  });

  final List<_PhotoshowGalleryItem> items;
  final int initialIndex;

  @override
  State<_PhotoshowGalleryViewer> createState() => _PhotoshowGalleryViewerState();
}

class _PhotoshowGalleryViewerState extends State<_PhotoshowGalleryViewer> {
  late final PageController _pageController;
  late final List<TransformationController> _transformControllers;
  late int _currentIndex;
  double _verticalDragOffset = 0.0;
  bool _isClosing = false;
  bool _isZoomed = false;
  Size _viewportSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _transformControllers = List.generate(
      widget.items.length,
      (_) => TransformationController(),
    );
    _transformControllers[_currentIndex].addListener(_updateZoomState);
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final ctrl in _transformControllers) {
      ctrl.removeListener(_updateZoomState);
      ctrl.dispose();
    }
    super.dispose();
  }

  void _updateZoomState() {
    final scale =
        _transformControllers[_currentIndex].value.getMaxScaleOnAxis();
    final isZoomed = scale > 1.05;
    if (isZoomed != _isZoomed) {
      setState(() => _isZoomed = isZoomed);
    }
  }

  void _toggleZoom(int index) {
    final ctrl = _transformControllers[index];
    final scale = ctrl.value.getMaxScaleOnAxis();
    if (scale > 1.05) {
      ctrl.value = Matrix4.identity();
    } else {
      const s = 2.5;
      final cx = _viewportSize.width / 2;
      final cy = _viewportSize.height / 2;
      // Scale around center: translate so center maps to origin, scale, translate back
      ctrl.value = Matrix4.translationValues((1 - s) * cx, (1 - s) * cy, 0)
        ..multiply(Matrix4.diagonal3Values(s, s, 1.0));
    }
  }

  void _closeViewer() {
    if (_isClosing || !mounted) {
      return;
    }
    _isClosing = true;
    Navigator.of(context).pop();
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    final nextOffset =
        (_verticalDragOffset + details.delta.dy).clamp(0.0, 400.0);
    if (nextOffset == _verticalDragOffset) {
      return;
    }
    setState(() {
      _verticalDragOffset = nextOffset;
    });
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    final shouldClose = _verticalDragOffset > 120.0 ||
        (details.primaryVelocity ?? 0.0) > 900.0;
    if (shouldClose) {
      _closeViewer();
      return;
    }
    setState(() {
      _verticalDragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    _viewportSize = Size(
      screenSize.width,
      screenSize.height - padding.top - padding.bottom,
    );
    final currentItem = widget.items[_currentIndex];
    final backgroundOpacity = (1.0 - (_verticalDragOffset / 260.0))
        .clamp(0.0, 1.0)
        .toDouble();

    return Material(
      color: Colors.black.withValues(alpha: backgroundOpacity),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black.withValues(alpha: backgroundOpacity),
              ),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0.0, _verticalDragOffset),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  // Disable swipe-to-dismiss while zoomed in
                  onVerticalDragUpdate:
                      _isZoomed ? null : _handleVerticalDragUpdate,
                  onVerticalDragEnd:
                      _isZoomed ? null : _handleVerticalDragEnd,
                  child: PageView.builder(
                    controller: _pageController,
                    // Block page swipe while zoomed so pan works correctly
                    physics: _isZoomed
                        ? const NeverScrollableScrollPhysics()
                        : const PageScrollPhysics(),
                    itemCount: widget.items.length,
                    onPageChanged: (index) {
                      // Reset zoom on the old page and start listening to new
                      _transformControllers[_currentIndex]
                          .removeListener(_updateZoomState);
                      _transformControllers[_currentIndex].value =
                          Matrix4.identity();
                      setState(() {
                        _currentIndex = index;
                        _isZoomed = false;
                      });
                      _transformControllers[index]
                          .addListener(_updateZoomState);
                    },
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final image = Image.network(
                        item.url,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/error_image.png',
                          fit: BoxFit.contain,
                        ),
                      );
                      // SizedBox.expand forces the image to fill the full
                      // InteractiveViewer so BoxFit.contain centers it properly
                      // and the zoom-to-center calculation is accurate.
                      final imageWidget = SizedBox.expand(child: image);
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _closeViewer,
                            child: const SizedBox.expand(),
                          ),
                          GestureDetector(
                            onTap: () {},
                            onDoubleTap: () => _toggleZoom(index),
                            child: InteractiveViewer(
                              transformationController:
                                  _transformControllers[index],
                              minScale: 1.0,
                              maxScale: 5.0,
                              clipBehavior: Clip.none,
                              panEnabled: _isZoomed,
                              scaleEnabled: true,
                              child: index == _currentIndex
                                  ? Hero(
                                      tag: item.heroTag,
                                      transitionOnUserGestures: true,
                                      child: imageWidget,
                                    )
                                  : imageWidget,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: currentItem.isProfile
                  ? IgnorePointer(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 7.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x99000000),
                          borderRadius: BorderRadius.circular(999.0),
                          border: Border.all(
                            color: const Color(0x55FFFFFF),
                          ),
                        ),
                        child: const Text(
                          'รูปโปรไฟล์',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: IconButton(
                onPressed: _closeViewer,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 24.0,
              child: IgnorePointer(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x88000000),
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
