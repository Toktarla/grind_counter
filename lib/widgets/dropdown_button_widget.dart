import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/data/local/app_database.dart';
import '../config/app_colors.dart';
import '../config/di/injection_container.dart';
import '../providers/theme_provider.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const DropdownButtonWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final db = sl<AppDatabase>();
    return FutureBuilder<List<ExerciseType>>(
      future: db.getAllExerciseTypes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        }
        if (!snapshot.hasData || (snapshot.data ?? []).isEmpty) {
          return const SizedBox(
            height: 40,
            child: Center(child: Text('No exercises available')),
          );
        }
        final types = snapshot.data ?? [];
        final validValue = types.any((e) => e.name == value) ? value : types.first.name;
        return DropdownButton<String>(
          value: validValue,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
          alignment: Alignment.centerLeft,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          items: types.map((exerciseType) {
            return DropdownMenuItem(
              value: exerciseType.name,
              child: Text(
                exerciseType.name,
                style: TextStyle(
                  fontSize: 24,
                  color: Provider.of<ThemeProvider>(context).currentTheme.brightness == Brightness.light
                      ?  AppColors.blueColor
                      : AppColors.pinkColor,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
