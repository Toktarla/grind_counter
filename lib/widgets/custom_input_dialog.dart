import 'package:flutter/material.dart';

import 'app_text_field.dart';

class CustomInputDialog extends StatefulWidget {
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
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: controller,
              hintText: widget.hintText,
            ),
            if (widget.extraContent != null) ...[
              const SizedBox(height: 16),
              widget.extraContent!,
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
              widget.onConfirm(text);
            }
          },
          child: Text(widget.confirmText, style: Theme.of(context).textTheme.titleLarge),
        ),
      ],
    );
  }
}
