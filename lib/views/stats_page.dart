import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../config/di/injection_container.dart';
import '../utils/helpers/date_helper.dart';
import '../widgets/detail_card_widget.dart';

class StatsPage extends StatefulWidget {

  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with TickerProviderStateMixin {
  final database = sl<AppDatabase>();
  late TabController _tabController;
  String _selectedExercise = '';
  List<String> _exerciseTypes = [];
  DateTime _currentDate = DateTime.now();
  DateTime _currentWeekStart = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime _currentMonthStart = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _currentYearStart = DateTime(DateTime.now().year, 1, 1);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadExerciseTypes();
  }

  void _onShareButtonPressed() async {
    final data = await _getMonthChartData();

    int totalExercises = 0;
    for (final record in data) {
      totalExercises += record.count;
    }

    String message = 'I did $totalExercises exercises in the last month!';

    Share.share(message);
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _currentDate = pickedDate;
        _currentWeekStart = pickedDate.subtract(Duration(days: pickedDate.weekday - 1));
        _currentMonthStart = DateTime(pickedDate.year, pickedDate.month, 1);
        _currentYearStart = DateTime(pickedDate.year, 1, 1);
      });
    }
  }

  Future<void> _loadExerciseTypes() async {
    final types = await database.getAllExerciseTypes();
    setState(() {
      _exerciseTypes = types.map((e) => e.name).toList();
      if (!_exerciseTypes.contains(_selectedExercise) && _exerciseTypes.isNotEmpty) {
        _selectedExercise = _exerciseTypes.first;
      }
    });
  }

  Future<List<ProgressData>> _getDayChartData() async {
    final data = await database.getAllProgressRecords(_selectedExercise);
    final selectedDateStart = DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
    final selectedDateEnd = selectedDateStart.add(const Duration(days: 1));

    final filteredData = data.where((record) {
      return record.timestamp.isAfter(selectedDateStart.subtract(const Duration(seconds: 1))) &&
          record.timestamp.isBefore(selectedDateEnd);
    }).toList();
    return Future.value(filteredData);
  }

  Future<List<ProgressData>> _getWeekChartData() async {
    final data = await database.getAllProgressRecords(_selectedExercise);
    final weekStart = _currentWeekStart;
    final weekEnd = weekStart.add(const Duration(days: 7));
    final filteredData = data.where((record) => record.timestamp.isAfter(weekStart.subtract(const Duration(days: 1))) && record.timestamp.isBefore(weekEnd)).toList();

    final weeklyData = <String, ({int count, int duration, int tries})>{}; // Add tries
    for (final record in filteredData) {
      final day = DateFormat('yyyy-MM-dd').format(record.timestamp);
      if (weeklyData.containsKey(day)) {
        weeklyData[day] = (
        count: weeklyData[day]!.count + record.count,
        duration: weeklyData[day]!.duration + record.duration,
        tries: weeklyData[day]!.tries + record.tries // Accumulate tries
        );
      } else {
        weeklyData[day] = (count: record.count, duration: record.duration, tries: record.tries);
      }
    }

    return weeklyData.entries.map((entry) {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(entry.key);
      return ProgressData(
          id: 0,
          exerciseType: "",
          timeElapsed: "",
          count: entry.value.count,
          duration: entry.value.duration,
          timestamp: parsedDate,
          tries: entry.value.tries // Add tries to ProgressData
      );
    }).toList();
  }

  Future<List<ProgressData>> _getMonthChartData() async {
    final data = await database.getAllProgressRecords(_selectedExercise);
    final monthStart = _currentMonthStart;
    final monthEnd = DateTime(monthStart.year, monthStart.month + 1, 1);
    final filteredData = data.where((record) => record.timestamp.isAfter(monthStart.subtract(const Duration(days: 1))) && record.timestamp.isBefore(monthEnd)).toList();

    final monthlyData = <int, ({int count, int duration, int tries})>{};
    for (final record in filteredData) {
      final day = record.timestamp.day;
      if (monthlyData.containsKey(day)) {
        monthlyData[day] = (
        count: monthlyData[day]!.count + record.count,
        duration: monthlyData[day]!.duration + record.duration,
        tries: monthlyData[day]!.tries + record.tries
        );
      } else {
        monthlyData[day] = (count: record.count, duration: record.duration, tries: record.tries);
      }
    }

    return monthlyData.entries.map((entry) => ProgressData(id: 0, exerciseType: "", timeElapsed: "", count: entry.value.count, duration: entry.value.duration, timestamp: DateTime(2023, 1, entry.key), tries: entry.value.tries)).toList();
  }

  Future<List<ProgressData>> _getYearChartData() async {
    final data = await database.getAllProgressRecords(_selectedExercise);
    final yearStart = _currentYearStart;
    final yearEnd = DateTime(yearStart.year + 1, 1, 1);
    final filteredData = data.where((record) => record.timestamp.isAfter(yearStart.subtract(const Duration(days: 1))) && record.timestamp.isBefore(yearEnd)).toList();

    final yearlyData = <int, ({int count, int duration, int tries})>{};
    for (final record in filteredData) {
      final month = record.timestamp.month;
      if (yearlyData.containsKey(month)) {
        yearlyData[month] = (
        count: yearlyData[month]!.count + record.count,
        duration: yearlyData[month]!.duration + record.duration,
        tries: yearlyData[month]!.tries + record.tries
        );
      } else {
        yearlyData[month] = (count: record.count, duration: record.duration, tries: record.tries);
      }
    }
    return yearlyData.entries.map((entry) => ProgressData(id: 0, exerciseType: "", timeElapsed: "", count: entry.value.count, duration: entry.value.duration, timestamp: DateTime(2023, entry.key, 1), tries: entry.value.tries)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _onShareButtonPressed,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 48),
          child: Column(
            children: [
              TabBar(
                labelStyle: Theme.of(context).textTheme.titleLarge,
                indicatorColor: Theme.of(context).hintColor,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Day'),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                  Tab(text: 'Year'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: DropdownButton<String>(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: _selectedExercise,
                  items: _exerciseTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type, style: Theme.of(context).textTheme.titleLarge),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedExercise = value!;
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTab(future: _getDayChartData(), navigationRow: _dateNavigationRow()),
          _buildTab(future: _getWeekChartData(), navigationRow: _weekNavigationRow()),
          _buildTab(future: _getMonthChartData(), navigationRow: _monthNavigationRow()),
          _buildTab(future: _getYearChartData(), navigationRow: _yearNavigationRow()),
        ],
      ),
    );
  }

  Widget _buildTab({required Future? future, required Widget navigationRow}) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: navigationRow,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Use min size
                    children: [
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        size: 60,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No stats for this date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 14,
                        width: MediaQuery.sizeOf(context).width/2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.blueAccentColor,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/Home');
                          },
                          child: const Text(
                            'Record Workout',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          final data = snapshot.data!;
          num totalCount = 0;
          num totalDuration = 0;
          num tries = 0;

          for (final record in data) {
            totalCount += record.count;
            totalDuration += record.duration;
            tries += record.tries;
          }

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: navigationRow,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0), // Adjust top padding
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      DetailCard(
                        width: 140,
                        height: 140,
                        icon: Icons.fitness_center_sharp,
                        integerValue: totalCount.toString(),
                        label: 'Workout Count',
                        color: Colors.pinkAccent,
                      ),
                      DetailCard(
                        width: 140,
                        height: 140,
                        icon: Icons.timer_sharp,
                        integerValue: DateHelper.formatTime(totalDuration.toInt()),
                        label: 'Duration',
                        color: Colors.blue,
                      ),
                      DetailCard(
                        width: 140,
                        height: 140,
                        icon: Icons.accessibility_sharp,
                        integerValue: tries.toString(),
                        label: 'Number of Tries',
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _dateNavigationRow() {
    final today = DateTime.now();
    final currentDateStart = DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
    final todayStart = DateTime(today.year, today.month, today.day);
    final isFutureDate = currentDateStart.isAfter(todayStart);
    final isCurrentDate = currentDateStart.isAtSameMomentAs(todayStart);

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, size: 30, color: Theme.of(context).primaryColor,),
          onPressed: () {
            setState(() {
              _currentDate = _currentDate.subtract(const Duration(days: 1));
            });
          },
        ),
        const Spacer(),
        Text(DateHelper.formatMonthDay(_currentDate), style: Theme.of(context).textTheme.displayLarge,),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _showDatePickerDialog(context);
          },
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_sharp, size: 30, color: Theme.of(context).primaryColor),
          onPressed: isFutureDate || isCurrentDate
              ? null // Disable the button
              : () {
            setState(() {
              _currentDate = _currentDate.add(const Duration(days: 1));
            });
          },
        ),
      ],
    );
  }

  Widget _weekNavigationRow() {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final currentWeekStart = todayStart.subtract(Duration(days: todayStart.weekday - 1));
    final isFutureWeek = _currentWeekStart.isAfter(currentWeekStart);
    final isCurrentWeek = _currentWeekStart.isAtSameMomentAs(currentWeekStart);

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, size: 30, color: Theme.of(context).primaryColor,),
          onPressed: () {
            setState(() {
              _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
            });
          },
        ),
        const Spacer(),
        Text(
          '${DateHelper.formatMonthDay(_currentWeekStart)} - ${DateHelper.formatMonthDay(_currentWeekStart.add(const Duration(days: 6)))}',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _showDatePickerDialog(context);
          },
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_sharp, size: 30, color: Theme.of(context).primaryColor),
          onPressed: isFutureWeek || isCurrentWeek
              ? null
              : () {
            setState(() {
              _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
            });
          },
        ),
      ],
    );
  }

  Widget _monthNavigationRow() {
    final today = DateTime.now();
    final currentMonth = DateTime(today.year, today.month, 1);
    final isFutureMonth = _currentMonthStart.isAfter(currentMonth);
    final isCurrentMonth = _currentMonthStart.isAtSameMomentAs(currentMonth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentMonthStart =
                  DateTime(_currentMonthStart.year, _currentMonthStart.month - 1, 1);
            });
          },
        ),
        const Spacer(),
        Text(
          DateHelper.formatMonthYear(_currentMonthStart),
          style: Theme.of(context).textTheme.displayLarge,
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _showDatePickerDialog(context);
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: isFutureMonth || isCurrentMonth
              ? null
              : () {
            setState(() {
              _currentMonthStart = DateTime(_currentMonthStart.year, _currentMonthStart.month + 1, 1);
            });
          },
        ),
      ],
    );
  }

  Widget _yearNavigationRow() {
    final today = DateTime.now();
    final currentYear = DateTime(today.year, 1, 1);
    final isFutureYear = _currentYearStart.isAfter(currentYear);
    final isCurrentYear = _currentYearStart.isAtSameMomentAs(currentYear);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentYearStart = DateTime(_currentYearStart.year - 1, 1, 1);
            });
          },
        ),
        const Spacer(),
        Text(
          DateFormat('yyyy').format(_currentYearStart),
          style: Theme.of(context).textTheme.displayLarge,
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () {
            _showDatePickerDialog(context);
          },
        ),
        const Spacer(),

        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: isFutureYear || isCurrentYear
              ? null
              : () {
            setState(() {
              _currentYearStart = DateTime(_currentYearStart.year + 1, 1, 1);
            });
          },
        ),
      ],
    );
  }

}
