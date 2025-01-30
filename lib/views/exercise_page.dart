import 'dart:async';
import 'package:flutter/material.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/local/app_database.dart';

import '../config/di/injection_container.dart';

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
  final db = sl<AppDatabase>();
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _addProgress() async {
    await db.addExerciseProgress(widget.exerciseType, counter, int.tryParse(_formatTime(_seconds)) ?? 0);
  }


  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (isStarted) {
              setState(() {
                counter++;
              });
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _formatTime(_seconds),
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
                        onPressed: () {
                          _timer.cancel();
                          _addProgress();

                          if (counter == 0) {
                            Navigator.pushReplacementNamed(context, '/Home');
                          } else {
                            Navigator.pushNamed(context, '/Summary', arguments: {
                              'workout': 'Push-Ups',
                              'date': DateTime.now().toString(),
                              'counter': counter,
                              'timeElapsed': _formatTime(_seconds),
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
    );
  }
}