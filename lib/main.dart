import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/routes.dart';
import 'package:work_out_app/services/firebase_messaging_service.dart';
import 'package:work_out_app/services/local_notification_service.dart';
import 'package:work_out_app/utils/helpers/crashlytics.dart';
import 'package:work_out_app/viewmodels/theme_provider.dart';
import 'package:work_out_app/views/home_page.dart';
import 'config/di/injection_container.dart';
import 'config/firebase/firebase_options.dart';
import 'utils/helpers/snackbar_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupCrashlytics();

  await setupServiceLocator();
  await dotenv.load(fileName: ".env");
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final firebaseMessagingService = sl<FirebaseMessagingService>();

  LocalNotificationService.initialize();
  firebaseMessagingService.initialize();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print("FCM Token: $fcmToken");
  }
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

