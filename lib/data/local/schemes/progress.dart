import 'package:drift/drift.dart';

class Progress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseType => text()();
  TextColumn get timeElapsed => text()();
  IntColumn get count => integer()();
  IntColumn get duration => integer()();
  DateTimeColumn get timestamp => dateTime()();
}