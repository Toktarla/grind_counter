import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../config/variables.dart';

class LocalNotificationService {

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'daily_motivation_channel',
      'Word Of The Day',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher'
  );

  static void initialize() async {
    tzdata.initializeTimeZones();
    const InitializationSettings initializationSettingsAndroid = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher")
    );

    await _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {
          print("onDidReceiveNotificationResponse, ${details.input} !!! ${details}");
        }
      },
    );
    final bool? granted = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled();
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
          android: androidNotificationDetails
      );
      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['route']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> scheduleDailyMotivationalMessage({int hour = 15, int minute = 0}) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_notification_channel',
      'Let\'s grind!',
      icon: "@mipmap/ic_launcher", // Replace with your launcher icon
      channelDescription: 'Get notified to grind',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    // Get a random message and title
    final random = tz.TZDateTime.now(tz.local).millisecond % notificationMessages.length;
    final message = notificationMessages[random];
    final title = notificationTitles[random];

    final scheduledTime = _nextInstanceOfTime(hour, minute);
    print("Scheduled time for notification: $scheduledTime");

    await _notificationsPlugin.zonedSchedule(
      0,
      title, // Use the random title
      message, // Use the random message
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print("Notification scheduled successfully.");
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

}