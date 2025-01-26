import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/config/di/injection_container.dart';

import '../config/app_colors.dart' show AppColors;
import '../data/local/app_database.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final List<String> exercises = [
    'Pull-ups',
    'Push-ups',
    'Plank',
    'Abs',
    'Walk/Run',
    'Squats'
  ];

  String selectedExercise = 'Pull-ups';

  final appDatabase = sl<AppDatabase>();
  final goalControllers = {};
  final Map<String, Map<String, bool>> goalStatus = {};
  final Map<String, Map<String, int>> goalValues = {
    'Pull-ups': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
    'Push-ups': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
    'Plank': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
    'Abs': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
    'Walk/Run': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
    'Squats': {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0},
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    for (var exercise in exercises) {
      goalControllers[exercise] = {
        'daily': TextEditingController(text: prefs.getString('$exercise-daily')),
        'weekly': TextEditingController(text: prefs.getString('$exercise-weekly')),
        'monthly': TextEditingController(text: prefs.getString('$exercise-monthly')),
        'yearly': TextEditingController(text: prefs.getString('$exercise-yearly')),
      };
      goalStatus[exercise] = {
        'daily': prefs.getBool('$exercise-daily-status') ?? true,
        'weekly': prefs.getBool('$exercise-weekly-status') ?? true,
        'monthly': prefs.getBool('$exercise-monthly-status') ?? true,
        'yearly': prefs.getBool('$exercise-yearly-status') ?? true,
      };
    }
    setState(() {});
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    for (var exercise in exercises) {
      prefs.setBool('$exercise-daily-status', goalStatus[exercise]?['daily'] ?? true);
      prefs.setBool('$exercise-weekly-status', goalStatus[exercise]?['weekly'] ?? true);
      prefs.setBool('$exercise-monthly-status', goalStatus[exercise]?['monthly'] ?? true);
      prefs.setBool('$exercise-yearly-status', goalStatus[exercise]?['yearly'] ?? true);
    }
  }

  Future<void> _saveGoalsToDatabase() async {
    for (var exercise in exercises) {
      await appDatabase.createOrUpdateGoal(
        exercise,
        goalValues[exercise]?['daily'] ?? 0,
        goalValues[exercise]?['weekly'] ?? 0,
        goalValues[exercise]?['monthly'] ?? 0,
        goalValues[exercise]?['yearly'] ?? 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exercise',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
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
                onChanged: (value) {
                  setState(() {
                    selectedExercise = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: ListView(
                children: ['daily', 'weekly', 'monthly', 'yearly'].map((period) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      color: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${period[0].toUpperCase()}${period.substring(1)}',
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    selectedExercise,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: goalStatus[selectedExercise]?[period] ?? true,
                              onChanged: (value) {
                                setState(() {
                                  goalStatus[selectedExercise]?[period] = value;
                                });
                              },
                            ),
                            const SizedBox(width: 12),
                            if (goalStatus[selectedExercise]?[period] ?? false)
                              SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: goalControllers[selectedExercise][period],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      goalValues[selectedExercise]?[period] = int.tryParse(value) ?? 0;
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.pinkColor,
                        elevation: 0,
                        shape: const LinearBorder()
                    ),
                    onPressed: () async {
                      await _savePreferences();
                      await _saveGoalsToDatabase();
                    },
                    child: const Text('Save Goal', style: TextStyle(
                        color: AppColors.blueAccentColor, fontSize: 20
                    ),)
                )),
          ],
        ),
      ),
    );
  }
}

