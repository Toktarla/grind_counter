import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:work_out_app/data/local/schemes/goals.dart';
import 'package:work_out_app/data/local/schemes/progress.dart';
import 'package:work_out_app/data/local/schemes/exercise_types.dart';

import '../data.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [Goals, Progress, ExerciseTypes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(LazyDatabase(() async {
          final dbFolder = await getApplicationDocumentsDirectory();
          final file = File(p.join(dbFolder.path, 'db.sqlite'));
          return NativeDatabase(file);
        })) {
    _initializeGoals();
    _initializeExerciseTypes();
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.createTable(exerciseTypes);
          }
        },
      );

  @override
  int get schemaVersion => 2;

  Future<void> _initializeGoals() async {
    final existingGoals = await select(goals).get();
    if (existingGoals.isEmpty) {
      for (final type in exercises) {
        await into(goals).insert(
          GoalsCompanion.insert(
            exerciseType: type,
            dailyGoal: const Value(10),
            weeklyGoal: const Value(50),
            monthlyGoal: const Value(1500),
            yearlyGoal: const Value(15000),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      }
    }
  }

  Future<void> _initializeExerciseTypes() async {
    final existingTypes = await select(exerciseTypes).get();
    if (existingTypes.isEmpty) {
      final defaults = [
        {'name': 'Pull-ups', 'icon': 'pull_up', 'isDefault': true},
        {'name': 'Push-ups', 'icon': 'push_up', 'isDefault': true},
        {'name': 'Abs', 'icon': 'abs', 'isDefault': true},
        {'name': 'Squats', 'icon': 'squat', 'isDefault': true},
      ];
      for (final ex in defaults) {
        await into(exerciseTypes).insert(
          ExerciseTypesCompanion.insert(
            name: ex['name'] as String,
            icon: ex['icon'] as String,
            isDefault: Value(ex['isDefault'] as bool),
          ),
        );
      }
    }
  }

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

  Future<List<Goal>> getAllGoals() async {
    return await select(goals).get();
  }

  Future<void> updateGoal(String exerciseType, int daily, int weekly,
      int monthly, int yearly) async {
    await (update(goals)..where((tbl) => tbl.exerciseType.equals(exerciseType)))
        .write(GoalsCompanion(
      dailyGoal: Value(daily),
      weeklyGoal: Value(weekly),
      monthlyGoal: Value(monthly),
      yearlyGoal: Value(yearly),
    ));
  }

  Future<void> addExerciseProgress(
      String exerciseType, int count, int duration, String timeElapsed) async {
    final now = DateTime.now();

    final existingProgress = await (select(progress)
          ..where((tbl) =>
              tbl.exerciseType.equals(exerciseType) &
              tbl.timestamp.equals(now)))
        .getSingleOrNull();

    if (existingProgress != null) {
      await (update(progress)
            ..where((tbl) =>
                tbl.exerciseType.equals(exerciseType) &
                tbl.timestamp.equals(now)))
          .write(ProgressCompanion(
              count: Value(existingProgress.count + count),
              duration: Value(existingProgress.duration + duration),
              timeElapsed: Value(timeElapsed),
              tries: Value(existingProgress.tries + 1)));
    } else {
      await into(progress).insert(
        ProgressCompanion.insert(
            exerciseType: exerciseType,
            count: count,
            duration: duration,
            timestamp: now,
            timeElapsed: timeElapsed,
            tries: const Value(1) // Initialize tries to 1
            ),
      );
    }
  }

  Future<void> _resetProgress() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    await (update(progress)..where((tbl) => tbl.timestamp.equals(startOfDay)))
        .write(const ProgressCompanion(
      count: Value(0),
      duration: Value(0),
    ));

    if (now.difference(startOfWeek).inDays >= 7) {
      await (update(progress)
            ..where((tbl) => tbl.timestamp.equals(startOfWeek)))
          .write(const ProgressCompanion(
        count: Value(0),
        duration: Value(0),
      ));
    }

    if (now.difference(startOfMonth).inDays >= 30) {
      await (update(progress)
            ..where((tbl) => tbl.timestamp.equals(startOfMonth)))
          .write(const ProgressCompanion(
        count: Value(0),
        duration: Value(0),
      ));
    }

    if (now.difference(startOfYear).inDays >= 365) {
      await (update(progress)
            ..where((tbl) => tbl.timestamp.equals(startOfYear)))
          .write(const ProgressCompanion(
        count: Value(0),
        duration: Value(0),
      ));
    }
  }

  Future<List<ProgressData>> getAllProgressRecords(String exerciseType) async {
    return (select(progress)
          ..where((tbl) => tbl.exerciseType.equals(exerciseType))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.timestamp, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<void> deleteProgressRecord(int id) async {
    await (delete(progress)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> deleteAllProgressRecords() async {
    await delete(progress).go();
  }

  Future<int> getExerciseProgress(String exerciseType, DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);

    final progressData = await (select(progress)
          ..where((tbl) =>
              tbl.exerciseType.equals(exerciseType) &
              tbl.timestamp.isBiggerOrEqualValue(startOfDay)))
        .get();

    int totalProgress = 0;
    for (var record in progressData) {
      totalProgress += record.count;
    }

    return totalProgress;
  }

  Future<Map<String, String>> getProgressAndGoalForExercise(
      String exerciseType) async {
    final now = DateTime.now();

    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek =
        DateTime(now.year, now.month, now.day - now.weekday + 1);
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfYear = DateTime(now.year, 1, 1);

    final dailyProgress = await getExerciseProgress(exerciseType, startOfDay);
    final weeklyProgress = await getExerciseProgress(exerciseType, startOfWeek);
    final monthlyProgress =
        await getExerciseProgress(exerciseType, startOfMonth);
    final yearlyProgress = await getExerciseProgress(exerciseType, startOfYear);

    final goals = await getGoalsForExercise(exerciseType);

    return {
      'daily': '$dailyProgress/${goals['daily'] ?? 0}',
      'weekly': '$weeklyProgress/${goals['weekly'] ?? 0}',
      'monthly': '$monthlyProgress/${goals['monthly'] ?? 0}',
      'yearly': '$yearlyProgress/${goals['yearly'] ?? 0}',
    };
  }

  // CRUD for Exercise Types
  Future<List<ExerciseType>> getAllExerciseTypes() async {
    return await select(exerciseTypes).get();
  }

  Future<int> addExerciseType(String name, String icon) async {
    return await into(exerciseTypes).insert(
      ExerciseTypesCompanion(
        name: Value(name),
        icon: Value(icon),
        isDefault: const Value(false),
      ),
    );
  }

  Future<void> updateExerciseType(int id, String name, String icon) async {
    await (update(exerciseTypes)..where((tbl) => tbl.id.equals(id))).write(
      ExerciseTypesCompanion(
        name: Value(name),
        icon: Value(icon),
      ),
    );
  }

  Future<void> deleteExerciseType(int id) async {
    final type = await (select(exerciseTypes)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (type != null && !(type.isDefault ?? false)) {
      await (delete(exerciseTypes)..where((tbl) => tbl.id.equals(id))).go();
    } else {
      throw Exception('Cannot delete default exercise type');
    }
  }
}
