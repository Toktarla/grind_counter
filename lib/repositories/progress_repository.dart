import 'package:work_out_app/data/local/app_database.dart';

class ProgressRepository {
  final AppDatabase appDatabase;

  const ProgressRepository(this.appDatabase);

  Future<Map<String, String>> getProgressAndGoalForExercise(String exerciseType) async {
    return await appDatabase.getProgressAndGoalForExercise(exerciseType);
  }

  Future<void> addExerciseProgress(String exerciseType, int count, int duration, String timeElapsed) async {
    await appDatabase.addExerciseProgress(exerciseType, count, duration, timeElapsed);
  }

  Future<List<ProgressData>> getAllProgressRecords(String exerciseType) async {
    return await appDatabase.getAllProgressRecords(exerciseType);
  }

  Future<void> deleteProgressRecord(int id) async {
    await appDatabase.deleteProgressRecord(id);
  }

  Future<void> deleteAllProgressRecords() async {
    await appDatabase.deleteAllProgressRecords();
  }

  Future<int> getExerciseProgress(String exerciseType, DateTime day) async {
    return await appDatabase.getExerciseProgress(exerciseType, day);
  }
}