import 'package:drift/drift.dart';

class Progress extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get exerciseType => text()(); // Match with Goals.exerciseType
  IntColumn get count => integer()(); // Number of exercises completed
  IntColumn get duration => integer()(); // Duration in seconds
  DateTimeColumn get timestamp => dateTime()(); // Timestamp of the activity
}