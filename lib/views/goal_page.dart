import 'package:flutter/material.dart';
import 'package:work_out_app/config/di/injection_container.dart';
import '../config/app_colors.dart' show AppColors;
import '../repositories/goal_repository.dart';
import '../utils/data.dart';
import '../widgets/dropdown_button_widget.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {

  String selectedExercise = 'Push-ups';
  final goalRepository = sl<GoalRepository>();

  final TextEditingController dailyController = TextEditingController();
  final TextEditingController weeklyController = TextEditingController();
  final TextEditingController monthlyController = TextEditingController();
  final TextEditingController yearlyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGoalsForExercise(selectedExercise);
  }

  @override
  void dispose() {
    dailyController.dispose();
    weeklyController.dispose();
    monthlyController.dispose();
    yearlyController.dispose();
    super.dispose();
  }

  Future<void> _loadGoalsForExercise(String exercise) async {
    final goals = await goalRepository.getGoalsForExercise(exercise);
    setState(() {
      dailyController.text = goals['daily'].toString();
      weeklyController.text = goals['weekly'].toString();
      monthlyController.text = goals['monthly'].toString();
      yearlyController.text = goals['yearly'].toString();
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exercise',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButtonWidget(
              value: selectedExercise,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    selectedExercise = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: ListView(
                children: ['daily', 'weekly', 'monthly', 'yearly'].map((period) {
                  TextEditingController controller;
                  switch (period) {
                    case 'daily':
                      controller = dailyController;
                      break;
                    case 'weekly':
                      controller = weeklyController;
                      break;
                    case 'monthly':
                      controller = monthlyController;
                      break;
                    case 'yearly':
                      controller = yearlyController;
                      break;
                    default:
                      controller = TextEditingController();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
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
                            SizedBox(
                              width: 80,
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
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
                  shape: const LinearBorder(),
                ),
                onPressed: () async {
                  int daily = int.tryParse(dailyController.text) ?? 0;
                  int weekly = int.tryParse(weeklyController.text) ?? 0;
                  int monthly = int.tryParse(monthlyController.text) ?? 0;
                  int yearly = int.tryParse(yearlyController.text) ?? 0;

                  await goalRepository.updateGoal(selectedExercise, daily, weekly, monthly, yearly);
                },
                child: const Text(
                  'Save Goal',
                  style: TextStyle(
                    color: AppColors.blueAccentColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
