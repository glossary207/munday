import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_debounce/easy_debounce.dart';

import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/shared/widgets/dialogs/edit_image_modal_widget.dart';

// ─── Data models ─────────────────────────────────────────────────────────────

class _Genre {
  final String value;
  final String label;
  final String imageUrl;
  const _Genre(this.value, this.label, this.imageUrl);
}

class _Artist {
  final String name;
  final String imageUrl;
  const _Artist(this.name, this.imageUrl);
}

// ─── Static data ─────────────────────────────────────────────────────────────

const _genres = [
  _Genre('EDM', 'EDM',
      'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=400&q=80'),
  _Genre('Rock', 'ROCK',
      'https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=400&q=80'),
  _Genre('Pop', 'POP',
      'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&q=80'),
  _Genre('Hiphop', 'HIP-HOP',
      'https://images.unsplash.com/photo-1571609826773-2571af1dec74?w=400&q=80'),
  _Genre('ThaiLife', 'เพื่อชีวิต',
      'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&q=80'),
  _Genre('Jazz', 'JAZZ',
      'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=400&q=80'),
  _Genre('Techno', 'TECHNO',
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80'),
  _Genre('Chill', 'CHILL',
      'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400&q=80'),
];

const _artists = [
  _Artist('BODYSLAM', 'https://picsum.photos/seed/bodyslam/200/200'),
  _Artist('YOUNGOHM', 'https://picsum.photos/seed/youngohm/200/200'),
  _Artist('POTATO', 'https://picsum.photos/seed/potato/200/200'),
  _Artist('PALMY', 'https://picsum.photos/seed/palmy/200/200'),
  _Artist('TILLY BIRDS', 'https://picsum.photos/seed/tillybirds/200/200'),
  _Artist('THREE MAN DOWN', 'https://picsum.photos/seed/threemandown/200/200'),
  _Artist('SKRILLEX', 'https://picsum.photos/seed/skrillex/200/200'),
  _Artist('THE WEEKND', 'https://picsum.photos/seed/weeknd/200/200'),
  _Artist('CHARLOTTE DE WITTE', 'https://picsum.photos/seed/charlotte/200/200'),
  _Artist('PEGGY GOU', 'https://picsum.photos/seed/peggygou/200/200'),
  _Artist('LOGO', 'https://picsum.photos/seed/logoband/200/200'),
  _Artist('IRK WARLITORIS', 'https://picsum.photos/seed/irk/200/200'),
  _Artist('STAMP', 'https://picsum.photos/seed/stampband/200/200'),
  _Artist('PARADOX', 'https://picsum.photos/seed/paradox/200/200'),
];

// ─── Widget ───────────────────────────────────────────────────────────────────

class WelcomeNewAccountWidget extends StatefulWidget {
  const WelcomeNewAccountWidget({super.key});

  static String routeName = 'WelcomeNewAccount';
  static String routePath = 'welcome-new-account';

  @override
  State<WelcomeNewAccountWidget> createState() =>
      _WelcomeNewAccountWidgetState();
}

class _WelcomeNewAccountWidgetState extends State<WelcomeNewAccountWidget> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Page 1 — artists
  final Set<String> _selectedArtists = {};

  // Page 2 — genres/vibe
  final Set<String> _selectedGenres = {};

  // Page 3 — profile
  final _nameController = TextEditingController();
  final _captionController = TextEditingController();
  final _igController = TextEditingController();

  String? _croppedPhotoUrl;
  bool _isUploading = false;
  bool _isSubmitting = false;
  bool _nameTouched = false;
  bool _instagramFollowersLoading = false;
  int? _instagramFollowersCount;
  int _instagramRequestToken = 0;
  String _instagramLookupInput = '';

  // Photo grid (6 slots matching photoshow.photo1–photo6)
  final List<String?> _photoUrls = List.filled(6, null);
  int? _uploadingPhotoIndex;

  @override
  void initState() {
    super.initState();
    _igController.text = FFAppState().profileInstagramHandle;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _syncInstagramFollowersForInput(_igController.text);
    });
  }

  @override
  void dispose() {
    EasyDebounce.cancel('_welcomeInstagramFollowersLookup');
    _pageController.dispose();
    _nameController.dispose();
    _captionController.dispose();
    _igController.dispose();
    super.dispose();
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
    if (_igController.text.trim().isEmpty) {
      return '';
    }
    if (_instagramFollowersLoading) {
      return '...';
    }
    if (_instagramFollowersCount == null) {
      return '-';
    }
    return formatNumber(_instagramFollowersCount, formatType: FormatType.compact);
  }

  void _goNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  bool get _nameValid {
    final v = _nameController.text.trim();
    return v.isNotEmpty && !v.endsWith('@phone.munday.app');
  }

  Future<void> _pickPhoto() async {
    final selected = await selectMedia(
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 90,
      mediaSource: MediaSource.photoGallery,
      multiImage: false,
    );
    if (selected == null || selected.isEmpty) return;
    if (!selected.every((m) => validateFileFormat(m.storagePath, context))) {
      return;
    }
    final file = FFUploadedFile(
      name: selected.first.storagePath.split('/').last,
      bytes: selected.first.bytes,
      height: selected.first.dimensions?.height,
      width: selected.first.dimensions?.width,
      blurHash: selected.first.blurHash,
      originalFilename: selected.first.originalFilename,
    );
    if (!(file.bytes?.isNotEmpty ?? false)) return;
    if (!mounted) return;
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final result = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (_) => Padding(
        padding: viewInsets,
        child: SizedBox(
          height: double.infinity,
          child: EditImageModalWidget(
            croppShape: 'square',
            cropPercentage: 0.8,
            selectedImage: file,
            direct: 0,
          ),
        ),
      ),
    );
    if (result != null && mounted) {
      setState(() => _croppedPhotoUrl = result);
      await currentUserReference!
          .update(createUsersRecordData(photoUrl: result));
    }
  }

  Future<void> _submit() async {
    setState(() => _nameTouched = true);
    if (!_nameValid) return;
    setState(() => _isSubmitting = true);
    try {
      final name = _nameController.text.trim();
      final caption = _captionController.text.trim();
      FFAppState().update(() {
        FFAppState().profileInstagramHandle = _igController.text.trim();
      });
      // Only update columns that exist in Supabase (IDIG/IDFacebook not migrated)
      await currentUserReference!.update(createUsersRecordData(
        displayName: name,
        caption: caption.isNotEmpty ? caption : null,
      ));
      FFAppState().StyleVenuse = [];
      FFAppState().StyleMusic = _selectedGenres.toList();
      if (mounted) context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('เกิดข้อผิดพลาด: $e'),
          backgroundColor: const Color(0xFF2A2A2A),
        ));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // ─── Page 1: Artist selection ─────────────────────────────────────────────

  Widget _page1() {
    final count = _selectedArtists.length;
    return Column(
      children: [
        // Header row
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'YOUR VIBE',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF888888),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '$count SELECTED',
                style: GoogleFonts.openSans(
                  color: count > 0
                      ? const Color(0xFFE53935)
                      : const Color(0xFF666666),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SELECT YOUR\nFAVOURITE ARTISTS',
                style: GoogleFonts.openSans(
                  color: const Color(0xFFE53935),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "We'll curate your nightlife feed based on the artists you love.",
                style: GoogleFonts.openSans(
                  color: const Color(0xFF888888),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: _artists.length,
            itemBuilder: (_, i) {
              final artist = _artists[i];
              final selected = _selectedArtists.contains(artist.name);
              return GestureDetector(
                onTap: () => setState(() {
                  selected
                      ? _selectedArtists.remove(artist.name)
                      : _selectedArtists.add(artist.name);
                }),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected
                              ? const Color(0xFFE53935)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Stack(
                          children: [
                            Image.network(
                              artist.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFF2A2A2A),
                                child: const Icon(Icons.person,
                                    color: Colors.white54, size: 36),
                              ),
                            ),
                            if (selected)
                              Container(
                                color: const Color(0x55E53935),
                                child: const Center(
                                  child: Icon(Icons.check_circle,
                                      color: Colors.white, size: 28),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      artist.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: _continueButton(
            label: 'CONTINUE TO DISCOVERY',
            onTap: _goNext,
          ),
        ),
        TextButton(
          onPressed: _goNext,
          child: Text(
            'SKIP FOR NOW',
            style: GoogleFonts.openSans(
              color: const Color(0xFF555555),
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  // ─── Page 2: Vibe / genre selection ──────────────────────────────────────

  Widget _page2() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Row(
            children: [
              Text(
                'THE PULSE',
                style: GoogleFonts.openSans(
                  color: const Color(0xFFE53935),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _goNext,
                child: Text(
                  'SKIP',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF666666),
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHOOSE YOUR\nVIBE',
                style: GoogleFonts.openSans(
                  color: const Color(0xFFE53935),
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select music styles you enjoy to help us find the best bars for you.',
                style: GoogleFonts.openSans(
                  color: const Color(0xFF888888),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.35,
            ),
            itemCount: _genres.length,
            itemBuilder: (_, i) {
              final g = _genres[i];
              final selected = _selectedGenres.contains(g.value);
              return GestureDetector(
                onTap: () => setState(() {
                  selected
                      ? _selectedGenres.remove(g.value)
                      : _selectedGenres.add(g.value);
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFFE53935)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background image
                        Image.network(
                          g.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: const Color(0xFF1A1A1A)),
                        ),
                        // Dark gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.35),
                                Colors.black.withValues(alpha: 0.75),
                              ],
                            ),
                          ),
                        ),
                        // Genre label
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              g.label,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black54,
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: _continueButton(
            label: 'CONTINUE TO DISCOVERY',
            onTap: _goNext,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'YOU CAN CHANGE THESE PREFERENCES LATER IN YOUR PROFILE',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              color: const Color(0xFF444444),
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  // ─── Photo slot upload helper ─────────────────────────────────────────────

  Future<void> _uploadPhoto(int index) async {
    final selected = await selectMedia(
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 90,
      mediaSource: MediaSource.photoGallery,
      multiImage: false,
    );
    if (selected == null || selected.isEmpty) return;
    if (!selected.every((m) => validateFileFormat(m.storagePath, context))) {
      return;
    }
    final file = FFUploadedFile(
      name: selected.first.storagePath.split('/').last,
      bytes: selected.first.bytes,
      height: selected.first.dimensions?.height,
      width: selected.first.dimensions?.width,
      blurHash: selected.first.blurHash,
      originalFilename: selected.first.originalFilename,
    );
    if (!(file.bytes?.isNotEmpty ?? false)) return;
    if (!mounted) return;
    setState(() => _uploadingPhotoIndex = index);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final result = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (_) => Padding(
        padding: viewInsets,
        child: SizedBox(
          height: double.infinity,
          child: EditImageModalWidget(
            croppShape: 'square',
            cropPercentage: 0.8,
            selectedImage: file,
            direct: 0,
          ),
        ),
      ),
    );
    if (!mounted) return;
    setState(() => _uploadingPhotoIndex = null);
    if (result == null) return;

    setState(() => _photoUrls[index] = result);
    // Map index → photoshow field name
    final photoKey = 'photo${index + 1}';
    await currentUserReference!.update(createUsersRecordData(
      photoshow: createUserphotoshowStruct(
        photo1: index == 0 ? result : null,
        photo2: index == 1 ? result : null,
        photo3: index == 2 ? result : null,
        photo4: index == 3 ? result : null,
        photo5: index == 4 ? result : null,
        photo6: index == 5 ? result : null,
        clearUnsetFields: false,
      ),
    ));
    debugPrint('Saved $photoKey');
  }

  Future<void> _clearPhoto(int index) async {
    setState(() => _photoUrls[index] = null);
    await currentUserReference!.update(createUsersRecordData(
      photoshow: createUserphotoshowStruct(
        photo1: index == 0 ? '' : null,
        photo2: index == 1 ? '' : null,
        photo3: index == 2 ? '' : null,
        photo4: index == 3 ? '' : null,
        photo5: index == 4 ? '' : null,
        photo6: index == 5 ? '' : null,
        clearUnsetFields: false,
      ),
    ));
  }

  Widget _photoSlot(int index) {
    final url = _photoUrls[index];
    final isEmpty = url == null || url.isEmpty;
    final isLoading = _uploadingPhotoIndex == index;

    return Stack(
      children: [
        // Background placeholder
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF111111),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/usv8wtdkx6c9/%E0%B8%9C%E0%B8%B7%E0%B9%89%E0%B8%99%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%87%E0%B9%80%E0%B8%AA%E0%B9%89%E0%B8%99%E0%B8%9B%E0%B8%A3%E0%B8%B0.png',
              ),
            ),
          ),
        ),
        // Photo if exists
        if (!isEmpty)
          Positioned.fill(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
        // Action button: "+" or "×"
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: isLoading
                ? null
                : () => isEmpty ? _uploadPhoto(index) : _clearPhoto(index),
            child: Container(
              width: 23,
              height: 23,
              decoration: BoxDecoration(
                color: isLoading
                    ? Colors.grey
                    : isEmpty
                        ? const Color(0xFF00D333)
                        : const Color(0xFFFF2D38),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(4),
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : Icon(
                      isEmpty ? Icons.add : Icons.close,
                      color: Colors.white,
                      size: isEmpty ? 20 : 18,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Page 3: Profile setup (matches profilepopup layout) ─────────────────

  Widget _page3() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR PROFILE',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF666666),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'SET UP YOUR\nPROFILE',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFE53935),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'ตั้งโปรไฟล์ของคุณก่อนเริ่มใช้งาน\nคนอื่นจะเห็นการ์ดของคุณแบบนี้',
                  style: GoogleFonts.openSans(
                    color: const Color(0xFF888888),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      'PREVIEW',
                      style: GoogleFonts.openSans(
                        color: const Color(0xFF444444),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child:
                          Container(height: 1, color: const Color(0xFF1E1E1E)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // ── Top card: avatar + name + caption (#131313, rounded top) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 115,
              decoration: const BoxDecoration(
                color: Color(0xFF131313),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
              child: Row(
                children: [
                  // Avatar with edit button
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: _isUploading ? null : _pickPhoto,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2A2A2A),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  (_croppedPhotoUrl?.isNotEmpty ?? false)
                                      ? _croppedPhotoUrl!
                                      : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: _isUploading ? null : _pickPhoto,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFF171717),
                                shape: BoxShape.circle,
                              ),
                              child: _isUploading
                                  ? const Padding(
                                      padding: EdgeInsets.all(6),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(FontAwesomeIcons.pen,
                                      color: Colors.white, size: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Name + caption fields
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          child: TextField(
                            controller: _nameController,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Your name',
                              hintStyle: GoogleFonts.openSans(
                                color: Colors.white54,
                                fontSize: 23,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.only(bottom: 8),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF383838), width: 1.3),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF383838), width: 1.3),
                              ),
                              errorText: (_nameTouched && !_nameValid)
                                  ? 'กรุณากรอกชื่อ'
                                  : null,
                              errorStyle: GoogleFonts.openSans(
                                  color: const Color(0xFFE53935), fontSize: 10),
                            ),
                            onChanged: (_) => setState(() {
                              _nameTouched = true;
                            }),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 35,
                          child: TextField(
                            controller: _captionController,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Your caption',
                              hintStyle: GoogleFonts.openSans(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.only(bottom: 10),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF383838), width: 1.3),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF383838), width: 1.3),
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

          // ── Bottom card: photo grid 3×2 (#0E0E0E, rounded bottom) ─────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 255,
              decoration: const BoxDecoration(
                color: Color(0xFF0E0E0E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: SizedBox(
                height: 243,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.5,
                  mainAxisSpacing: 1.5,
                  children: List.generate(6, _photoSlot),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ── Instagram field ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1D1D1D), width: 2),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FaIcon(FontAwesomeIcons.instagram,
                        color: Colors.white, size: 25),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: TextField(
                        controller: _igController,
                        onChanged: (_) {
                          FFAppState().update(() {
                            FFAppState().profileInstagramHandle =
                                _igController.text.trim();
                          });
                          EasyDebounce.debounce(
                            '_welcomeInstagramFollowersLookup',
                            const Duration(milliseconds: 500),
                            () => _syncInstagramFollowersForInput(
                              _igController.text,
                            ),
                          );
                        },
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Name Instagram',
                          hintStyle: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 16),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _igController.clear();
                      _instagramLookupInput = '';
                      _instagramFollowersLoading = false;
                      _instagramFollowersCount = null;
                      FFAppState().profileInstagramHandle = '';
                    }),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                  if (_instagramFollowersText().isNotEmpty)
                    Container(
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
                            padding: const EdgeInsets.only(left: 15.0, right: 7.0),
                            child: Text(
                              _instagramFollowersText(),
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
                ],
              ),
            ),
          ),

          // ── Save button ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'บันทึก โปรไฟล์',
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ─── Shared helpers ───────────────────────────────────────────────────────

  Widget _continueButton({
    required String label,
    VoidCallback? onTap,
    bool loading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          disabledBackgroundColor:
              const Color(0xFFE53935).withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                label,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
      ),
    );
  }

  // ─── Progress dots ────────────────────────────────────────────────────────

  Widget _progressBar() {
    return Row(
      children: List.generate(3, (i) {
        final active = i == _currentPage;
        final done = i < _currentPage;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: active || done
                  ? const Color(0xFFE53935)
                  : const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: _goBack,
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white54, size: 18),
                    )
                  else
                    const SizedBox(width: 18),
                  const Spacer(),
                  SizedBox(
                    width: 160,
                    child: _progressBar(),
                  ),
                  const Spacer(),
                  const SizedBox(width: 18),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _page1(),
                  _page2(),
                  _page3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
