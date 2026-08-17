import 'dart:io' show Platform;

import '/backend/supabase/supabase_shim.dart';

import 'serialization_util.dart';
import '../../auth/supabase_auth/auth_util.dart';

import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

export 'push_notifications_handler.dart';
export 'serialization_util.dart';

const kUserPushNotificationsCollectionName = 'ff_user_push_notifications';

class UserTokenInfo {
  const UserTokenInfo(this.userPath, this.fcmToken);
  final String userPath;
  final String fcmToken;
}

Future<String?> _waitForApnsToken(FirebaseMessaging messaging) async {
  // APNs registration completes asynchronously after permission is granted.
  // Calling getToken() before this value exists throws apns-token-not-set.
  for (var attempt = 0; attempt < 20; attempt++) {
    final token = await messaging.getAPNSToken();
    if (token != null && token.isNotEmpty) return token;
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return null;
}

Stream<UserTokenInfo> getFcmTokenStream(String userPath) async* {
  if (kIsWeb || (!Platform.isIOS && !Platform.isAndroid)) return;

  final messaging = FirebaseMessaging.instance;

  try {
    final settings = await messaging.requestPermission();
    final permissionGranted =
        settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!permissionGranted) return;

    String? initialToken;
    if (Platform.isIOS) {
      final apnsToken = await _waitForApnsToken(messaging);
      if (apnsToken == null) {
        debugPrint(
          'APNs token was not available after waiting; skipping initial FCM token.',
        );
      } else {
        initialToken = await messaging.getToken();
      }
    } else {
      initialToken = await messaging.getToken();
    }

    if (initialToken != null && initialToken.isNotEmpty) {
      yield UserTokenInfo(userPath, initialToken);
    }

    await for (final refreshedToken in messaging.onTokenRefresh) {
      if (refreshedToken.isNotEmpty) {
        yield UserTokenInfo(userPath, refreshedToken);
      }
    }
  } on FirebaseException catch (error, stackTrace) {
    debugPrint(
      'Unable to register for push notifications (${error.code}): '
      '${error.message}\n$stackTrace',
    );
  } catch (error, stackTrace) {
    debugPrint(
      'Unable to register for push notifications: $error\n$stackTrace',
    );
  }
}

final fcmTokenUserStream = authenticatedUserStream
    .where((user) => user != null)
    .map((user) => user!.reference.path)
    .distinct()
    .switchMap(getFcmTokenStream)
    .map((userTokenInfo) async {
      final uid = currentUserReference?.id;
      if (uid != null) {
        try {
          await Supabase.instance.client
              .from('users')
              .update({'FCMtoken': userTokenInfo.fcmToken})
              .eq('id', uid);
        } catch (e) {
          debugPrint('Failed to save FCM token: $e');
        }
      }
    });

void triggerPushNotification({
  required String? notificationTitle,
  required String? notificationText,
  String? notificationImageUrl,
  DateTime? scheduledTime,
  String? notificationSound,
  required List<SupabaseDocRef> userRefs,
  required String initialPageName,
  required Map<String, dynamic> parameterData,
}) {
  if ((notificationTitle ?? '').isEmpty || (notificationText ?? '').isEmpty) {
    return;
  }
  final serializedParameterData = serializeParameterData(parameterData);
  final pushNotificationData = {
    'notification_title': notificationTitle,
    'notification_text': notificationText,
    if (notificationImageUrl != null)
      'notification_image_url': notificationImageUrl,
    if (scheduledTime != null) 'scheduled_time': scheduledTime,
    if (notificationSound != null) 'notification_sound': notificationSound,
    'user_refs': userRefs.map((u) => u.path).join(','),
    'initial_page_name': initialPageName,
    'parameter_data': serializedParameterData,
    'sender': currentUserReference,
    'timestamp': DateTime.now(),
  };
  SupabaseFirestore.instance
      .collection(kUserPushNotificationsCollectionName)
      .doc()
      .set(pushNotificationData);
}
