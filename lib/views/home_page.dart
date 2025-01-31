import 'package:flutter/material.dart';
import 'package:work_out_app/components/drawer.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/repositories/progress_repository.dart';
import '../config/di/injection_container.dart';
import '../utils/data.dart';
import '../widgets/dropdown_button_widget.dart';
import '../widgets/progress_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedExercise = 'Push-ups';
  final progressRepository = sl<ProgressRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButtonWidget(
          value: selectedExercise,
          onChanged: (value) async {
            if (value != null) {
              setState(() {
                selectedExercise = value;
              });
            }
          },
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
      drawer: const SafeArea(
        child: MyDrawer()
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
                future: progressRepository.getProgressAndGoalForExercise(selectedExercise),
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
