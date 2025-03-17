import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('MMMM dd, yyyy, hh:mm a').format(parsedDate);
  }

  static String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  static String formatMonthKey(String monthKey) {
    final parts = monthKey.split('/');
    if (parts.length != 2) return monthKey;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return monthKey;

    final monthName = _getMonthName(month);
    return '$monthName $year';
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  static String formatDateTime(DateTime dateTime) {
    final month = _getMonthName(dateTime.month).substring(0, 3);
    final day = dateTime.day;
    final year = dateTime.year;
    return '$month $day, $year';
  }

  // New method to format a DateTime to "Month day" (e.g., "March 12")
  static String formatMonthDay(DateTime dateTime) {
    return DateFormat('MMMM d').format(dateTime);
  }

  // New method to format a DateTime to "Month day, year" (e.g., "March 12, 2024")
  static String formatMonthDayYear(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  //New method to format a DateTime to "Month year" (e.g. March 2024)
  static String formatMonthYear(DateTime dateTime){
    return DateFormat('MMMM yyyy').format(dateTime);
  }
}