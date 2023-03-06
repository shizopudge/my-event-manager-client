part of 'events_bloc.dart';

class EventsState {
  final List<Event>? events;
  final List<Event>? finishedEvents;
  final List<Event>? unfinishedEvents;
  final bool isLoading;
  final bool isError;
  EventsState({
    this.events,
    this.finishedEvents,
    this.unfinishedEvents,
    this.isLoading = false,
    this.isError = false,
  });

  EventsState copyWith({
    List<Event>? events,
    List<Event>? finishedEvents,
    List<Event>? unfinishedEvents,
    bool isLoading = false,
    bool isError = false,
  }) {
    return EventsState(
      events: events ?? this.events,
      finishedEvents: finishedEvents ?? this.finishedEvents,
      unfinishedEvents: unfinishedEvents ?? this.unfinishedEvents,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
