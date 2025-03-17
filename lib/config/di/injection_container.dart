import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/data/local/app_database.dart';
import '../../repositories/goal_repository.dart';
import '../../repositories/progress_repository.dart';
import '../../services/firebase_messaging_service.dart';
import '../../viewmodels/theme_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();


  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);


  // Register services
  sl.registerLazySingleton<FirebaseMessagingService>(() => FirebaseMessagingService(sl()));

  // Local Storage
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());


  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepository(sl()));
  sl.registerLazySingleton<GoalRepository>(() => GoalRepository(sl()));

  sl.registerFactory<ThemeProvider>(() => ThemeProvider(sl())
  );
}
