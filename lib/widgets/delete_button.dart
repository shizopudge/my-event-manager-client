import 'package:flutter/material.dart';

import '../core/style.dart';

class DeleteButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double height;
  final double width;
  const DeleteButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 25,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(width, height),
        ),
        child: Text(
          text,
          style: AppTheme.mainStyle,
        ),
      ),
    );
  }
}
