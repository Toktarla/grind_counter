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
  AppDatabase() : super(LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  })) {
    _initializeGoals();
  }

  @override
  int get schemaVersion => 1;

  Future<void> _initializeGoals() async {
    final existingGoals = await select(goals).get();
    if (existingGoals.isEmpty) {
      const exerciseTypes = [
        'Pull-ups',
        'Push-ups',
        'Plank',
        'Abs',
        'Walk/Run',
        'Squats'
      ];
      for (final type in exerciseTypes) {
        await into(goals).insert(
          GoalsCompanion.insert(
            exerciseType: type,
            dailyGoal: const Value(0),
            weeklyGoal: const Value(0),
            monthlyGoal: const Value(0),
            yearlyGoal: const Value(0),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    }
  }

  // Fetch goals for a specific exercise
  Future<Map<String, int>> getGoalsForExercise(String exerciseType) async {
    final goal = await (select(goals)
      ..where((tbl) => tbl.exerciseType.equals(exerciseType)))
        .getSingleOrNull();

    if (goal == null) {
      return {'daily': 0, 'weekly': 0, 'monthly': 0, 'yearly': 0};
    }

    return {
      'daily': goal.dailyGoal,
      'weekly': goal.weeklyGoal,
      'monthly': goal.monthlyGoal,
      'yearly': goal.yearlyGoal,
    };
  }

  // Fetch all goals
  Future<List<Goal>> getAllGoals() async {
    return await select(goals).get();
  }

  // Update existing goal values
  Future<void> updateGoal(String exerciseType, int daily, int weekly, int monthly, int yearly) async {
    await (update(goals)
      ..where((tbl) => tbl.exerciseType.equals(exerciseType)))
        .write(GoalsCompanion(
      dailyGoal: Value(daily),
      weeklyGoal: Value(weekly),
      monthlyGoal: Value(monthly),
      yearlyGoal: Value(yearly),
    ));
  }

  // Add exercise progress for the current day
  Future<void> addExerciseProgress(String exerciseType, int count, int duration) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    // Check if progress already exists for today
    final existingProgress = await (select(progress)
      ..where((tbl) =>
      tbl.exerciseType.equals(exerciseType) & tbl.timestamp.equals(startOfDay)))
        .getSingleOrNull();

    if (existingProgress != null) {
      // Update existing progress for the day
      await (update(progress)
        ..where((tbl) => tbl.exerciseType.equals(exerciseType) & tbl.timestamp.equals(startOfDay)))
          .write(ProgressCompanion(
        count: Value(existingProgress.count + count),
        duration: Value(existingProgress.duration + duration),
      ));
    } else {
      // Insert new progress for the day
      await into(progress).insert(
        ProgressCompanion.insert(
          exerciseType: exerciseType,
          count: count,
          duration: duration,
          timestamp: startOfDay,
        ),
      );
    }
  }

  // Reset progress after a specific time period
  Future<void> _resetProgress() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    // Reset daily progress to 0 at the start of the new day
    await (update(progress)
      ..where((tbl) => tbl.timestamp.equals(startOfDay)))
        .write(ProgressCompanion(
      count: const Value(0),
      duration: const Value(0),
    ));

    // Reset weekly progress after 7 days
    if (now.difference(startOfWeek).inDays >= 7) {
      await (update(progress)
        ..where((tbl) => tbl.timestamp.equals(startOfWeek)))
          .write(ProgressCompanion(
        count: const Value(0),
        duration: const Value(0),
      ));
    }

    // Reset monthly progress after 30 days
    if (now.difference(startOfMonth).inDays >= 30) {
      await (update(progress)
        ..where((tbl) => tbl.timestamp.equals(startOfMonth)))
          .write(ProgressCompanion(
        count: const Value(0),
        duration: const Value(0),
      ));
    }

    // Reset yearly progress after 365 days
    if (now.difference(startOfYear).inDays >= 365) {
      await (update(progress)
        ..where((tbl) => tbl.timestamp.equals(startOfYear)))
          .write(ProgressCompanion(
        count: const Value(0),
        duration: const Value(0),
      ));
    }
  }

  // Fetch all progress records (history page)
  Future<List<ProgressData>> getAllProgressRecords(String exerciseType) async {
    return (select(progress)
      ..where((tbl) => tbl.exerciseType.equals(exerciseType))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.timestamp, mode: OrderingMode.desc)]))
        .get();
  }

  // Delete a specific progress record
  Future<void> deleteProgressRecord(int id) async {
    await (delete(progress)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Fetch progress for a specific day (used for statistics)
  Future<int> getExerciseProgress(String exerciseType, DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);

    final progressData = await (select(progress)
      ..where((tbl) =>
      tbl.exerciseType.equals(exerciseType) & tbl.timestamp.isBiggerOrEqualValue(startOfDay)))
        .get();

    int totalProgress = 0;
    for (var record in progressData) {
      totalProgress += record.count ?? 0; // Ensure null safety
    }

    return totalProgress;
  }


  Future<Map<String, String>> getProgressAndGoalForExercise(String exerciseType) async {
    final now = DateTime.now();

    // Calculate start times for each period
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    // Get progress for each timeframe
    final dailyProgress = await getExerciseProgress(exerciseType, startOfDay);
    final weeklyProgress = await getExerciseProgress(exerciseType, startOfWeek);
    final monthlyProgress = await getExerciseProgress(exerciseType, startOfMonth);
    final yearlyProgress = await getExerciseProgress(exerciseType, startOfYear);

    // Get goals for the exercise
    final goals = await getGoalsForExercise(exerciseType);

    return {
      'daily': '$dailyProgress/${goals['daily'] ?? 0}',
      'weekly': '$weeklyProgress/${goals['weekly'] ?? 0}',
      'monthly': '$monthlyProgress/${goals['monthly'] ?? 0}',
      'yearly': '$yearlyProgress/${goals['yearly'] ?? 0}',
    };
  }
}
