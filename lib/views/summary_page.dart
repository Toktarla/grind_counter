import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For better icons
import 'package:intl/intl.dart';
import 'package:work_out_app/widgets/detail_card_widget.dart';

import '../widgets/progress_indicator_widget.dart';

class SummaryPage extends StatelessWidget {
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

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('MMMM dd, yyyy, hh:mm a').format(parsedDate);
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
              'Workout #$counter for Today',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              formatDate(date),
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
                    integerValue: counter.toString(),
                    label: workout,
                    color: Colors.blue),
                DetailCard(
                    width: 140,
                    height: 140,
                    icon: FontAwesomeIcons.fire,
                    integerValue: timeElapsed,
                    label: 'Duration',
                    color: Colors.orange
                ),
              ],
            ),

            const SizedBox(height: 24),
            const ProgressIndicatorWidget(label: 'Today', progress: '22/20'),
            const SizedBox(height: 16),
            const ProgressIndicatorWidget(label: 'Week',progress: '22/75'),
            const SizedBox(height: 16),
            const ProgressIndicatorWidget(label: 'Month',progress: '50/200'),
            const SizedBox(height: 16),
            const ProgressIndicatorWidget(label: 'Year',progress: '300/1000'),
          ],
        ),
      ),
    );
  }
}
