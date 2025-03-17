import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out_app/utils/helpers/token_updater.dart';
import '../../config/variables.dart';
import 'local_notification_service.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseMessagingService {
  final FirebaseMessaging firebaseMessaging;

  FirebaseMessagingService(this.firebaseMessaging);


  void initialize() {
    _requestPermission();
    _updateTokenOnRefresh();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
  }

  Future<NotificationSettings> _requestPermission() async {
    return await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void _updateTokenOnRefresh() {
    firebaseMessaging.onTokenRefresh.listen((String? fcmToken) async {
      print("TOKEN $fcmToken");
      TokenUpdater.updateToken(fcmToken);
    }, onError: (error) {
      print('Error getting token: $error');
    });
  }

  void messageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.display(message);

      print('Got a message in the foreground!');
      if (message.notification != null) {
        print(message.notification!.title);
        LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage msg) async {
      LocalNotificationService.display(msg);

      try {
        if (msg.notification != null) {
          LocalNotificationService.display(msg);
        }
      } catch (e) {
        print("ERROR FirebaseMessaging.onBackgroundMessage ${e}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.display(message);

      if (message.notification != null) {
        print(message.notification!.title);
        LocalNotificationService.display(message);
      }
    });
  }

  Future<void> sendPushNotification(String token, String body, String title) async {
    try {
      final jsonCredentials = await rootBundle.loadString(pathToFirebaseAdminSdk!);
      final creds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);
      final client = await auth.clientViaServiceAccount(
        creds,
        ['https://www.googleapis.com/auth/cloud-platform'],
      );
      final notificationData = {
        "message": {
          "token": token,
          "data": {
            "title": title,
            "body": body,
          },
          "notification": <String, dynamic> {"title": title, "body": body},
          "android": {},
        }
      };
      final response = await client.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$senderId/messages:send'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode(notificationData),
      );

      client.close();
      if (response.statusCode == 200) {
        print("SUCCESS ON FCM REQUEST");
      }
    } catch(e) {
      print("Error sending Push Notification ${e}");
    }
  }

}