import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      shadowColor: Colors.blueAccent
    ),
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
      color: Colors.grey,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    appBarTheme: const AppBarTheme(
      color: AppColors.cyanColor,
      elevation: 5,
    ),
    primaryIconTheme: const IconThemeData(
      color: AppColors.blueAccentColor,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData _darkTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadePageTransitionsBuilder(),
        TargetPlatform.iOS: FadePageTransitionsBuilder(),
      },
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
    brightness: Brightness.dark,
    primaryColor: AppColors.blueColor,
    drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.black,
        elevation: 0,
        shadowColor: Colors.black12
    ),
    primaryIconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: AppColors.whiteColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlueColor,
      unselectedItemColor: AppColors.unSelectedBottomBarColorDark,
      selectedItemColor: AppColors.pinkColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 5,
    ),
    cardColor: AppColors.blueColor,
    scaffoldBackgroundColor: Colors.white10,
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black26,
      contentTextStyle: const TextStyle(color: Colors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
