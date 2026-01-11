import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.black,
          child: Center(
            child: Image.asset(
              'assets/images/Munday-logo.png',
              width: 250.0,
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'HomePage': ParameterData.none(),
  'Chats': (data) async => ParameterData(
        allParams: {
          'userProfile': getParameter<String>(data, 'userProfile'),
          'roomref': getParameter<SupabaseDocRef>(data, 'roomref'),
          'name': getParameter<String>(data, 'name'),
          'online': getParameter<bool>(data, 'online'),
          'openchat': getParameter<bool>(data, 'openchat'),
        },
      ),
  'Profile': (data) async => ParameterData(
        allParams: {
          'fromSeting': getParameter<bool>(data, 'fromSeting'),
        },
      ),
  'Authentication': (data) async => ParameterData(
        allParams: {
          'namestore': getParameter<String>(data, 'namestore'),
        },
      ),
  'home': ParameterData.none(),
  'Profile06': ParameterData.none(),
  'privacyPolicy': ParameterData.none(),
  'Support': ParameterData.none(),
  'forgetpassword': ParameterData.none(),
  'success': ParameterData.none(),
  'Blocklist': ParameterData.none(),
  'AUT': ParameterData.none(),
  'Main': ParameterData.none(),
  'Events': ParameterData.none(),
  'Venues': ParameterData.none(),
  'HomeMain': ParameterData.none(),
  'Promotion': ParameterData.none(),
  'InVenuse': (data) async => ParameterData(
        allParams: {
          'idVenues': getParameter<SupabaseDocRef>(data, 'idVenues'),
          'distance': getParameter<String>(data, 'distance'),
          'dateclick': getParameter<DateTime>(data, 'dateclick'),
          'index': getParameter<int>(data, 'index'),
        },
      ),
  'veer': ParameterData.none(),
  'bookng': ParameterData.none(),
  'ticket': ParameterData.none(),
  'Booking': (data) async => ParameterData(
        allParams: {
          'id': getParameter<SupabaseDocRef>(data, 'id'),
          'location': getParameter<LatLng>(data, 'location'),
          'date': getParameter<DateTime>(data, 'date'),
          'currentuid': getParameter<String>(data, 'currentuid'),
          'floorId': getParameter<String>(data, 'floorId'),
        },
      ),
  'mapdum': ParameterData.none(),
  'mapEx': ParameterData.none(),
  'showallphoto': (data) async => ParameterData(
        allParams: <String, dynamic>{},
      ),
  'booking2c': ParameterData.none(),
  'sharepage': (data) async => ParameterData(
        allParams: {
          'idVenues': getParameter<SupabaseDocRef>(data, 'idVenues'),
          'distance': getParameter<String>(data, 'distance'),
          'dateclick': getParameter<DateTime>(data, 'dateclick'),
          'index': getParameter<int>(data, 'index'),
        },
      ),
  'test': ParameterData.none(),
  'Booking2': ParameterData.none(),
  'homeCopy2': ParameterData.none(),
  'testui': ParameterData.none(),
  'payreservenormday': ParameterData.none(),
  'homeCopy2Copy': ParameterData.none(),
  'ticketCopy': ParameterData.none(),
  'InVenuseCopy': (data) async => ParameterData(
        allParams: {
          'idVenues': getParameter<SupabaseDocRef>(data, 'idVenues'),
          'distance': getParameter<String>(data, 'distance'),
          'dateclick': getParameter<DateTime>(data, 'dateclick'),
          'index': getParameter<int>(data, 'index'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
