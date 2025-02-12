import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/data.dart';
import '../viewmodels/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Provider.of<ThemeProvider>(context).currentTheme.brightness == Brightness.light
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/Settings');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Remove Ads'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Send Feedback'),
            onTap: () {
              Navigator.pushNamed(context, '/Feedback');
            },
          ),
          ListTile(
            title: const Text('Share'),
            onTap: () {
              Share.share(appLink);
            },
          ),
          ListTile(
            title: const Text('Rate'),
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(appUrl))) {
              await launchUrl(Uri.parse(appUrl), mode: LaunchMode.externalApplication);
              } else {
              debugPrint("Could not launch $appUrl");
              }
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, '/About');
            },
          ),
        ],
      ),
    );
  }
}
