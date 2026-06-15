import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:flutter/material.dart';

class CustomScaffoldMessenger {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primaryLight,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
      ),
    );
  }
}
