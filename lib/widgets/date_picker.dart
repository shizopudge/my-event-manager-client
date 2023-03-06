import 'package:flutter/material.dart';

import '../core/style.dart';

class TextFieldDateTimePicker extends StatelessWidget {
  final TextEditingController controller;
  final bool isDate;
  final String hint;
  final void Function()? onTap;
  const TextFieldDateTimePicker({
    super.key,
    required this.controller,
    required this.isDate,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.grey.shade900,
            child: TextFormField(
              controller: controller,
              readOnly: true,
              onTap: onTap,
              style: AppTheme.hintStyle,
              decoration: InputDecoration(
                prefixIcon: isDate
                    ? const Icon(
                        Icons.calendar_month,
                      )
                    : const Icon(
                        Icons.timelapse_rounded,
                      ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15),
                hintText: hint,
                hintStyle: AppTheme.hintStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
