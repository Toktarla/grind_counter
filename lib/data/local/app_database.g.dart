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
  static const VerificationMeta _triesMeta = const VerificationMeta('tries');
  @override
  late final GeneratedColumn<int> tries = GeneratedColumn<int>(
      'tries', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseType, timeElapsed, count, duration, timestamp, tries];
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
    if (data.containsKey('tries')) {
      context.handle(
          _triesMeta, tries.isAcceptableOrUnknown(data['tries']!, _triesMeta));
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
      tries: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tries'])!,
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
  final int tries;
  const ProgressData(
      {required this.id,
      required this.exerciseType,
      required this.timeElapsed,
      required this.count,
      required this.duration,
      required this.timestamp,
      required this.tries});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_type'] = Variable<String>(exerciseType);
    map['time_elapsed'] = Variable<String>(timeElapsed);
    map['count'] = Variable<int>(count);
    map['duration'] = Variable<int>(duration);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['tries'] = Variable<int>(tries);
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
      tries: Value(tries),
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
      tries: serializer.fromJson<int>(json['tries']),
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
      'tries': serializer.toJson<int>(tries),
    };
  }

  ProgressData copyWith(
          {int? id,
          String? exerciseType,
          String? timeElapsed,
          int? count,
          int? duration,
          DateTime? timestamp,
          int? tries}) =>
      ProgressData(
        id: id ?? this.id,
        exerciseType: exerciseType ?? this.exerciseType,
        timeElapsed: timeElapsed ?? this.timeElapsed,
        count: count ?? this.count,
        duration: duration ?? this.duration,
        timestamp: timestamp ?? this.timestamp,
        tries: tries ?? this.tries,
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
      tries: data.tries.present ? data.tries.value : this.tries,
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
          ..write('timestamp: $timestamp, ')
          ..write('tries: $tries')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, exerciseType, timeElapsed, count, duration, timestamp, tries);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressData &&
          other.id == this.id &&
          other.exerciseType == this.exerciseType &&
          other.timeElapsed == this.timeElapsed &&
          other.count == this.count &&
          other.duration == this.duration &&
          other.timestamp == this.timestamp &&
          other.tries == this.tries);
}

class ProgressCompanion extends UpdateCompanion<ProgressData> {
  final Value<int> id;
  final Value<String> exerciseType;
  final Value<String> timeElapsed;
  final Value<int> count;
  final Value<int> duration;
  final Value<DateTime> timestamp;
  final Value<int> tries;
  const ProgressCompanion({
    this.id = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.timeElapsed = const Value.absent(),
    this.count = const Value.absent(),
    this.duration = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.tries = const Value.absent(),
  });
  ProgressCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseType,
    required String timeElapsed,
    required int count,
    required int duration,
    required DateTime timestamp,
    this.tries = const Value.absent(),
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
    Expression<int>? tries,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (timeElapsed != null) 'time_elapsed': timeElapsed,
      if (count != null) 'count': count,
      if (duration != null) 'duration': duration,
      if (timestamp != null) 'timestamp': timestamp,
      if (tries != null) 'tries': tries,
    });
  }

  ProgressCompanion copyWith(
      {Value<int>? id,
      Value<String>? exerciseType,
      Value<String>? timeElapsed,
      Value<int>? count,
      Value<int>? duration,
      Value<DateTime>? timestamp,
      Value<int>? tries}) {
    return ProgressCompanion(
      id: id ?? this.id,
      exerciseType: exerciseType ?? this.exerciseType,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      count: count ?? this.count,
      duration: duration ?? this.duration,
      timestamp: timestamp ?? this.timestamp,
      tries: tries ?? this.tries,
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
    if (tries.present) {
      map['tries'] = Variable<int>(tries.value);
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
          ..write('timestamp: $timestamp, ')
          ..write('tries: $tries')
          ..write(')'))
        .toString();
  }
}

class $ExerciseTypesTable extends ExerciseTypes
    with TableInfo<$ExerciseTypesTable, ExerciseType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, createdAt, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_types';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseType(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
    );
  }

  @override
  $ExerciseTypesTable createAlias(String alias) {
    return $ExerciseTypesTable(attachedDatabase, alias);
  }
}

class ExerciseType extends DataClass implements Insertable<ExerciseType> {
  final int id;
  final String name;
  final String icon;
  final DateTime createdAt;
  final bool isDefault;
  const ExerciseType(
      {required this.id,
      required this.name,
      required this.icon,
      required this.createdAt,
      required this.isDefault});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  ExerciseTypesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseTypesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      createdAt: Value(createdAt),
      isDefault: Value(isDefault),
    );
  }

  factory ExerciseType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  ExerciseType copyWith(
          {int? id,
          String? name,
          String? icon,
          DateTime? createdAt,
          bool? isDefault}) =>
      ExerciseType(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
        isDefault: isDefault ?? this.isDefault,
      );
  ExerciseType copyWithCompanion(ExerciseTypesCompanion data) {
    return ExerciseType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, createdAt, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseType &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt &&
          other.isDefault == this.isDefault);
}

