import 'package:flutter/material.dart';
import '../repositories/goal_repository.dart';
import '../config/di/injection_container.dart';

class GoalProvider extends ChangeNotifier {
  final GoalRepository _goalRepository = sl<GoalRepository>();

  Map<String, int> _goals = {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0};
  String _selectedExercise = '';

  Map<String, int> get goals => _goals;
  String get selectedExercise => _selectedExercise;

  Future<void> loadGoals(String exercise) async {
    _selectedExercise = exercise;
    _goals = await _goalRepository.getGoalsForExercise(exercise);
    notifyListeners();
  }

  Future<bool> updateGoal(int daily, int weekly, int monthly, int yearly) async {
    final success = await _goalRepository.updateGoal(_selectedExercise, daily, weekly, monthly, yearly);
    if (success) {
      await loadGoals(_selectedExercise);
    }
    return success;
  }
} 