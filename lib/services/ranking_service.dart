import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_out_app/config/di/injection_container.dart';
import '../data/data.dart';
import '../models/level_data.dart';

class RankingService {
  RankingService();
  
  static final sharedPreferences = sl<SharedPreferences>();
  
  static List<LevelData> generateLevels() {
    List<LevelData> levels = [];

    int titleIndex = 0;
    int colorIndex = 0;

    for (int i = 1; i <= 100; i++) {
      levels.add(LevelData(
        level: i,
        title: rankTitles[titleIndex],
        color: rankBaseColors[colorIndex],
      ));
      if (i % 5 == 0) {
        colorIndex = (colorIndex + 1) % rankBaseColors.length;
        titleIndex = (titleIndex + 1) % rankTitles.length;
      }
    }
    return levels;
  }

  static LevelData getLevelData(int level) {
    List<LevelData> levels = generateLevels();
    return levels.firstWhere((data) => data.level == level);
  }

  static Future<int> getCurrentUserLevel() async {
    final prefs = sharedPreferences;
    return prefs.getInt('userLevel') ?? 1;
  }

  static Future<void> updateUserLevel(int newLevel) async {
    final prefs = sharedPreferences;
    await prefs.setInt('userLevel', newLevel);
  }

  static Future<void> levelUp() async {
    int currentLevel = await getCurrentUserLevel();
    if (currentLevel < 100) {
      await updateUserLevel(currentLevel + 1);
    }
  }

  static Future<void> levelDown() async {
    int currentLevel = await getCurrentUserLevel();
    if (currentLevel > 1) {
      await updateUserLevel(currentLevel - 1);
    }
  }

  static Future<void> addProgress(int points) async {
    final prefs = sharedPreferences;
    int currentProgress = prefs.getInt('userProgress') ?? 0;
    int currentLevel = await getCurrentUserLevel();
    int requiredPoints = 50;

    currentProgress += points;

    while (currentProgress >= requiredPoints) {
      if (currentLevel < 100) {
        await levelUp();
        currentProgress -= requiredPoints;
      } else {
        currentProgress = requiredPoints;
        break;
      }
    }

    await prefs.setInt('userProgress', currentProgress);
  }

  static Future<double> getUserLevelProgress() async {
    final prefs = sharedPreferences;
    int currentProgress = prefs.getInt('userProgress') ?? 0;
    int requiredPoints = 50;

    if (currentProgress == 0) return 0.0;
    return currentProgress / requiredPoints;
  }

  static Future<void> resetUserLevelProgress() async {
    final prefs = sharedPreferences;
    await prefs.setInt('userLevel', 1);
  }
}