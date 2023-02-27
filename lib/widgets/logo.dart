import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  const Logo({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/logo.png',
      color: Colors.blueGrey.shade500,
      height: height * .15,
    );
  }
}
