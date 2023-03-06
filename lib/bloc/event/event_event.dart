part of 'event_bloc.dart';

@immutable
abstract class EventEvent {}

class EventCreateEventEvent extends EventEvent {
  final BuildContext context;
  final DateTime eventDate;
  final String type;
  final String title;
  final String description;
  final String color;
  final String priority;
  final String authorId;

  EventCreateEventEvent({
    required this.eventDate,
    required this.type,
    required this.context,
    required this.title,
    required this.description,
    required this.color,
    required this.priority,
    required this.authorId,
  });
}

class EventGetEventEvent extends EventEvent {
  final BuildContext context;
  final String eventId;
  final String userId;

  EventGetEventEvent({
    required this.eventId,
    required this.context,
    required this.userId,
  });
}

class EventAddMemberEvent extends EventEvent {
  final BuildContext context;
  final String eventId;
  final String userId;
  final String adminId;

  EventAddMemberEvent({
    required this.eventId,
    required this.context,
    required this.userId,
    required this.adminId,
  });
}

class EventDeleteMemberEvent extends EventEvent {
  final BuildContext context;
  final String eventId;
  final String userId;
  final String adminId;

  EventDeleteMemberEvent({
    required this.eventId,
    required this.context,
    required this.userId,
    required this.adminId,
  });
}

class EventFinishEventEvent extends EventEvent {
  final BuildContext context;
  final String eventId;
  final String adminId;

  EventFinishEventEvent({
    required this.eventId,
    required this.context,
    required this.adminId,
  });
}

class EventDeleteEventEvent extends EventEvent {
  final BuildContext context;
  final String eventId;
  final String userId;

  EventDeleteEventEvent({
    required this.eventId,
    required this.context,
    required this.userId,
  });
}
