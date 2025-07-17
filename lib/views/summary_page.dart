import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/widgets/detail_card_widget.dart';
import '../config/di/injection_container.dart';
import '../repositories/progress_repository.dart';
import '../utils/helpers/date_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/progress_indicator_widget.dart';

class SummaryPage extends StatefulWidget {
  final String workout;
  final String date;
  final int counter;
  final String timeElapsed;

  const SummaryPage({
    super.key,
    required this.workout,
    required this.date,
    required this.counter,
    required this.timeElapsed,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final progressRepository = sl<ProgressRepository>();
  final prefs = sl<SharedPreferences>();
  late int savedCount;

  @override
  void initState() {
    super.initState();
    savedCount = prefs.getInt('today_workout_count') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workout Summary'),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/Home');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                final workoutsToday = prefs.getInt('today_workout_count') ?? 0;
                final message =
                    "I did $workoutsToday workouts today using the 'Grinder' app 💪🔥. Can you beat that?";
                Share.share(message);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final allRecords = await progressRepository
                    .getAllProgressRecords(widget.workout);

                // Фильтруем только сегодняшние записи
                final today = DateTime.now();
                final todayLogs = allRecords
                    .where((log) =>
                log.timestamp.year == today.year &&
                    log.timestamp.month == today.month &&
                    log.timestamp.day == today.day)
                    .toList();

                if (todayLogs.isNotEmpty) {
                  // Удаляем самую последнюю
                  final lastLog = todayLogs.first;
                  await progressRepository.deleteProgressRecord(lastLog.id);

                  // Обновим локальное значение, если хочешь (необязательно)
                  int count = prefs.getInt('today_workout_count') ?? 1;
                  prefs.setInt('today_workout_count', count > 0 ? count - 1 : 0);

                  if (context.mounted) {
                    Navigator.pushNamed(context, '/Home');
                    SnackbarHelper.showSnackbar(
                        message: "Current workout progress was deleted");
                  }
                } else {
                  SnackbarHelper.showSnackbar(message: "No workout to delete");
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workout #$savedCount for Today',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                DateHelper.formatDate(widget.date),
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailCard(
                      width: 140,
                      height: 140,
                      icon: Icons.fitness_center_sharp,
                      integerValue: widget.counter.toString(),
                      label: widget.workout,
                      color: Colors.blue),
                  DetailCard(
                      width: 140,
                      height: 140,
                      icon: Icons.local_fire_department_rounded,
                      integerValue: widget.timeElapsed,
                      label: 'Duration',
                      color: Colors.orange),
                ],
              ),
              const SizedBox(height: 24),
              FutureBuilder<Map<String, String>>(
                future: progressRepository
                    .getProgressAndGoalForExercise(widget.workout),
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
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Home');
                      },
                      child: Text('Finish', style: Theme.of(context).textTheme.titleLarge,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
