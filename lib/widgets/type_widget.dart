import 'package:flutter/material.dart';

import '../core/style.dart';

class TypeWidget extends StatelessWidget {
  final String image;
  final String title;
  final String currentType;
  final void Function()? onTap;
  const TypeWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.currentType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      color: currentType == title ? Colors.blueGrey : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: Colors.yellow.shade200,
              height: 26,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: AppTheme.smallStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
