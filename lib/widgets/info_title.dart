import 'package:flutter/material.dart';

import '../core/style.dart';

class InfoTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const InfoTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: AppTheme.hintStyle,
            ),
          ),
          Icon(
            icon,
          ),
        ],
      ),
    );
  }
}
