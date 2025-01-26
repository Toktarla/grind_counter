import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/data/local/app_database.dart';
import '../../viewmodels/theme_provider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Local Storage
  sl.registerSingleton<SharedPreferences>(prefs);

  // Register Firebase instances
  // sl.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);

  // Register services
  // sl.registerLazySingleton<FirestoreService>(() => FirestoreService(sl(),sl()));
  // sl.registerLazySingleton<FirebaseMessagingService>(() => FirebaseMessagingService(sl(),sl<FirestoreService>()));
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  sl.registerFactory<ThemeProvider>(() => ThemeProvider(sl())
  );
}
