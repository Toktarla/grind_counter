import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:work_out_app/services/ranking_service.dart';
import '../data/data.dart';
import '../providers/theme_provider.dart';

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
            title: const Text('Set Goals'),
            onTap: () {
              Navigator.pushNamed(context, '/Goal');
            },
          ),
          ListTile(
            title: const Text('Reset Ranking Progress'),
            onTap: () {
                RankingService.resetUserLevelProgress();
                Navigator.pushNamed(context, '/Home');
            },
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
          // ListTile(
          //   title: const Text('Rate'),
          //   onTap: () async {
          //     UrlLauncher.launchUrlExternally(appUrl);
          //   },
          // ),
        ],
      ),
    );
  }
}
