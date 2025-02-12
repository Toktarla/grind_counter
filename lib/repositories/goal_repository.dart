import 'package:work_out_app/data/local/app_database.dart';

class GoalRepository {
  final AppDatabase appDatabase;

  const GoalRepository(this.appDatabase);

  Future<Map<String, int>> getGoalsForExercise(String exerciseType) async {
    return await appDatabase.getGoalsForExercise(exerciseType);
  }

  Future<List<Goal>> getAllGoals() async {
    return await appDatabase.getAllGoals();
  }

  Future<void> updateGoal(String exerciseType, int daily, int weekly, int monthly, int yearly) async {
    await appDatabase.updateGoal(exerciseType, daily, weekly, monthly, yearly);
  }
}