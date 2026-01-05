import 'package:flutter/material.dart';

void showCustomSnakcbar(
  BuildContext context,
  String title,
  String subTitle,
  Color backgroundColor,
) {
  final messenger = ScaffoldMessenger.maybeOf(context);

  if (messenger == null) {
    debugPrint("❌ No ScaffoldMessenger found");
    return;
  }

  messenger.clearSnackBars();

  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(subTitle, style: const TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}
