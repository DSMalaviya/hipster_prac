import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/data/models/meeting_creation_model.dart';
import 'package:hipster_prac/modules/meeting/widgets/incoming_meeting_dialog.dart';

class FirebaseAppService extends GetxService {
  String _deviceToken = "";

  requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true, // Required to display a heads up notification
            badge: true,
            sound: true,
          );
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      _fetchDeviceTokenAndListen();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      _fetchDeviceTokenAndListen();
    } else {
      log('User declined or has not accepted permission');
    }
  }

  _fetchDeviceTokenAndListen() async {
    if (Platform.isIOS) {
      //return as of now for ios as APNS is not setup
      return;
      await FirebaseMessaging.instance.getAPNSToken();
    }
    _deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
    log("Device token is $_deviceToken");
    _addNotificationOpenListener();
    _addNotificationListener();
  }

  Future<void> initialAppOpenCallHandler() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      //handled call screen
      _showMeetingStartDialog(initialMessage);
    }
  }

  void _addNotificationOpenListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification clicked");
      //handled call screen
      _showMeetingStartDialog(message);
    });
  }

  void _addNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Notification received");
      //handled call screen
      //show dialog
      _showMeetingStartDialog(message);
    });
  }

  void _showMeetingStartDialog(RemoteMessage message) {
    MeetingDetails meetingDetails = MeetingDetails.fromJson(
      jsonDecode(message.data['data']),
    );
    showIncomingMeetingDialog(meetingDetails);
  }

  String get deviceToken => _deviceToken;
}
