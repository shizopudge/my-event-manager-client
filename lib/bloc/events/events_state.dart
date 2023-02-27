// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'events_bloc.dart';

class EventsState {
  final List<Event>? events;
  final bool isLoading;
  final bool isError;
  EventsState({
    this.events,
    this.isLoading = false,
    this.isError = false,
  });

  EventsState copyWith({
    List<Event>? events,
    bool isLoading = false,
    bool isError = false,
  }) {
    return EventsState(
      events: events ?? this.events,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
