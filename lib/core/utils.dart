import 'package:client/core/constants.dart';
import 'package:client/core/style.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 8,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: AppTheme.hintStyle.copyWith(fontSize: 16),
        ),
      ),
    );
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String timeBefore(DateTime eventStartTime) {
  DateTime now = DateTime.now();
  if (eventStartTime.difference(now).inMinutes > 0) {
    String timeBeforeEvent =
        '${(eventStartTime.difference(now).inMinutes / 60).round()}:${eventStartTime.difference(now).inMinutes % 60}';
    DateTime timeBefore = defaultTimeFormat.parse(timeBeforeEvent);
    return defaultTimeFormat.format(timeBefore);
  } else if (eventStartTime.difference(now).inMinutes < 0 &&
      eventStartTime.difference(now).inMinutes > -120) {
    return 'started';
  } else {
    return '';
  }
}
