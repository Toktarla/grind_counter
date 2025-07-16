import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/variables.dart';
import '../../config/app_colors.dart';
import '../../providers/theme_provider.dart';
import '../../utils/helpers/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Provider.of<ThemeProvider>(context).currentTheme.brightness == Brightness.light ? Colors.black : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grind Counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
            Text('Version: 1.0.0 (starting version)', style: TextStyle(color: textColor)),
            Text('Build: 1', style: TextStyle(color: textColor)),

            const SizedBox(height: 16),
            Text(
              'Developer Info:',
              style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
            ),
            Text('Toktarla', style: TextStyle(fontSize: 16, color: textColor)),

            const SizedBox(height: 16),
            Text(
              'Links:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
            ),
            InkWell(
              onTap: () async {
                  UrlLauncher.launchUrlInBrowser(githubUrl);
              },
              child: const Text(
                'Github Profile',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20),
              ),
            ),
            InkWell(
              onTap: () async {
                UrlLauncher.launchUrlInBrowser("Privacy_Url_Here");
              },
              child: const Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 20),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'We would love hearing from you. Send your feedback:',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 2,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.pinkColor,
                    elevation: 0,
                    shape: const LinearBorder(),
                  ),
                  onPressed: () async {
                    UrlLauncher.launchEmailUrl();
                  },
                  child: const Text(
                    'Send Feedback',
                    style: TextStyle(
                      color: AppColors.blueAccentColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
