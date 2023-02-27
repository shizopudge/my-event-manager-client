import 'package:flutter/material.dart';

import '../core/style.dart';

class SubmitButton extends StatelessWidget {
  final Widget content;
  final void Function()? onTap;
  final double height;
  final double width;
  const SubmitButton({
    super.key,
    required this.content,
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
          backgroundColor: Colors.blueGrey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(width, height),
        ),
        child: content,
      ),
    );
  }
}