class ExerciseTypesCompanion extends UpdateCompanion<ExerciseType> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<DateTime> createdAt;
  final Value<bool> isDefault;
  const ExerciseTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  ExerciseTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    this.createdAt = const Value.absent(),
    this.isDefault = const Value.absent(),
  })  : name = Value(name),
        icon = Value(icon);
  static Insertable<ExerciseType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<DateTime>? createdAt,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  ExerciseTypesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? icon,
      Value<DateTime>? createdAt,
      Value<bool>? isDefault}) {
    return ExerciseTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $ProgressTable progress = $ProgressTable(this);
  late final $ExerciseTypesTable exerciseTypes = $ExerciseTypesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [goals, progress, exerciseTypes];
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
  Value<int> tries,
});
typedef $$ProgressTableUpdateCompanionBuilder = ProgressCompanion Function({
  Value<int> id,
  Value<String> exerciseType,
  Value<String> timeElapsed,
  Value<int> count,
  Value<int> duration,
  Value<DateTime> timestamp,
  Value<int> tries,
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

  ColumnFilters<int> get tries => $composableBuilder(
      column: $table.tries, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get tries => $composableBuilder(
      column: $table.tries, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<int> get tries =>
      $composableBuilder(column: $table.tries, builder: (column) => column);
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
            Value<int> tries = const Value.absent(),
          }) =>
              ProgressCompanion(
            id: id,
            exerciseType: exerciseType,
            timeElapsed: timeElapsed,
            count: count,
            duration: duration,
            timestamp: timestamp,
            tries: tries,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String exerciseType,
            required String timeElapsed,
            required int count,
            required int duration,
            required DateTime timestamp,
            Value<int> tries = const Value.absent(),
          }) =>
              ProgressCompanion.insert(
            id: id,
            exerciseType: exerciseType,
            timeElapsed: timeElapsed,
            count: count,
            duration: duration,
            timestamp: timestamp,
            tries: tries,
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
typedef $$ExerciseTypesTableCreateCompanionBuilder = ExerciseTypesCompanion
    Function({
  Value<int> id,
  required String name,
  required String icon,
  Value<DateTime> createdAt,
  Value<bool> isDefault,
});
typedef $$ExerciseTypesTableUpdateCompanionBuilder = ExerciseTypesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> icon,
  Value<DateTime> createdAt,
  Value<bool> isDefault,
});

class $$ExerciseTypesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseTypesTable> {
  $$ExerciseTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));
}

class $$ExerciseTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseTypesTable> {
  $$ExerciseTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseTypesTable> {
  $$ExerciseTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);
}

class $$ExerciseTypesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseTypesTable,
    ExerciseType,
    $$ExerciseTypesTableFilterComposer,
    $$ExerciseTypesTableOrderingComposer,
    $$ExerciseTypesTableAnnotationComposer,
    $$ExerciseTypesTableCreateCompanionBuilder,
    $$ExerciseTypesTableUpdateCompanionBuilder,
    (
      ExerciseType,
      BaseReferences<_$AppDatabase, $ExerciseTypesTable, ExerciseType>
    ),
    ExerciseType,
    PrefetchHooks Function()> {
  $$ExerciseTypesTableTableManager(_$AppDatabase db, $ExerciseTypesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
          }) =>
              ExerciseTypesCompanion(
            id: id,
            name: name,
            icon: icon,
            createdAt: createdAt,
            isDefault: isDefault,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String icon,
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
          }) =>
              ExerciseTypesCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            createdAt: createdAt,
            isDefault: isDefault,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseTypesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseTypesTable,
    ExerciseType,
    $$ExerciseTypesTableFilterComposer,
    $$ExerciseTypesTableOrderingComposer,
    $$ExerciseTypesTableAnnotationComposer,
    $$ExerciseTypesTableCreateCompanionBuilder,
    $$ExerciseTypesTableUpdateCompanionBuilder,
    (
      ExerciseType,
      BaseReferences<_$AppDatabase, $ExerciseTypesTable, ExerciseType>
    ),
    ExerciseType,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$ProgressTableTableManager get progress =>
      $$ProgressTableTableManager(_db, _db.progress);
  $$ExerciseTypesTableTableManager get exerciseTypes =>
      $$ExerciseTypesTableTableManager(_db, _db.exerciseTypes);
}
