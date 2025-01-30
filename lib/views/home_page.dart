import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/main.dart';
import 'package:work_out_app/viewmodels/theme_provider.dart';
import '../config/di/injection_container.dart';
import '../widgets/progress_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, String>> _progressFuture;
  final db = sl<AppDatabase>();
  String selectedExercise = 'Push-ups';

  final List<String> exercises = [
    'Push-ups', 'Pull-ups', 'Plank', 'Abs', 'Walk/Run', 'Squats'
  ];

  @override
  void initState() {
    super.initState();
    _progressFuture = _fetchProgress();
  }

  // Fetch progress and goals for a specific exercise
  Future<Map<String, String>> _fetchProgress() async {
    final progress = await db.getProgressAndGoalForExercise(selectedExercise);
    return progress;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<String>(
            value: selectedExercise,
            isExpanded: true,
            underline: const SizedBox(),
            items: exercises.map((exercise) {
              return DropdownMenuItem(
                value: exercise,
                child: Text(exercise, style: const TextStyle(fontSize: 16)),
              );
            }).toList(),
            onChanged: (value) async {
              if (value != null) {
                setState(() {
                  selectedExercise = value;
                  _progressFuture = _fetchProgress();
                });
              }
            },
          ),
        ),
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
                  Navigator.pushReplacementNamed(context, '/Exercise', arguments: {
                    'exerciseType': selectedExercise
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.pinkColor,
                  padding: const EdgeInsets.all(80),
                ),
                child: const Text('Start', style: TextStyle(color: AppColors.blueAccentColor, fontSize: 30)),
              ),
              const SizedBox(height: 24),
              FutureBuilder<Map<String, String>>(
                future: _progressFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading progress');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No progress data available');
                  } else {
                    final progress = snapshot.data!;
                    return Column(
                      children: [
                        ProgressIndicatorWidget(label: 'Today', progress: progress['daily'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(label: 'Week', progress: progress['weekly'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(label: 'Month', progress: progress['monthly'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(label: 'Year', progress: progress['yearly'] ?? '0/0'),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
