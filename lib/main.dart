import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/config/routes.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/viewmodels/theme_provider.dart';
import 'package:work_out_app/views/home_page.dart';
import 'config/di/injection_container.dart';
import 'utils/helpers/snackbar_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await setupServiceLocator();

  // final firebaseMessagingService = sl<FirebaseMessagingService>();

  // LocalNotificationService.initialize();
  // firebaseMessagingService.initialize();

  // LocalNotificationService.scheduleDailyMotivationalMessage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => sl()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.currentTheme,
            debugShowCheckedModeBanner: false,
            builder: (_, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: MediaQuery.of(context)
                    .textScaler
                    .clamp(minScaleFactor: 0.8, maxScaleFactor: 1),
              ),
              child: child!,
            ),
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            title: 'Grind Counter',
            home: const HomePage(),
            scaffoldMessengerKey: SnackbarHelper.scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}

