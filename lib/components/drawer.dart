import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            onTap: () {},
          ),
          ListTile(
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Rate'),
            onTap: () {},
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
