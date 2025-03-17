import 'package:drift/drift.dart';

class Progress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseType => text()();
  TextColumn get timeElapsed => text()();
  IntColumn get count => integer()();
  IntColumn get duration => integer()();
  DateTimeColumn get timestamp => dateTime()();
  IntColumn get tries => integer().withDefault(const Constant(1))(); // Add tries column
}