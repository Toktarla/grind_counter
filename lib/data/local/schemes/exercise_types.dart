import 'package:drift/drift.dart';

class ExerciseTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get icon => text().withLength(min: 1, max: 50)(); // Store icon name or code
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
} 