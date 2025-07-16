import 'package:flutter/material.dart';
import '../data/local/app_database.dart';
import '../config/di/injection_container.dart';

class ExerciseTypeProvider extends ChangeNotifier {
  final AppDatabase db = sl<AppDatabase>();
  List<ExerciseType> _exerciseTypes = [];

  List<ExerciseType> get exerciseTypes => _exerciseTypes;

  ExerciseTypeProvider() {
    loadExerciseTypes();
  }

  Future<void> loadExerciseTypes() async {
    _exerciseTypes = await db.getAllExerciseTypes();
    notifyListeners();
  }

  Future<void> addExerciseType(String newName, String icon) async {
    await db.addExerciseType(newName, icon);
    await loadExerciseTypes();
  }

  Future<void> editExerciseType(int typeId, String newName, String icon) async {
    await db.updateExerciseType(typeId, newName, icon);
    await loadExerciseTypes();
  }

  Future<void> deleteExerciseType(int id) async {
    await db.deleteExerciseType(id);
    await loadExerciseTypes();
  }
}