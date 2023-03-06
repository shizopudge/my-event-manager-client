import 'package:intl/intl.dart';

const baseUrl = 'http://10.0.2.2:5000';

final DateFormat defaultDateFormat = DateFormat('yMMMEd');

final DateFormat defaultTimeFormat = DateFormat('HH:mm');

const List<String> priorityList = [
  'Low',
  'Medium',
  'High',
  'Very high',
];
