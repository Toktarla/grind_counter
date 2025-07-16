import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/routes.dart';
import 'package:work_out_app/providers/exercise_type_provider.dart';
import 'package:work_out_app/providers/theme_provider.dart';
import 'package:work_out_app/services/local_notification_service.dart';
import 'package:work_out_app/utils/helpers/crashlytics.dart';
import 'package:work_out_app/views/home_page.dart';
import 'config/di/injection_container.dart';
import 'config/firebase/firebase_options.dart';
import 'utils/helpers/snackbar_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void updateWorkoutWidget(int exercisesDone) async {
  await HomeWidget.saveWidgetData<int>('exercises_done', exercisesDone);
  await HomeWidget.updateWidget(name: 'WorkoutWidgetProvider');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();

  await setupCrashlytics();
  await dotenv.load(fileName: ".env");
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  LocalNotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExerciseTypeProvider>(create: (_) => sl()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => sl()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.currentTheme,
            debugShowCheckedModeBanner: false,
            builder: (_, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: MediaQuery.of(context).textScaler
                    .clamp(minScaleFactor: 0.8, maxScaleFactor: 1),
              ),
              child: child!,
            ),
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            title: 'grinder',
            home: const HomePage(),
            scaffoldMessengerKey: SnackbarHelper.scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}

