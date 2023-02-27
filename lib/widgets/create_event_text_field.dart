import 'package:flutter/material.dart';

import '../core/style.dart';

class CreateEventTextfield extends StatefulWidget {
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
  State<CreateEventTextfield> createState() => _CreateEventTextfieldState();
}

class _CreateEventTextfieldState extends State<CreateEventTextfield> {
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
            color: Colors.blueGrey.shade900,
            child: TextFormField(
              controller: widget.controller,
              maxLines: widget.isDescription ? 10 : null,
              maxLength: widget.isDescription ? 200 : null,
              style: AppTheme.hintStyle,
              decoration: InputDecoration(
                prefixIcon: widget.isError
                    ? Icon(
                        Icons.error,
                        color: Colors.red.shade300,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(15),
                hintText: widget.hint,
                hintStyle: AppTheme.hintStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
