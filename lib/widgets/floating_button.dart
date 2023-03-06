import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddFloatingButton extends StatelessWidget {
  final bool isEvent;
  final double height;
  final double width;
  const AddFloatingButton({
    super.key,
    this.isEvent = false,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (isEvent) {
      return InkWell(
        onTap: () => context.go('/home/create-event'),
        borderRadius: BorderRadius.circular(21),
        child: const Icon(
          Icons.add_circle_rounded,
          size: 60,
          color: Colors.blueGrey,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
