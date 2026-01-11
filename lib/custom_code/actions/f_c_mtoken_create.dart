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
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_messaging/firebase_messaging.dart';
import '/app_state.dart';
import 'package:firebase_core/firebase_core.dart';

Future<String?> fCMtokenCreate() async {
  try {
    // 1. Initialize generic Firebase (if not already done in main, this is safe to call multiple times)
    // We assume default options for platform are handled by file-based config (google-services.json/GoogleService-Info.plist)
    // or generic init if available.
    // For FlutterFlow projects, usually Firebase.initializeApp() is called in main.dart.

    // 2. Request Permission
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 3. Get Token
      String? token = await messaging.getToken();

      if (token != null) {
        // 4. Update Supabase 'users' table
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          await Supabase.instance.client.from('users').update({
            'FCMtoken': token
          }).eq('uid',
              userId); // Assuming 'uid' or 'id' is the key. FirestoreShim usually maps 'uid' field in users record.
        }
        return token;
      }
    }
    return null;
  } catch (e) {
    print('FCM Error: $e');
    return null;
  }
}
