import 'package:flutter/material.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/data/repositories/progress_repository.dart';
import 'package:work_out_app/utils/data.dart';
import 'package:work_out_app/utils/helpers/date_helper.dart';
import 'package:work_out_app/widgets/dropdown_button_widget.dart';
import '../config/app_colors.dart';
import '../config/di/injection_container.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final progressRepository = sl<ProgressRepository>();
  String selectedExercise = 'Push-ups';

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
            onPressed: () {
              progressRepository.deleteAllProgressRecords();
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
                  return const Center(child: Text('No workout logs available'));
                } else {
                  List<ProgressData> logs = snapshot.data!;

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
                        initiallyExpanded: true,
                        title: Text(DateHelper.formatMonthKey(monthKey)),
                        children: monthLogs.map((log) {
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
                                    Text(log.timeElapsed),
                                    const Text('Duration'),
                                  ],
                                ),
                                const SizedBox(width: 5,),
                                const Text('|',style:  TextStyle(fontSize: 30, color: Colors.grey),),
                                const SizedBox(width: 5,),
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
                                    // Add share functionality
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    progressRepository.deleteProgressRecord(log.id);
                                    setState(() {}); // Refresh the UI
                                  },
                                ),
                              ],
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
}