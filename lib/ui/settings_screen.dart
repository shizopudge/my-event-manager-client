import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppTheme.mainStyle,
        ),
      ),
      body: Center(
        child: Text(
          'Settings',
          style: AppTheme.mainStyle,
        ),
      ),
    );
  }
}
