import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/config/app_colors.dart';
import '../config/di/injection_container.dart';
import '../repositories/progress_repository.dart';
import '../services/ranking_service.dart';
import '../utils/helpers/date_helper.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseType;

  const ExercisePage({super.key, required this.exerciseType});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int counter = 0;
  bool isStarted = true;
  late Timer _timer;
  int _seconds = 0;
  bool playSound = false;
  final progressRepository = sl<ProgressRepository>();
  final prefs = sl<SharedPreferences>();

  late final AudioPlayer _audioPlayer; // Audio player instance

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // initialize audio player
    _loadSettings();
    _startTimer();
  }

  Future<void> _loadSettings() async {
    final prefs = sl<SharedPreferences>();
    setState(() {
      playSound = prefs.getBool('playSound') ?? false;
    });
  }

  Future<void> _fetchWorkoutCount() async {
    final progress = await progressRepository.getExerciseProgress(widget.exerciseType, DateTime.now());
    int savedCount = prefs.getInt('today_workout_count') ?? 0;
    if (progress > 0) {
      savedCount++;
      await prefs.setInt('today_workout_count', savedCount);
    } else {
      await prefs.setInt('today_workout_count', 1);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('sounds/click.wav'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isStarted) {
                setState(() {
                  counter++;
                });

                if (playSound) {
                  _playSound();
                }
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateHelper.formatTime(_seconds),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      '$counter',
                      style: const TextStyle(fontSize: 150, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      const Text(
                        'Tap anywhere on the screen or lean toward the device to do an exercise. When done press \'Stop\'',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 15,
                        width: MediaQuery.sizeOf(context).width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.blueAccentColor,
                          ),
                          onPressed: () async {
                            _timer.cancel();
                            await _fetchWorkoutCount();
                            await sl<ProgressRepository>().addExerciseProgress(
                              widget.exerciseType,
                              counter,
                              _seconds,
                              DateHelper.formatTime(_seconds),
                            );

                            await RankingService.addProgress(counter);

                            if (counter == 0) {
                              Navigator.pushReplacementNamed(context, '/Home');
                            } else {
                              Navigator.pushNamed(context, '/Summary', arguments: {
                                'workout': widget.exerciseType,
                                'date': DateTime.now().toString(),
                                'counter': counter,
                                'timeElapsed': DateHelper.formatTime(_seconds),
                              });
                            }
                          },
                          child: const Text(
                            'Stop',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
