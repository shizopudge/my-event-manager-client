import 'package:flutter/material.dart';

import '../core/style.dart';

class ProfileTextField extends StatefulWidget {
  final String? text;
  final IconData icon;
  final String label;
  const ProfileTextField({
    super.key,
    required this.text,
    required this.icon,
    required this.label,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blueGrey.shade900,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: AppTheme.mainStyle,
          prefixIcon: Icon(
            widget.icon,
            size: 32,
            color: Colors.white,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: AppTheme.mainStyle,
          suffixIcon: InkWell(
            radius: 32,
            borderRadius: BorderRadius.circular(21),
            onTap: () {},
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 26,
            ),
          ),
          errorStyle: AppTheme.hintStyle.copyWith(color: Colors.red.shade300),
        ),
        style: AppTheme.mainStyle,
        initialValue: widget.text,
      ),
    );
  }
}
