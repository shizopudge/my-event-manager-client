import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../core/utils.dart';
import '../../data/events/models/event.dart';
import '../../data/events/repository/events_repository.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventsReposiotry eventsReposiotry;
  EventBloc({required this.eventsReposiotry}) : super(EventState()) {
    on<EventCreateEventEvent>(_createEvent);
  }

  Future _createEvent(
      EventCreateEventEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final Event createdEvent = await eventsReposiotry.createEvent(
        title: event.title,
        description: event.description,
        color: event.color,
        priority: event.priority,
        authorId: event.authorId,
      );
      emit(
        state.copyWith(event: createdEvent, isLoading: false),
      );
    } on DioError catch (e) {
      emit(
        state.copyWith(isError: true),
      );
      showSnackBar(event.context, e.toString());
      throw Exception(e.toString());
    } catch (e) {
      emit(
        state.copyWith(isError: true),
      );
      showSnackBar(event.context, e.toString());
      throw Exception(e.toString());
    }
  }
}
