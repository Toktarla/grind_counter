import 'package:flutter/material.dart';
import 'package:work_out_app/utils/error/error_page.dart';
import 'package:work_out_app/views/about_page.dart';
import 'package:work_out_app/views/exercise_page.dart';
import 'package:work_out_app/views/goal_page.dart';
import 'package:work_out_app/views/home_page.dart';
import 'package:work_out_app/views/logs_page.dart';
import 'package:work_out_app/views/settings_page.dart';
import 'package:work_out_app/views/stats_page.dart';
import 'package:work_out_app/views/summary_page.dart';

import '../views/feedback_page.dart';


class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/Exercise':
        final map = settings.arguments as Map<String,dynamic>;
        return _materialRoute(ExercisePage(exerciseType: map['exerciseType'],));
      case '/Home':
        return _materialRoute(const HomePage());
      case '/Goal':
        return _materialRoute(const GoalPage());
      case '/Logs':
        return _materialRoute(const LogsPage());
      case '/Stats':
        return _materialRoute(const StatsPage());
      case '/Settings':
        return _materialRoute(SettingsPage());
      case '/About':
        return _materialRoute(const AboutPage());
      case '/Feedback':
        return _materialRoute(const FeedbackPage());
      case '/Summary':
        final map = settings.arguments as Map<String,dynamic>;
        return _materialRoute(SummaryPage(workout: map['workout'], date: map['date'], counter: map['counter'], timeElapsed: map['timeElapsed'],));
      default:
        return _materialRoute(const ErrorPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(
      builder: (_) => view,
    );
  }
}