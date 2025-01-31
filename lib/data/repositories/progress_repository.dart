import 'package:work_out_app/data/local/app_database.dart';

class ProgressRepository {
  final AppDatabase appDatabase;

  const ProgressRepository(this.appDatabase);

  Future<Map<String, String>> getProgressAndGoalForExercise(String exerciseType) async {
    return await appDatabase.getProgressAndGoalForExercise(exerciseType);
  }

  Future<void> addExerciseProgress(String exerciseType, int count, int duration) async {
    await appDatabase.addExerciseProgress(exerciseType, count, duration);
  }

  Future<List<ProgressData>> getAllProgressRecords(String exerciseType) async {
    return await appDatabase.getAllProgressRecords(exerciseType);
  }

  Future<void> deleteProgressRecord(int id) async {
    await appDatabase.deleteProgressRecord(id);
  }

  Future<int> getExerciseProgress(String exerciseType, DateTime day) async {
    return await appDatabase.getExerciseProgress(exerciseType, day);
  }
}