import 'package:flutter/material.dart';

import 'app_text_field.dart';

class CustomInputDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String confirmText;
  final String? initialValue;
  final void Function(String) onConfirm;
  final Widget? extraContent;

  const CustomInputDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.confirmText,
    required this.onConfirm,
    this.initialValue,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue ?? "");

    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: controller,
              hintText: hintText,
            ),
            if (extraContent != null) ...[
              const SizedBox(height: 16),
              extraContent!,
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: Theme.of(context).textTheme.titleLarge),
        ),
        TextButton(
          onPressed: () {
            final text = controller.text.trim();
            if (text.isNotEmpty) {
              onConfirm(text);
            }
          },
          child: Text(confirmText, style: Theme.of(context).textTheme.titleLarge),
        ),
      ],
    );
  }
}
