import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/config/app_colors.dart';
import '../components/drawer.dart';
import '../config/di/injection_container.dart';
import '../models/level_data.dart';
import '../repositories/progress_repository.dart';
import '../services/ranking_service.dart';
import '../utils/helpers/date_helper.dart';
import '../utils/painters/regular_hexagon_painter.dart';
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
  int _userLevel = 1;
  late LevelData levelData;
  double _levelProgress = 0.0; // Added level progress
  late LevelData _nextLevelData;

  @override
  void initState() {
    super.initState();
    _loadLevel();
    levelData = RankingService.getLevelData(_userLevel);
    _nextLevelData = RankingService.getLevelData(_userLevel + 1);
    _loadProgress(); // Load progress on init
  }

  Future<void> _loadLevel() async {
    _userLevel = await RankingService.getCurrentUserLevel();
    setState(() {
      levelData = RankingService.getLevelData(_userLevel);
      _nextLevelData = RankingService.getLevelData(_userLevel + 1);
    });
  }

  Future<void> _loadProgress() async {
    _levelProgress = await RankingService.getUserLevelProgress();
    setState(() {});
  }

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
            icon: const Icon(Icons.gamepad),
            onPressed: () {
              Navigator.pushNamed(context, '/Game');
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
      drawer: const SafeArea(child: MyDrawer()),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: _levelProgress,
                    minHeight: 15,
                    backgroundColor: levelData.color.withValues(alpha: 0.55),
                    valueColor: AlwaysStoppedAnimation<Color>(levelData.color),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("LVL: $_userLevel", style: TextStyle(color: Colors.black)),
                      Text("LVL: ${_userLevel + 1}", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomPaint(
                painter: NearRegularHexagonPainter(levelData.color),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "RANK",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          _userLevel.toString(),
                          style: const TextStyle(fontSize: 36, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                levelData.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Exercise',
                      arguments: {'exerciseType': selectedExercise});
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.pinkColor,
                  padding: const EdgeInsets.all(80),
                ),
                child: const Text('Start',
                    style: TextStyle(
                        color: AppColors.blueAccentColor, fontSize: 30)),
              ),
              const SizedBox(height: 24),
              FutureBuilder<Map<String, String>>(
                future: progressRepository
                    .getProgressAndGoalForExercise(selectedExercise),
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
                        ProgressIndicatorWidget(
                            label: 'Today', progress: progress['daily'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(
                            label: 'Week', progress: progress['weekly'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(
                            label: 'Month',
                            progress: progress['monthly'] ?? '0/0'),
                        const SizedBox(height: 16),
                        ProgressIndicatorWidget(
                            label: 'Year', progress: progress['yearly'] ?? '0/0'),
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
