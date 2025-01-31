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
}