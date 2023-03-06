import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const SearchBox({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          border: InputBorder.none,
          suffixIcon: const Icon(
            Icons.search,
          ),
          hintText: 'Search',
          hintStyle: AppTheme.hintStyle,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
