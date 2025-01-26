import 'package:drift/drift.dart';

class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseType => text()(); // e.g., push-ups, squats, etc.
  IntColumn get dailyGoal => integer().withDefault(const Constant(0))();
  IntColumn get weeklyGoal => integer().withDefault(const Constant(0))();
  IntColumn get monthlyGoal => integer().withDefault(const Constant(0))();
  IntColumn get yearlyGoal => integer().withDefault(const Constant(0))();
}