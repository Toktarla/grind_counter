import 'package:flutter/material.dart';

class LevelData {
  final int level;
  final String title;
  final Color color;

  LevelData({
    required this.level,
    required this.title,
    this.color = Colors.pink,
  });
}