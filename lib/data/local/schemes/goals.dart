import 'package:drift/drift.dart';

class Goals extends Table {
  TextColumn get exerciseType => text()();
  IntColumn get dailyGoal => integer().withDefault(const Constant(0))();
  IntColumn get weeklyGoal => integer().withDefault(const Constant(0))();
  IntColumn get monthlyGoal => integer().withDefault(const Constant(0))();
  IntColumn get yearlyGoal => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {exerciseType};
}
