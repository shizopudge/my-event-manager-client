part of 'event_bloc.dart';

class EventState {
  final Event? event;
  final bool isLoading;
  final bool isError;
  EventState({
    this.event,
    this.isLoading = false,
    this.isError = false,
  });

  EventState copyWith({
    Event? event,
    bool isLoading = false,
    bool isError = false,
  }) {
    return EventState(
      event: event ?? this.event,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
