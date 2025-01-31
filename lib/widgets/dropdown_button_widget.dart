import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/viewmodels/theme_provider.dart';

import '../config/app_colors.dart';
import '../utils/data.dart';

class DropdownButtonWidget extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  const DropdownButtonWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      isExpanded: true,
      underline: const SizedBox(),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
      alignment: Alignment.centerLeft,
      dropdownColor: Provider.of<ThemeProvider>(context).currentTheme.brightness == Brightness.light
          ?  Colors.white
          : Colors.black,
      items: exercises.map((exercise) {
        return DropdownMenuItem(
          value: exercise,
          child: Text(
            exercise,
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
  }
}
