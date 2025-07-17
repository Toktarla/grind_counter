import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/config/app_colors.dart';
import '../components/drawer.dart';
import '../config/di/injection_container.dart';
import '../models/level_data.dart';
import '../providers/exercise_type_provider.dart';
import '../repositories/progress_repository.dart';
import '../services/ranking_service.dart';
import '../utils/painters/regular_hexagon_painter.dart';
import '../widgets/dropdown_button_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/progress_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedExercise = '';
  final progressRepository = sl<ProgressRepository>();
  int _userLevel = 1;
  late LevelData levelData;
  double _levelProgress = 0.0;
  late LevelData nextLevelData;

  @override
  void initState() {
    super.initState();
    _loadLevel();
    levelData = RankingService.getLevelData(_userLevel);
    nextLevelData = RankingService.getLevelData(_userLevel + 1);
    _loadProgress();
  }

  Future<void> _saveSelectedExercise(String exercise) async {
    final prefs = sl<SharedPreferences>();
    await prefs.setString('selectedExercise', exercise);
  }

  Future<void> _loadLevel() async {
    _userLevel = await RankingService.getCurrentUserLevel();
    setState(() {
      levelData = RankingService.getLevelData(_userLevel);
      nextLevelData = RankingService.getLevelData(_userLevel + 1);
    });
  }

  Future<void> _loadProgress() async {
    _levelProgress = await RankingService.getUserLevelProgress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseTypeProvider>(
      builder: (context, provider, child) {
        final types = provider.exerciseTypes;
        if (types.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // Always load the last selected exercise from SharedPreferences if available and valid
        _syncSelectedExerciseWithPrefs(types);
        return Scaffold(
          appBar: AppBar(
            title: DropdownButtonWidget(
              value: selectedExercise,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    selectedExercise = value;
                  });
                  await _saveSelectedExercise(value);
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
                icon: const Icon(Icons.bar_chart_sharp, color: Colors.orange),
                onPressed: () {
                  Navigator.pushNamed(context, '/Stats');
                },
              ),
              IconButton(
                icon: const Icon(Icons.library_books_outlined, color: Colors.green),
                onPressed: () {
                  Navigator.pushNamed(context, '/Logs');
                },
              ),
              IconButton(
                icon: const Icon(Icons.fitness_center, color: Colors.blue),
                onPressed: () {
                  Navigator.pushNamed(context, '/ManageExerciseTypes');
                },
              ),
            ],
          ),
          drawer: const SafeArea(child: MyDrawer()),
          body: SingleChildScrollView(
            child: Center(
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
                            Text("LVL: $_userLevel", style: const TextStyle(color: Colors.black)),
                            Text("LVL: ${_userLevel + 1}", style: const TextStyle(color: Colors.black)),
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
                          return const EmptyStateWidget(
                            icon: Icons.accessibility_rounded,
                            title: 'No progress data available',
                          );
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
          ),
        );
      },
    );
  }

  Future<void> _syncSelectedExerciseWithPrefs(List types) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selectedExercise');
    if (saved != null && saved.isNotEmpty && types.any((e) => e.name == saved)) {
      if (selectedExercise != saved) {
        setState(() {
          selectedExercise = saved;
        });
      }
    } else if (types.isNotEmpty && (selectedExercise.isEmpty || !types.any((e) => e.name == selectedExercise))) {
      setState(() {
        selectedExercise = types.first.name;
      });
      // Update SharedPreferences to the new valid exercise
      await prefs.setString('selectedExercise', types.first.name);
    }
  }
}
