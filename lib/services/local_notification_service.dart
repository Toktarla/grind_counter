import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../data/data.dart';

class LocalNotificationService {

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static const androidDetails = AndroidNotificationDetails(
      'daily_notification_channel',
      'Let\'s grind!',
      icon: "@mipmap/launcher_icon", // Replace with your launcher icon
      channelDescription: 'Get notified to grind',
      importance: Importance.high,
      priority: Priority.high,
    );

  static void initialize() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const InitializationSettings initializationSettingsAndroid = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/launcher_icon")
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
    print("Notifications Granted: $granted");
  }

  static Future<void> scheduleDailyMotivationalMessage({int hour = 15, int minute = 0}) async {

    const notificationDetails = NotificationDetails(android: androidDetails);

    final random = tz.TZDateTime.now(tz.local).millisecond % notificationMessages.length;
    final message = notificationMessages[random];
    final title = notificationTitles[random];

    final scheduledTime = _nextInstanceOfTime(hour, minute);
    print("Scheduling notification for: $scheduledTime");

    await _notificationsPlugin.zonedSchedule(
      0,
      title,
      message,
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
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