import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/data/repositories/goal_repository.dart';
import 'package:work_out_app/data/repositories/progress_repository.dart';
import '../../viewmodels/theme_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Local Storage
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());


  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepository(sl()));
  sl.registerLazySingleton<GoalRepository>(() => GoalRepository(sl()));

  // Register Firebase instances
  // sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);

  // Register services
  // sl.registerLazySingleton<FirestoreService>(() => FirestoreService(sl(),sl()));
  // sl.registerLazySingleton<FirebaseMessagingService>(() => FirebaseMessagingService(sl(),sl<FirestoreService>()));


  sl.registerFactory<ThemeProvider>(() => ThemeProvider(sl())
  );
}
