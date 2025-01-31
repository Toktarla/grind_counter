import 'package:flutter/material.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/utils/data.dart';
import '../config/di/injection_container.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final db = sl<AppDatabase>();
  late Future<List<ProgressData>> _workoutLogsFuture;
  String? selectedExerciseType = 'Push-ups';

  @override
  void initState() {
    super.initState();
    selectedExerciseType = exercises[0];
    _workoutLogsFuture = _fetchWorkoutLogs();
  }

  Future<List<ProgressData>> _fetchWorkoutLogs() async {
    return await db.getAllProgressRecords(selectedExerciseType!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
        actions: [
          IconButton(onPressed: () {

          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedExerciseType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedExerciseType = newValue;
                  _workoutLogsFuture = _fetchWorkoutLogs(); // Re-fetch logs when exercise type changes
                });
              },
              items: exercises.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ProgressData>>(
              future: _workoutLogsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading logs'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No workout logs available'));
                } else {
                  List<ProgressData> logs = snapshot.data!;

                  // Group logs by month
                  Map<String, List<ProgressData>> groupedLogs = {};
                  for (var log in logs) {
                    String monthYear = '${log.timestamp.month}/${log.timestamp.year}';
                    if (!groupedLogs.containsKey(monthYear)) {
                      groupedLogs[monthYear] = [];
                    }
                    groupedLogs[monthYear]!.add(log);
                  }

                  return ListView.builder(
                    itemCount: groupedLogs.length,
                    itemBuilder: (context, monthIndex) {
                      String monthKey = groupedLogs.keys.toList()[monthIndex];
                      List<ProgressData> monthLogs = groupedLogs[monthKey]!;

                      return ExpansionTile(
                        title: Text(monthKey),
                        children: monthLogs.map((log) {
                          return ListTile(
                            title: Text('${log.timestamp.month} ${log.timestamp.day}, ${log.timestamp.year}, ${log.timestamp}'),
                            subtitle: Text('Exercise: ${log.exerciseType}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete action
                                _deleteLog(log.id);
                              },
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to handle deleting a log
  void _deleteLog(int logId) {
    setState(() {
      db.deleteProgressRecord(logId); // Replace with your actual database delete logic
    });
  }
}

// Assuming you have a WorkoutLog model
class WorkoutLog {
  final int id;
  final DateTime date;
  final String exerciseType;
  final String time; // Duration or time for the workout

  WorkoutLog({
    required this.id,
    required this.date,
    required this.exerciseType,
    required this.time,
  });
}
