import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:work_out_app/data/local/schemes/goals.dart';
import 'package:work_out_app/data/local/schemes/progress.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Goals, Progress])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Fetch all goals
  Future<List<Goal>> getAllGoals() async {
    return await select(goals).get();
  }

  // Fetch progress for a specific exercise within a date range
  Future<int> getProgress(String exerciseType, DateTime start, DateTime end) async {
    final query = select(progress)
      ..where((tbl) =>
      tbl.exerciseType.equals(exerciseType) &
      tbl.timestamp.isBetweenValues(start, end));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, row) => sum + row.count);
  }

  Future<Map<String, int>> getGoalsForExercise(String exerciseType) async {
    final goal = await (select(goals)
      ..where((tbl) => tbl.exerciseType.equals(exerciseType)))
        .getSingle();

    return {
      'daily': goal.dailyGoal,
      'weekly': goal.weeklyGoal,
      'monthly': goal.monthlyGoal,
      'yearly': goal.yearlyGoal,
    };
  }

  Future<void> addExerciseProgress(String exerciseType, int count, int duration) async {
    final progressCompanion = ProgressCompanion(
      exerciseType: Value(exerciseType),
      count: Value(count),
      duration: Value(duration),
      timestamp: Value(DateTime.now()),
    );

    await into(progress).insert(progressCompanion);
  }

  Future<int> getExerciseProgress(String exerciseType, DateTime start, DateTime end) async {
    final query = select(progress)
      ..where((tbl) =>
      tbl.exerciseType.equals(exerciseType) &
      tbl.timestamp.isBetweenValues(start, end));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, row) => sum + row.count);
  }

  Future<Map<String, String>> getProgressAndGoalForExercise(AppDatabase db, String exerciseType) async {
    final now = DateTime.now();

    // Calculate start times for each period
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    // Get progress for each timeframe
    final dailyProgress = await db.getExerciseProgress(exerciseType, startOfDay, now);
    final weeklyProgress = await db.getExerciseProgress(exerciseType, startOfWeek, now);
    final monthlyProgress = await db.getExerciseProgress(exerciseType, startOfMonth, now);
    final yearlyProgress = await db.getExerciseProgress(exerciseType, startOfYear, now);

    // Get goals for the exercise
    final goals = await db.getGoalsForExercise(exerciseType);

    // Format progress and goals
    return {
      'daily': '$dailyProgress/${goals['daily']}',
      'weekly': '$weeklyProgress/${goals['weekly']}',
      'monthly': '$monthlyProgress/${goals['monthly']}',
      'yearly': '$yearlyProgress/${goals['yearly']}',
    };
  }

  Future<void> createOrUpdateGoal(String exerciseType, int dailyGoal, int weeklyGoal, int monthlyGoal, int yearlyGoal) async {
    final goalCompanion = GoalsCompanion(
      exerciseType: Value(exerciseType),
      dailyGoal: Value(dailyGoal),
      weeklyGoal: Value(weeklyGoal),
      monthlyGoal: Value(monthlyGoal),
      yearlyGoal: Value(yearlyGoal),
    );

    await into(goals).insertOnConflictUpdate(goalCompanion);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
