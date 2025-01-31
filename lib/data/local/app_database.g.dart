// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseTypeMeta =
      const VerificationMeta('exerciseType');
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
      'exercise_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dailyGoalMeta =
      const VerificationMeta('dailyGoal');
  @override
  late final GeneratedColumn<int> dailyGoal = GeneratedColumn<int>(
      'daily_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _weeklyGoalMeta =
      const VerificationMeta('weeklyGoal');
  @override
  late final GeneratedColumn<int> weeklyGoal = GeneratedColumn<int>(
      'weekly_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _monthlyGoalMeta =
      const VerificationMeta('monthlyGoal');
  @override
  late final GeneratedColumn<int> monthlyGoal = GeneratedColumn<int>(
      'monthly_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _yearlyGoalMeta =
      const VerificationMeta('yearlyGoal');
  @override
  late final GeneratedColumn<int> yearlyGoal = GeneratedColumn<int>(
      'yearly_goal', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [exerciseType, dailyGoal, weeklyGoal, monthlyGoal, yearlyGoal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_type')) {
      context.handle(
          _exerciseTypeMeta,
          exerciseType.isAcceptableOrUnknown(
              data['exercise_type']!, _exerciseTypeMeta));
    } else if (isInserting) {
      context.missing(_exerciseTypeMeta);
    }
    if (data.containsKey('daily_goal')) {
      context.handle(_dailyGoalMeta,
          dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta));
    }
    if (data.containsKey('weekly_goal')) {
      context.handle(
          _weeklyGoalMeta,
          weeklyGoal.isAcceptableOrUnknown(
              data['weekly_goal']!, _weeklyGoalMeta));
    }
    if (data.containsKey('monthly_goal')) {
      context.handle(
          _monthlyGoalMeta,
          monthlyGoal.isAcceptableOrUnknown(
              data['monthly_goal']!, _monthlyGoalMeta));
    }
    if (data.containsKey('yearly_goal')) {
      context.handle(
          _yearlyGoalMeta,
          yearlyGoal.isAcceptableOrUnknown(
              data['yearly_goal']!, _yearlyGoalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exerciseType};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      exerciseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_type'])!,
      dailyGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_goal'])!,
      weeklyGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weekly_goal'])!,
      monthlyGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monthly_goal'])!,
      yearlyGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}yearly_goal'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String exerciseType;
  final int dailyGoal;
  final int weeklyGoal;
  final int monthlyGoal;
  final int yearlyGoal;
  const Goal(
      {required this.exerciseType,
      required this.dailyGoal,
      required this.weeklyGoal,
      required this.monthlyGoal,
      required this.yearlyGoal});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise_type'] = Variable<String>(exerciseType);
    map['daily_goal'] = Variable<int>(dailyGoal);
    map['weekly_goal'] = Variable<int>(weeklyGoal);
    map['monthly_goal'] = Variable<int>(monthlyGoal);
    map['yearly_goal'] = Variable<int>(yearlyGoal);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      exerciseType: Value(exerciseType),
      dailyGoal: Value(dailyGoal),
      weeklyGoal: Value(weeklyGoal),
      monthlyGoal: Value(monthlyGoal),
      yearlyGoal: Value(yearlyGoal),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      dailyGoal: serializer.fromJson<int>(json['dailyGoal']),
      weeklyGoal: serializer.fromJson<int>(json['weeklyGoal']),
      monthlyGoal: serializer.fromJson<int>(json['monthlyGoal']),
      yearlyGoal: serializer.fromJson<int>(json['yearlyGoal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseType': serializer.toJson<String>(exerciseType),
      'dailyGoal': serializer.toJson<int>(dailyGoal),
      'weeklyGoal': serializer.toJson<int>(weeklyGoal),
      'monthlyGoal': serializer.toJson<int>(monthlyGoal),
      'yearlyGoal': serializer.toJson<int>(yearlyGoal),
    };
  }

  Goal copyWith(
          {String? exerciseType,
          int? dailyGoal,
          int? weeklyGoal,
          int? monthlyGoal,
          int? yearlyGoal}) =>
      Goal(
        exerciseType: exerciseType ?? this.exerciseType,
        dailyGoal: dailyGoal ?? this.dailyGoal,
        weeklyGoal: weeklyGoal ?? this.weeklyGoal,
        monthlyGoal: monthlyGoal ?? this.monthlyGoal,
        yearlyGoal: yearlyGoal ?? this.yearlyGoal,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      weeklyGoal:
          data.weeklyGoal.present ? data.weeklyGoal.value : this.weeklyGoal,
      monthlyGoal:
          data.monthlyGoal.present ? data.monthlyGoal.value : this.monthlyGoal,
      yearlyGoal:
          data.yearlyGoal.present ? data.yearlyGoal.value : this.yearlyGoal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('exerciseType: $exerciseType, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('weeklyGoal: $weeklyGoal, ')
          ..write('monthlyGoal: $monthlyGoal, ')
          ..write('yearlyGoal: $yearlyGoal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(exerciseType, dailyGoal, weeklyGoal, monthlyGoal, yearlyGoal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.exerciseType == this.exerciseType &&
          other.dailyGoal == this.dailyGoal &&
          other.weeklyGoal == this.weeklyGoal &&
          other.monthlyGoal == this.monthlyGoal &&
          other.yearlyGoal == this.yearlyGoal);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> exerciseType;
  final Value<int> dailyGoal;
  final Value<int> weeklyGoal;
  final Value<int> monthlyGoal;
  final Value<int> yearlyGoal;
  final Value<int> rowid;
  const GoalsCompanion({
    this.exerciseType = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.weeklyGoal = const Value.absent(),
    this.monthlyGoal = const Value.absent(),
    this.yearlyGoal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String exerciseType,
    this.dailyGoal = const Value.absent(),
    this.weeklyGoal = const Value.absent(),
    this.monthlyGoal = const Value.absent(),
    this.yearlyGoal = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : exerciseType = Value(exerciseType);
  static Insertable<Goal> custom({
    Expression<String>? exerciseType,
    Expression<int>? dailyGoal,
    Expression<int>? weeklyGoal,
    Expression<int>? monthlyGoal,
    Expression<int>? yearlyGoal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (weeklyGoal != null) 'weekly_goal': weeklyGoal,
      if (monthlyGoal != null) 'monthly_goal': monthlyGoal,
      if (yearlyGoal != null) 'yearly_goal': yearlyGoal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith(
      {Value<String>? exerciseType,
      Value<int>? dailyGoal,
      Value<int>? weeklyGoal,
      Value<int>? monthlyGoal,
      Value<int>? yearlyGoal,
      Value<int>? rowid}) {
    return GoalsCompanion(
      exerciseType: exerciseType ?? this.exerciseType,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      weeklyGoal: weeklyGoal ?? this.weeklyGoal,
      monthlyGoal: monthlyGoal ?? this.monthlyGoal,
      yearlyGoal: yearlyGoal ?? this.yearlyGoal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<int>(dailyGoal.value);
    }
    if (weeklyGoal.present) {
      map['weekly_goal'] = Variable<int>(weeklyGoal.value);
    }
    if (monthlyGoal.present) {
      map['monthly_goal'] = Variable<int>(monthlyGoal.value);
    }
    if (yearlyGoal.present) {
      map['yearly_goal'] = Variable<int>(yearlyGoal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('exerciseType: $exerciseType, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('weeklyGoal: $weeklyGoal, ')
          ..write('monthlyGoal: $monthlyGoal, ')
          ..write('yearlyGoal: $yearlyGoal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgressTable extends Progress
    with TableInfo<$ProgressTable, ProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseTypeMeta =
      const VerificationMeta('exerciseType');
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
      'exercise_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeElapsedMeta =
      const VerificationMeta('timeElapsed');
  @override
  late final GeneratedColumn<String> timeElapsed = GeneratedColumn<String>(
      'time_elapsed', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseType, timeElapsed, count, duration, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress';
  @override
  VerificationContext validateIntegrity(Insertable<ProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
          _exerciseTypeMeta,
          exerciseType.isAcceptableOrUnknown(
              data['exercise_type']!, _exerciseTypeMeta));
    } else if (isInserting) {
      context.missing(_exerciseTypeMeta);
    }
    if (data.containsKey('time_elapsed')) {
      context.handle(
          _timeElapsedMeta,
          timeElapsed.isAcceptableOrUnknown(
              data['time_elapsed']!, _timeElapsedMeta));
    } else if (isInserting) {
      context.missing(_timeElapsedMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_type'])!,
      timeElapsed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_elapsed'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ProgressTable createAlias(String alias) {
    return $ProgressTable(attachedDatabase, alias);
  }
}

class ProgressData extends DataClass implements Insertable<ProgressData> {
  final int id;
  final String exerciseType;
  final String timeElapsed;
  final int count;
  final int duration;
  final DateTime timestamp;
  const ProgressData(
      {required this.id,
      required this.exerciseType,
      required this.timeElapsed,
      required this.count,
      required this.duration,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_type'] = Variable<String>(exerciseType);
    map['time_elapsed'] = Variable<String>(timeElapsed);
    map['count'] = Variable<int>(count);
    map['duration'] = Variable<int>(duration);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  ProgressCompanion toCompanion(bool nullToAbsent) {
    return ProgressCompanion(
      id: Value(id),
      exerciseType: Value(exerciseType),
      timeElapsed: Value(timeElapsed),
      count: Value(count),
      duration: Value(duration),
      timestamp: Value(timestamp),
    );
  }

  factory ProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressData(
      id: serializer.fromJson<int>(json['id']),
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      timeElapsed: serializer.fromJson<String>(json['timeElapsed']),
      count: serializer.fromJson<int>(json['count']),
      duration: serializer.fromJson<int>(json['duration']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseType': serializer.toJson<String>(exerciseType),
      'timeElapsed': serializer.toJson<String>(timeElapsed),
      'count': serializer.toJson<int>(count),
      'duration': serializer.toJson<int>(duration),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  ProgressData copyWith(
          {int? id,
          String? exerciseType,
          String? timeElapsed,
          int? count,
          int? duration,
          DateTime? timestamp}) =>
      ProgressData(
        id: id ?? this.id,
        exerciseType: exerciseType ?? this.exerciseType,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        count: count ?? this.count,
        duration: duration ?? this.duration,
        timestamp: timestamp ?? this.timestamp,
      );
  ProgressData copyWithCompanion(ProgressCompanion data) {
    return ProgressData(
      id: data.id.present ? data.id.value : this.id,
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      timeElapsed:
          data.timeElapsed.present ? data.timeElapsed.value : this.timeElapsed,
      count: data.count.present ? data.count.value : this.count,
      duration: data.duration.present ? data.duration.value : this.duration,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressData(')
          ..write('id: $id, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('timeElapsed: $timeElapsed, ')
          ..write('count: $count, ')
          ..write('duration: $duration, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseType, timeElapsed, count, duration, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressData &&
          other.id == this.id &&
          other.exerciseType == this.exerciseType &&
          other.timeElapsed == this.timeElapsed &&
          other.count == this.count &&
          other.duration == this.duration &&
          other.timestamp == this.timestamp);
}

class ProgressCompanion extends UpdateCompanion<ProgressData> {
  final Value<int> id;
  final Value<String> exerciseType;
  final Value<String> timeElapsed;
  final Value<int> count;
  final Value<int> duration;
  final Value<DateTime> timestamp;
  const ProgressCompanion({
    this.id = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.timeElapsed = const Value.absent(),
    this.count = const Value.absent(),
    this.duration = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ProgressCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseType,
    required String timeElapsed,
    required int count,
    required int duration,
    required DateTime timestamp,
  })  : exerciseType = Value(exerciseType),
        timeElapsed = Value(timeElapsed),
        count = Value(count),
        duration = Value(duration),
        timestamp = Value(timestamp);
  static Insertable<ProgressData> custom({
    Expression<int>? id,
    Expression<String>? exerciseType,
    Expression<String>? timeElapsed,
    Expression<int>? count,
    Expression<int>? duration,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (timeElapsed != null) 'time_elapsed': timeElapsed,
      if (count != null) 'count': count,
      if (duration != null) 'duration': duration,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ProgressCompanion copyWith(
      {Value<int>? id,
      Value<String>? exerciseType,
      Value<String>? timeElapsed,
      Value<int>? count,
      Value<int>? duration,
      Value<DateTime>? timestamp}) {
    return ProgressCompanion(
      id: id ?? this.id,
      exerciseType: exerciseType ?? this.exerciseType,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      count: count ?? this.count,
      duration: duration ?? this.duration,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (timeElapsed.present) {
      map['time_elapsed'] = Variable<String>(timeElapsed.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressCompanion(')
          ..write('id: $id, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('timeElapsed: $timeElapsed, ')
          ..write('count: $count, ')
          ..write('duration: $duration, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $ProgressTable progress = $ProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [goals, progress];
}

typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String exerciseType,
  Value<int> dailyGoal,
  Value<int> weeklyGoal,
  Value<int> monthlyGoal,
  Value<int> yearlyGoal,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> exerciseType,
  Value<int> dailyGoal,
  Value<int> weeklyGoal,
  Value<int> monthlyGoal,
  Value<int> yearlyGoal,
  Value<int> rowid,
});

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyGoal => $composableBuilder(
      column: $table.dailyGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weeklyGoal => $composableBuilder(
      column: $table.weeklyGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyGoal => $composableBuilder(
      column: $table.monthlyGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get yearlyGoal => $composableBuilder(
      column: $table.yearlyGoal, builder: (column) => ColumnFilters(column));
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyGoal => $composableBuilder(
      column: $table.dailyGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weeklyGoal => $composableBuilder(
      column: $table.weeklyGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyGoal => $composableBuilder(
      column: $table.monthlyGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get yearlyGoal => $composableBuilder(
      column: $table.yearlyGoal, builder: (column) => ColumnOrderings(column));
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => column);

  GeneratedColumn<int> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumn<int> get weeklyGoal => $composableBuilder(
      column: $table.weeklyGoal, builder: (column) => column);

  GeneratedColumn<int> get monthlyGoal => $composableBuilder(
      column: $table.monthlyGoal, builder: (column) => column);

  GeneratedColumn<int> get yearlyGoal => $composableBuilder(
      column: $table.yearlyGoal, builder: (column) => column);
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> exerciseType = const Value.absent(),
            Value<int> dailyGoal = const Value.absent(),
            Value<int> weeklyGoal = const Value.absent(),
            Value<int> monthlyGoal = const Value.absent(),
            Value<int> yearlyGoal = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion(
            exerciseType: exerciseType,
            dailyGoal: dailyGoal,
            weeklyGoal: weeklyGoal,
            monthlyGoal: monthlyGoal,
            yearlyGoal: yearlyGoal,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String exerciseType,
            Value<int> dailyGoal = const Value.absent(),
            Value<int> weeklyGoal = const Value.absent(),
            Value<int> monthlyGoal = const Value.absent(),
            Value<int> yearlyGoal = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            exerciseType: exerciseType,
            dailyGoal: dailyGoal,
            weeklyGoal: weeklyGoal,
            monthlyGoal: monthlyGoal,
            yearlyGoal: yearlyGoal,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()>;
typedef $$ProgressTableCreateCompanionBuilder = ProgressCompanion Function({
  Value<int> id,
  required String exerciseType,
  required String timeElapsed,
  required int count,
  required int duration,
  required DateTime timestamp,
});
typedef $$ProgressTableUpdateCompanionBuilder = ProgressCompanion Function({
  Value<int> id,
  Value<String> exerciseType,
  Value<String> timeElapsed,
  Value<int> count,
  Value<int> duration,
  Value<DateTime> timestamp,
});

class $$ProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeElapsed => $composableBuilder(
      column: $table.timeElapsed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$ProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeElapsed => $composableBuilder(
      column: $table.timeElapsed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$ProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressTable> {
  $$ProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseType => $composableBuilder(
      column: $table.exerciseType, builder: (column) => column);

  GeneratedColumn<String> get timeElapsed => $composableBuilder(
      column: $table.timeElapsed, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$ProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProgressTable,
    ProgressData,
    $$ProgressTableFilterComposer,
    $$ProgressTableOrderingComposer,
    $$ProgressTableAnnotationComposer,
    $$ProgressTableCreateCompanionBuilder,
    $$ProgressTableUpdateCompanionBuilder,
    (ProgressData, BaseReferences<_$AppDatabase, $ProgressTable, ProgressData>),
    ProgressData,
    PrefetchHooks Function()> {
  $$ProgressTableTableManager(_$AppDatabase db, $ProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> exerciseType = const Value.absent(),
            Value<String> timeElapsed = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              ProgressCompanion(
            id: id,
            exerciseType: exerciseType,
            timeElapsed: timeElapsed,
            count: count,
            duration: duration,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String exerciseType,
            required String timeElapsed,
            required int count,
            required int duration,
            required DateTime timestamp,
          }) =>
              ProgressCompanion.insert(
            id: id,
            exerciseType: exerciseType,
            timeElapsed: timeElapsed,
            count: count,
            duration: duration,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProgressTable,
    ProgressData,
    $$ProgressTableFilterComposer,
    $$ProgressTableOrderingComposer,
    $$ProgressTableAnnotationComposer,
    $$ProgressTableCreateCompanionBuilder,
    $$ProgressTableUpdateCompanionBuilder,
    (ProgressData, BaseReferences<_$AppDatabase, $ProgressTable, ProgressData>),
    ProgressData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$ProgressTableTableManager get progress =>
      $$ProgressTableTableManager(_db, _db.progress);
}
