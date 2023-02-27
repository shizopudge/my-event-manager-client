part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventCreateEventEvent extends EventEvent {
  final BuildContext context;
  final String title;
  final String description;
  final String color;
  final String priority;
  final String authorId;

  EventCreateEventEvent({
    required this.context,
    required this.title,
    required this.description,
    required this.color,
    required this.priority,
    required this.authorId,
  });
}
