import 'package:shared_preferences/shared_preferences.dart';
import '../../config/di/injection_container.dart';

class TokenUpdater {
  static const String _fcmTokenKey = 'fcmToken';

  static Future<void> updateToken(String? fcmToken) async {

      try {
        if (fcmToken != null) {
          SharedPreferences prefs = sl<SharedPreferences>();
          await prefs.setString(_fcmTokenKey, fcmToken);
          print('FCM Token stored successfully in Shared Preferences');
        } else {
          SharedPreferences prefs = sl<SharedPreferences>();
          await prefs.remove(_fcmTokenKey);
          print('FCM Token removed from Shared Preferences');
        }
      } catch (error) {
        print('Error updating FCM Token: $error');
      }
  }

  static Future<String?> getStoredToken() async {
    SharedPreferences prefs = sl<SharedPreferences>();
    return prefs.getString(_fcmTokenKey);
  }

  static Future<void> removeStoredToken() async{
    SharedPreferences prefs = sl<SharedPreferences>();
    await prefs.remove(_fcmTokenKey);
  }
}