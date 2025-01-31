import 'package:flutter/material.dart';
import 'package:work_out_app/data/local/app_database.dart';

class WorkoutTrackerWidget extends StatefulWidget {
  final AppDatabase database;

  const WorkoutTrackerWidget({super.key, required this.database});

  @override
  State<WorkoutTrackerWidget> createState() => _WorkoutTrackerWidgetState();
}

class _WorkoutTrackerWidgetState extends State<WorkoutTrackerWidget> {
  final List<String> _exerciseTypes = [
    'Pull-ups', 'Push-ups', 'Plank', 'Abs', 'Walk/Run', 'Squats'
  ];

  String _selectedExercise = 'Pull-ups';

  final TextEditingController _dailyGoalController = TextEditingController();
  final TextEditingController _weeklyGoalController = TextEditingController();
  final TextEditingController _monthlyGoalController = TextEditingController();
  final TextEditingController _yearlyGoalController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();

  Future<void> _printGoals() async {
    final goals = await widget.database.getGoalsForExercise(_selectedExercise);
    debugPrint('Goals for $_selectedExercise: $goals');
  }

  Future<void> _printProgress() async {
    final progress = await widget.database.getExerciseProgress(_selectedExercise, DateTime.now());
    debugPrint("Today's progress for $_selectedExercise: $progress");
  }

  Future<void> _getAllGoals() async {
    final progress = await widget.database.getAllGoals();
    debugPrint("Today's progress for $progress");
  }

  Future<void> _printAllProgressRecords() async {
    final progressRecords = await widget.database.getAllProgressRecords(_selectedExercise);
    debugPrint("All progress records for $_selectedExercise:");
    for (var record in progressRecords) {
      debugPrint(record.toString());
    }
  }

  Future<void> _updateGoals() async {
    await widget.database.updateGoal(
      _selectedExercise,
      int.parse(_dailyGoalController.text),
      int.parse(_weeklyGoalController.text),
      int.parse(_monthlyGoalController.text),
      int.parse(_yearlyGoalController.text),
    );
    debugPrint("Goals updated for $_selectedExercise");
  }

  Future<void> _addProgress() async {
    final count = int.tryParse(_progressController.text) ?? 0;
    await widget.database.addExerciseProgress(_selectedExercise, count, 0);
    debugPrint("Added $count progress to $_selectedExercise");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workout Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Exercise", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedExercise,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedExercise = value!;
                });
              },
              items: _exerciseTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
            ),
            const SizedBox(height: 20),

            const Text("Set Goals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _goalInput("Daily Goal", _dailyGoalController),
            _goalInput("Weekly Goal", _weeklyGoalController),
            _goalInput("Monthly Goal", _monthlyGoalController),
            _goalInput("Yearly Goal", _yearlyGoalController),
            const SizedBox(height: 10),

            ElevatedButton(onPressed: _updateGoals, child: const Text("Update Goals")),

            const SizedBox(height: 20),
            _goalInput("Add Progress", _progressController),
            ElevatedButton(onPressed: _addProgress, child: const Text("Add Progress")),

            const SizedBox(height: 20),
            ElevatedButton(onPressed: _printGoals, child: const Text("Print Goals")),
            ElevatedButton(onPressed: _printProgress, child: const Text("Print Progress")),
            ElevatedButton(onPressed: _getAllGoals, child: const Text("All Goals")),
            ElevatedButton(onPressed: _printAllProgressRecords, child: const Text("Print All Progress Records")),
          ],
        ),
      ),
    );
  }

  Widget _goalInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
