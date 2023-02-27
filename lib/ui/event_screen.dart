import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final String? id;
  const EventScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(id ?? 'ok'),
      ),
      body: Container(),
    );
  }
}
