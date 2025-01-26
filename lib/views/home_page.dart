import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/main.dart';
import 'package:work_out_app/viewmodels/theme_provider.dart';

import '../config/di/injection_container.dart';
import '../widgets/progress_indicator_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = sl<AppDatabase>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grind Counter"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.pushNamed(context, '/Goal');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/Stats');
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/Logs');
            },
          ),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
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
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Exercise');
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.pinkColor,
                  padding: const EdgeInsets.all(80),
                ),
                child: const Text('Start', style: TextStyle(color: AppColors.blueAccentColor, fontSize: 30),),
              ),
              const SizedBox(height: 24),
              const ProgressIndicatorWidget(label: 'Today', progress: '22/20'),
              const SizedBox(height: 16),
              const ProgressIndicatorWidget(label: 'Week',progress: '22/75'),
              const SizedBox(height: 16),
              const ProgressIndicatorWidget(label: 'Month',progress: '50/200'),
              const SizedBox(height: 16),
              const ProgressIndicatorWidget(label: 'Year',progress: '300/1000'),
            ],
          ),
        ),
      ),
    );
  }
}


