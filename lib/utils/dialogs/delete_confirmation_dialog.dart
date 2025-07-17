import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final String title;
  final String contentText;
  final String actionTitle;

  const DeleteConfirmationDialog({super.key,
    required this.onDelete,
    required this.title,
    required this.contentText,
    required this.actionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: AppColors.blueAccentColor),
          ),
        ),
        TextButton(
          onPressed: () {
            onDelete();
          },
          child: Text(actionTitle, style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
