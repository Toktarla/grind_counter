import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/utils/helpers/date_helper.dart';
import 'package:work_out_app/utils/helpers/snackbar_helper.dart';
import 'package:work_out_app/widgets/dropdown_button_widget.dart';
import '../config/di/injection_container.dart';
import '../data/data.dart';
import '../repositories/progress_repository.dart';
import '../utils/dialogs/delete_confirmation_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/exercise_type_provider.dart';
import '../widgets/empty_state_widget.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final progressRepository = sl<ProgressRepository>();
  String selectedExercise = '';

  @override
  void initState() {
    super.initState();
    _loadSelectedExercise();
  }

  Future<void> _loadSelectedExercise() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selectedExercise');
    if (!mounted) return;
    final exerciseTypes = Provider.of<ExerciseTypeProvider>(context, listen: false).exerciseTypes;
    String validExercise = '';
    if (saved != null && saved.isNotEmpty && exerciseTypes.any((e) => e.name == saved)) {
      validExercise = saved;
    } else if (exerciseTypes.isNotEmpty) {
      validExercise = exerciseTypes.first.name;
      // Update SharedPreferences to the new valid exercise
      await prefs.setString('selectedExercise', validExercise);
    }
    setState(() {
      selectedExercise = validExercise;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/Home');
          },
        ),
        title: const Text('Workout History'),
        actions: [
          IconButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return DeleteConfirmationDialog(
                    title: 'Confirm Delete',
                    actionTitle: 'Delete',
                    contentText: "Are you sure you want to delete all progress records?",
                    onDelete: () {
                      Navigator.pop(context, true);
                    },
                  );
                },
              );

              if (confirmed == true) {
                await progressRepository.deleteAllProgressRecords();
                if (context.mounted) {
                  setState(() {});
                  SnackbarHelper.showSuccessSnackbar(message: 'Progress records deleted');
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: DropdownButtonWidget(
              value: selectedExercise,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    selectedExercise = value;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('selectedExercise', value);
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ProgressData>>(
              future: progressRepository.getAllProgressRecords(selectedExercise),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading logs'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.fitness_center,
                    title: 'No workout logs available',
                  );
                }

                return GroupedLogsView(
                  logs: snapshot.data!,
                  exerciseName: selectedExercise,
                  onDataChanged: () {
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GroupedLogsView extends StatelessWidget {
  final List<ProgressData> logs;
  final String exerciseName;
  final VoidCallback onDataChanged;

  const GroupedLogsView({
    super.key,
    required this.logs,
    required this.exerciseName,
    required this.onDataChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<ProgressData>> groupedLogs = {};
    for (var log in logs) {
      String monthYear = '${log.timestamp.month}/${log.timestamp.year}';
      groupedLogs.putIfAbsent(monthYear, () => []).add(log);
    }

    final sortedKeys = groupedLogs.keys.toList();

    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, monthIndex) {
        String monthKey = sortedKeys[monthIndex];
        List<ProgressData> monthLogs = groupedLogs[monthKey]!;

        return ExpansionTile(
          initiallyExpanded: true,
          title: Text(DateHelper.formatMonthKey(monthKey)),
          children: monthLogs
              .map((log) => WorkoutLogTile(
            log: log,
            exerciseName: exerciseName,
            onDelete: onDataChanged,
          ))
              .toList(),
        );
      },
    );
  }
}


class WorkoutLogTile extends StatelessWidget {
  final ProgressData log;
  final String exerciseName;
  final VoidCallback onDelete;

  const WorkoutLogTile({
    super.key,
    required this.log,
    required this.exerciseName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.fitness_center, color: Colors.blue),
      title: Text(
        DateHelper.formatDateTime(log.timestamp),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Column(
            children: [
              Text(DateHelper.formatTime(log.duration)),
              const Text('Duration'),
            ],
          ),
          const SizedBox(width: 5),
          const Text('|', style: TextStyle(fontSize: 30, color: Colors.grey)),
          const SizedBox(width: 5),
          Column(
            children: [
              Text(log.count.toString()),
              Text(log.exerciseType),
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              final text =
                  "Hey, I did ${log.count} $exerciseName in ${log.timeElapsed} using 'Grind Counter' app. Can you beat my score? $appUrl";
              Share.share(text);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await sl<ProgressRepository>().deleteProgressRecord(log.id);
              onDelete(); // вызов обновления
            },
          ),
        ],
      ),
    );
  }
}

