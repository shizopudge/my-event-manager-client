part of 'events_bloc.dart';

@immutable
abstract class EventsEvent {}

class EventsGetUserEventsEvent extends EventsEvent {
  final String uid;

  EventsGetUserEventsEvent({required this.uid});
}

class EventsGetFinishedUserEventsEvent extends EventsEvent {
  final String uid;

  EventsGetFinishedUserEventsEvent({required this.uid});
}

class EventsGetUnfinishedUserEventsEvent extends EventsEvent {
  final String uid;

  EventsGetUnfinishedUserEventsEvent({required this.uid});
}
