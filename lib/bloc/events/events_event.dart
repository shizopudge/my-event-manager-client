part of 'events_bloc.dart';

@immutable
abstract class EventsEvent {}

class EventsGetUserEventsEvent extends EventsEvent {
  final String uid;

  EventsGetUserEventsEvent({required this.uid});
}
