import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_colors.dart';
import '../../../utils/animations/fade_in_transition.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences _prefs;

  ThemeProvider(this._prefs) {
    _loadTheme();
  }

  late ThemeData _currentTheme;

  ThemeData get currentTheme => _currentTheme;

  static final ThemeData _lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadePageTransitionsBuilder(),
        TargetPlatform.iOS: FadePageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.blueAccentColor,
    drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        shadowColor: Colors.blueAccent),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.pinkColor;
        } else {
          return AppColors.pinkColor;
        }
      }),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.blueAccentColor;
        } else {
          return AppColors.cyanColor;
        }
      }),
      splashRadius: 28.0,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.blueAccentColor,
    ),
    textTheme: const TextTheme(
      titleLarge:
          TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Nunito'),
      titleMedium:
          TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Nunito'),
      displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.blueAccentColor,
          fontFamily: 'Nunito'),
      displayMedium: TextStyle(
          fontSize: 24,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Nunito'),
      displaySmall:
          TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Nunito'),
    ),
    appBarTheme: const AppBarTheme(
        color: AppColors.brightColor,
        elevation: 5,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Nunito')),
    primaryIconTheme: const IconThemeData(
      color: AppColors.blueAccentColor,
    ),
    cardColor: AppColors.brightColor,
    scaffoldBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      contentTextStyle:
          const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey.withValues(alpha: 0.32);
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.blue;
          }
          return null; // Default color
        },
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.focused)) {
            return Colors.blue.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return Colors.blue.withValues(alpha: 0.08);
          }
          return null;
        },
      ),
    ),
    primaryColorLight: AppColors.brightColor,
    primaryColorDark: AppColors.beautifulWhiteColor,
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.whiteColor,
      elevation: 0
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadePageTransitionsBuilder(),
        TargetPlatform.iOS: FadePageTransitionsBuilder(),
      },
    ),
    textTheme: const TextTheme(
      titleLarge:
          TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Nunito'),
      titleMedium:
          TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Nunito'),
      titleSmall:
          TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Nunito'),
      displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
          fontFamily: 'Nunito'),
      displayMedium: TextStyle(
          fontSize: 24,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Nunito'),
      displaySmall: TextStyle(
          fontSize: 16, color: AppColors.pinkColor, fontFamily: 'Nunito'),
    ),
    brightness: Brightness.dark,
    primaryColor: AppColors.blueColor,
    drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
        shadowColor: Colors.black12),
    primaryIconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: AppColors.whiteColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.blueColor,
      unselectedItemColor: AppColors.unSelectedBottomBarColorDark,
      selectedItemColor: AppColors.pinkColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.pinkColor,
    ),
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: AppColors.whiteColor,
            fontFamily: 'Nunito')),
    cardColor: AppColors.blackBrightColor,
    scaffoldBackgroundColor: AppColors.darkGreyColor,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black26,
      contentTextStyle:
          const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titleTextStyle:
          const TextStyle(color: Colors.white, fontFamily: 'Nunito'),
      elevation: 10,
    ),
    primaryColorLight: AppColors.blackBrightColor,
    primaryColorDark: AppColors.darkGreyColor,
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.darkGreyColor,
      elevation: 0,
    ),
  );

  Future<void> _loadTheme() async {
    final isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    _currentTheme = isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }

  void toggleTheme() {
    final isDarkMode = _currentTheme.brightness == Brightness.dark;
    _prefs.setBool('isDarkMode', !isDarkMode);
    _currentTheme = !isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
