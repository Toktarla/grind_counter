import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/widgets/detail_card_widget.dart';
import '../config/di/injection_container.dart';
import '../repositories/progress_repository.dart';
import '../utils/helpers/date_helper.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Summary'),
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
              // Share logic
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete logic
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
                    icon: FontAwesomeIcons.dumbbell,
                    integerValue: widget.counter.toString(),
                    label: widget.workout,
                    color: Colors.blue),
                DetailCard(
                    width: 140,
                    height: 140,
                    icon: FontAwesomeIcons.fire,
                    integerValue: widget.timeElapsed,
                    label: 'Duration',
                    color: Colors.orange
                ),
              ],
            ),

            const SizedBox(height: 24),
            FutureBuilder<Map<String, String>>(
              future: progressRepository.getProgressAndGoalForExercise(widget.workout),
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
                      ProgressIndicatorWidget(label: 'Today', progress: progress['daily'] ?? '0/0'),
                      const SizedBox(height: 16),
                      ProgressIndicatorWidget(label: 'Week', progress: progress['weekly'] ?? '0/0'),
                      const SizedBox(height: 16),
                      ProgressIndicatorWidget(label: 'Month', progress: progress['monthly'] ?? '0/0'),
                      const SizedBox(height: 16),
                      ProgressIndicatorWidget(label: 'Year', progress: progress['yearly'] ?? '0/0'),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
