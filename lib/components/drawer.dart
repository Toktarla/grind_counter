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
    final isLight = Provider.of<ThemeProvider>(context).currentTheme.brightness == Brightness.light;

    final List<_DrawerItem> drawerItems = [
      _DrawerItem(
        icon: isLight ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        title: 'Theme',
        onTap: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
      ),
      _DrawerItem(
        icon: Icons.settings,
        title: 'Settings',
        onTap: () => Navigator.pushNamed(context, '/Settings'),
      ),
      _DrawerItem(
        icon: Icons.access_time_outlined,
        title: 'Set Goals',
        onTap: () => Navigator.pushNamed(context, '/Goal'),
      ),
      _DrawerItem(
        icon: Icons.lock_reset,
        title: 'Reset Ranking Progress',
        onTap: () {
          RankingService.resetUserLevelProgress();
          Navigator.pushNamed(context, '/Home');
        },
      ),
      _DrawerItem(
        icon: Icons.feedback,
        title: 'Send Feedback',
        onTap: () => Navigator.pushNamed(context, '/Feedback'),
      ),
      _DrawerItem(
        icon: Icons.share,
        title: 'Share',
        onTap: () => Share.share(appLink),
      ),
    ];

    final Map<IconData, Color> lightIconColors = {
      Icons.light_mode_outlined: Colors.orange,
      Icons.dark_mode_outlined: Colors.orange,
      Icons.settings: Colors.blue,
      Icons.access_time_outlined: Colors.green,
      Icons.lock_reset: Colors.redAccent,
      Icons.feedback: Colors.deepPurple,
      Icons.share: Colors.teal,
    };

    final Map<IconData, Color> darkIconColors = {
      Icons.light_mode_outlined: Colors.deepOrangeAccent,
      Icons.dark_mode_outlined: Colors.yellowAccent,
      Icons.settings: Colors.lightBlueAccent,
      Icons.access_time_outlined: Colors.lightGreenAccent,
      Icons.lock_reset: Colors.red,
      Icons.feedback: Colors.purpleAccent,
      Icons.share: Colors.cyanAccent,
    };

    return Drawer(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (_, index) => index == 1 ? const Divider() : const SizedBox(height: 0),
        itemCount: drawerItems.length,
        itemBuilder: (_, index) {
          final item = drawerItems[index];
          final colorMap = isLight ? lightIconColors : darkIconColors;
          final iconColor = colorMap[item.icon] ?? Colors.grey;

          return ListTile(
            leading: Icon(item.icon, color: iconColor),
            title: Text(
              item.title,
              style: TextStyle(color: isLight ? Colors.black : Colors.white),
            ),
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}

class _DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
