import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({super.key, required this.label, required this.progress});

  final String label;
  final String progress;

  double _getProgressValue(String progress) {
    final parts = progress.split('/');
    final current = double.tryParse(parts[0]) ?? 0;
    final total = double.tryParse(parts[1]) ?? 1;
    return current / total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Text(progress, style: const TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: _getProgressValue(progress),
          minHeight: 8,
          backgroundColor: AppColors.pinkColor,
          color: AppColors.blueAccentColor,
          borderRadius: BorderRadius.circular(15),
        ),
      ],
    );
  }
}
