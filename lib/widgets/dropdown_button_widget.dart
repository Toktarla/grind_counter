import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/providers/exercise_type_provider.dart';
import '../config/app_colors.dart';
import '../providers/theme_provider.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const DropdownButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseTypes = context.watch<ExerciseTypeProvider>().exerciseTypes;

    if (exerciseTypes.isEmpty) {
      return const SizedBox(
        height: 40,
        child: Center(child: Text('No exercises available')),
      );
    }

    final validValue = exerciseTypes.any((e) => e.name == value)
        ? value
        : exerciseTypes.first.name;

    final isLight = context.watch<ThemeProvider>().currentTheme.brightness == Brightness.light;
    final textColor = isLight ? AppColors.blueColor : AppColors.pinkColor;

    return DropdownButton<String>(
      value: validValue,
      isExpanded: true,
      underline: const SizedBox(),
      alignment: Alignment.centerLeft,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      items: exerciseTypes.map((exerciseType) {
        return DropdownMenuItem<String>(
          value: exerciseType.name,
          child: Text(
            exerciseType.name,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
