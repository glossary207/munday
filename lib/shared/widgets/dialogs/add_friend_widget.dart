import '/auth/supabase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '/backend/backend.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_friend_model.dart';
import 'full_qr_widget.dart';
export 'add_friend_model.dart';

class AddFriendWidget extends StatefulWidget {
  const AddFriendWidget({super.key});

  @override
  State<AddFriendWidget> createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  late AddFriendModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddFriendModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _shareProfile(BuildContext context, {String? platform}) async {
    final myId = currentUserUid;
    final shareUrl = 'munday://addfriend?id=\$myId';
    final shareText = 'Add me on Munday! \$shareUrl';
    
    await Share.share(shareText);
  }

  void _searchAndAddFriend(BuildContext context) async {
    final phone = _model.textController?.text.trim();
    if (phone == null || phone.isEmpty) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFFE52020))),
    );

    try {
      final userQuery = await UsersRecord.collection.where('phone_number', isEqualTo: phone).get();
      Navigator.pop(context); // Hide loading

      if (userQuery.docs.isNotEmpty) {
        final friendUser = userQuery.docs.first;
        final receiverId = friendUser.reference.id;

        if (receiverId == currentUserUid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You cannot add yourself as a friend.')),
          );
          return;
        }

        // Send friend request
        await Supabase.instance.client.from('friend_request').insert({
          'sender_id': currentUserUid,
          'receiver_id': receiverId,
          'status': 'pending',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Friend request sent!')),
        );
        _model.textController?.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found with this phone number.')),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Hide loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: \$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Color(0xCC000000), Color(0xCC000000)],
          stops: [0.0, 0.4, 1.0],
          begin: AlignmentDirectional(0.0, -1.0),
          end: AlignmentDirectional(0, 1.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616), // Dark premium background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- HEADER ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add or Invite Friends',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2A2A2A),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white54,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // --- MY PROFILE & QR ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const FullQrWidget(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF222222),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: const Color(0xFF333333)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        valueOrDefault<String>(
                                          currentUserPhoto,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/teams/lkdKxh7NZs2rc2gAfQ51/assets/r0tk3qfmv01q/profile_Small.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valueOrDefault<String>(
                                          currentUserDisplayName,
                                          'My Profile',
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      const Text(
                                        'Tap to expand QR',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Icon(
                                    Icons.qr_code_2_rounded,
                                    color: Colors.black,
                                    size: 36.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),

                      // --- SHARE TO (HORIZONTAL LIST) ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Share profile via',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                fontSize: 14.0,
                                color: Colors.white70,
                              ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        height: 90.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: [
                            _buildShareIcon(
                              icon: Icons.link_rounded,
                              label: 'Copy link',
                              color: const Color(0xFF424242),
                              onTap: () async {
                                final myId = currentUserUid;
                                await Clipboard.setData(ClipboardData(text: 'munday://addfriend?id=\$myId'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Link copied to clipboard')),
                                );
                              },
                            ),
                            _buildShareIcon(
                              icon: FontAwesomeIcons.line,
                              label: 'Line',
                              color: const Color(0xFF00B900),
                              onTap: () => _shareProfile(context, platform: 'line'),
                            ),
                            _buildShareIcon(
                              icon: FontAwesomeIcons.facebookMessenger,
                              label: 'Messenger',
                              color: const Color(0xFF0084FF),
                              onTap: () => _shareProfile(context, platform: 'messenger'),
                            ),
                            _buildShareIcon(
                              icon: FontAwesomeIcons.instagram,
                              label: 'Instagram',
                              color: const Color(0xFFE1306C), // Approximate Instagram pink/red
                              onTap: () => _shareProfile(context, platform: 'instagram'),
                            ),
                            _buildShareIcon(
                              icon: FontAwesomeIcons.whatsapp,
                              label: 'WhatsApp',
                              color: const Color(0xFF25D366),
                              onTap: () => _shareProfile(context, platform: 'whatsapp'),
                            ),
                            _buildShareIcon(
                              icon: Icons.more_horiz_rounded,
                              label: 'More',
                              color: const Color(0xFF333333),
                              onTap: () => _shareProfile(context),
                            ),
                          ],
                        ),
                      ),
                      
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                        child: Divider(color: Color(0xFF333333), height: 1.0, thickness: 1.0),
                      ),

                      // --- ADD BY PHONE NUMBER ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Search by phone number',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                fontSize: 14.0,
                                color: Colors.white70,
                              ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          width: double.infinity,
                          height: 52.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 18.0, right: 12.0),
                                child: Icon(Icons.search_rounded, color: Colors.white54, size: 22.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter phone number...',
                                    hintStyle: TextStyle(color: Colors.white54, fontSize: 15.0),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: InkWell(
                                  onTap: () => _searchAndAddFriend(context),
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE52020),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20.0,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareIcon({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 26.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
