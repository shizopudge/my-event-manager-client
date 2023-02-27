import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 8,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: AppTheme.hintStyle.copyWith(fontSize: 16),
        ),
      ),
    );
}
