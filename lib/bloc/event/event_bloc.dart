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
    on<EventGetEventEvent>(_getEvent);
    on<EventAddMemberEvent>(_addMember);
    on<EventDeleteMemberEvent>(_deleteMember);
    on<EventFinishEventEvent>(_finishEvent);
    on<EventDeleteEventEvent>(_deleteEvent);
  }

  Future _createEvent(
      EventCreateEventEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final Event createdEvent = await eventsReposiotry.createEvent(
        eventDate: event.eventDate,
        type: event.type,
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

  Future _getEvent(EventGetEventEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final Event receivedEvent = await eventsReposiotry.getCertainEvent(
        event.eventId,
      );
      final bool isAdmin = await eventsReposiotry.isAdmin(
        uid: event.userId,
        eventId: event.eventId,
      );
      emit(
        state.copyWith(
          event: receivedEvent,
          isAdmin: isAdmin,
          isLoading: false,
        ),
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

  Future _finishEvent(
      EventFinishEventEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await eventsReposiotry.finishEvent(
        eventId: event.eventId,
      );
      final Event receivedEvent = await eventsReposiotry.getCertainEvent(
        event.eventId,
      );
      final bool isAdmin = await eventsReposiotry.isAdmin(
        uid: event.adminId,
        eventId: event.eventId,
      );
      emit(
        state.copyWith(
          event: receivedEvent,
          isAdmin: isAdmin,
          isLoading: false,
        ),
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

  Future _deleteEvent(
      EventDeleteEventEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await eventsReposiotry.deleteEvent(
        eventId: event.eventId,
        userId: event.userId,
      );
      emit(
        state.copyWith(
          isLoading: false,
        ),
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

  Future _addMember(EventAddMemberEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await eventsReposiotry.addMember(
        userId: event.userId,
        eventId: event.eventId,
        adminId: event.adminId,
      );
      final Event receivedEvent = await eventsReposiotry.getCertainEvent(
        event.eventId,
      );
      final bool isAdmin = await eventsReposiotry.isAdmin(
        uid: event.adminId,
        eventId: event.eventId,
      );
      emit(
        state.copyWith(
          event: receivedEvent,
          isAdmin: isAdmin,
          isLoading: false,
        ),
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

  Future _deleteMember(
      EventDeleteMemberEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await eventsReposiotry.deleteMember(
        userId: event.userId,
        eventId: event.eventId,
        adminId: event.adminId,
      );
      final Event receivedEvent = await eventsReposiotry.getCertainEvent(
        event.eventId,
      );
      final bool isAdmin = await eventsReposiotry.isAdmin(
        uid: event.adminId,
        eventId: event.eventId,
      );
      emit(
        state.copyWith(
          event: receivedEvent,
          isAdmin: isAdmin,
          isLoading: false,
        ),
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
