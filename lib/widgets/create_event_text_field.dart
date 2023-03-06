import 'package:flutter/material.dart';

import '../core/style.dart';

class CreateEventTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDescription;
  final bool isError;
  const CreateEventTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.isDescription = false,
    this.isError = false,
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
              maxLines: isDescription ? 10 : 3,
              maxLength: isDescription ? 200 : 50,
              style: AppTheme.hintStyle,
              decoration: InputDecoration(
                prefixIcon: isError
                    ? Icon(
                        Icons.error,
                        color: Colors.red.shade300,
                      )
                    : null,
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
