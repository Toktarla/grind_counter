import 'package:flutter/material.dart';
import '../config/app_colors.dart' show AppColors;
import '../utils/helpers/snackbar_helper.dart';
import '../widgets/dropdown_button_widget.dart';
import 'package:provider/provider.dart';
import '../providers/goal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/exercise_type_provider.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String selectedExercise = '';

  final TextEditingController dailyController = TextEditingController();
  final TextEditingController weeklyController = TextEditingController();
  final TextEditingController monthlyController = TextEditingController();
  final TextEditingController yearlyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSelectedExerciseAndGoals();
  }

  Future<void> _loadSelectedExerciseAndGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('selectedExercise');
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
    if (!mounted || validExercise.isEmpty) return;
    Provider.of<GoalProvider>(context, listen: false).loadGoals(validExercise);
  }

  @override
  void dispose() {
    dailyController.dispose();
    weeklyController.dispose();
    monthlyController.dispose();
    yearlyController.dispose();
    super.dispose();
  }

  void _updateControllers(Map<String, int> goals) {
    dailyController.text = goals['daily']?.toString() ?? '';
    weeklyController.text = goals['weekly']?.toString() ?? '';
    monthlyController.text = goals['monthly']?.toString() ?? '';
    yearlyController.text = goals['yearly']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalProvider>(
      builder: (context, goalProvider, child) {
        // Update controllers when goals change
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateControllers(goalProvider.goals);
        });
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
                  value: goalProvider.selectedExercise.isNotEmpty ? goalProvider.selectedExercise : selectedExercise,
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() {
                        selectedExercise = value;
                      });
                      // Update SharedPreferences with the new selected exercise
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('selectedExercise', value);
                      await goalProvider.loadGoals(value);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  flex: 5,
                  child: ListView(
                    children: [
                      _buildGoalCard('Daily', dailyController, goalProvider.selectedExercise.isNotEmpty ? goalProvider.selectedExercise : selectedExercise),
                      _buildGoalCard('Weekly', weeklyController, goalProvider.selectedExercise.isNotEmpty ? goalProvider.selectedExercise : selectedExercise),
                      _buildGoalCard('Monthly', monthlyController, goalProvider.selectedExercise.isNotEmpty ? goalProvider.selectedExercise : selectedExercise),
                      _buildGoalCard('Yearly', yearlyController, goalProvider.selectedExercise.isNotEmpty ? goalProvider.selectedExercise : selectedExercise),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    onPressed: () async {
                      int daily = int.tryParse(dailyController.text) ?? 0;
                      int weekly = int.tryParse(weeklyController.text) ?? 0;
                      int monthly = int.tryParse(monthlyController.text) ?? 0;
                      int yearly = int.tryParse(yearlyController.text) ?? 0;

                      final success = await goalProvider.updateGoal(daily, weekly, monthly, yearly);
                      if (success) {
                        Navigator.pushNamed(context, '/Home');
                        SnackbarHelper.showSuccessSnackbar(message: 'Goals were updated');
                      } else {
                        SnackbarHelper.showErrorSnackbar(message: 'Failed to update goals');
                      }
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
      },
    );
  }

  Widget _buildGoalCard(String period, TextEditingController controller, String exerciseName) {
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
                      period,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exerciseName,
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
  }
}
