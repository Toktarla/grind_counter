import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/providers/exercise_type_provider.dart';
import '../../providers/theme_provider.dart';
import '../../repositories/goal_repository.dart';
import '../../repositories/progress_repository.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  sl.registerLazySingleton<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);

  // Local Storage
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepository(sl()));
  sl.registerLazySingleton<GoalRepository>(() => GoalRepository(sl()));

  sl.registerFactory<ThemeProvider>(() => ThemeProvider(sl()));
  sl.registerFactory<ExerciseTypeProvider>(() => ExerciseTypeProvider());
}
