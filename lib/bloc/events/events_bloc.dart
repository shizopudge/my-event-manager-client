import 'package:bloc/bloc.dart';
import 'package:client/data/events/repository/events_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../data/events/models/event.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsReposiotry eventsReposiotry;
  EventsBloc({
    required this.eventsReposiotry,
  }) : super(EventsState()) {
    on<EventsGetUserEventsEvent>(_getUserEvents);
  }

  Future _getUserEvents(
      EventsGetUserEventsEvent event, Emitter<EventsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<Event> events =
          await eventsReposiotry.getUserEvents(event.uid);
      emit(
        state.copyWith(events: events, isLoading: false),
      );
    } on DioError catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
