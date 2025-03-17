import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchUrlInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<void> launchUrlExternally(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  static Future<void> launchEmailUrl() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'email@gmail.com',
      queryParameters: {
        'subject': 'Feedback from App',
        'body': 'Write your feedback here...'
      },
    );

    launchUrlExternally(emailUri.toString());
  }
}
