import 'package:bloc/bloc.dart';
import 'package:client/data/auth/repository/auth_repository.dart';
import 'package:client/data/user/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../core/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<AuthLoginEvent>(_login);
    on<AuthRegistrationEvent>(_registration);
    on<AuthLogoutEvent>(_logout);
    on<AuthRefreshEvent>(_refresh);
  }

  Future _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final User user = await authRepository.login(
          email: event.email, password: event.password);
      emit(state.copyWith(
        user: user,
        isLoggedIn: true,
        isLoading: false,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(isError: true));
      throw Exception(e);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      showSnackBar(event.context, e.toString());
    }
  }

  Future _registration(
      AuthRegistrationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final User user = await authRepository.registration(
          email: event.email,
          password: event.password,
          username: event.username);
      emit(state.copyWith(
        user: user,
        isLoading: false,
        isLoggedIn: true,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(isError: true));
      throw Exception(e);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      showSnackBar(event.context, e.toString());
    }
  }

  Future _logout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authRepository.logout();
      emit(state.copyWith(
        user: null,
        isLoading: false,
        isLoggedIn: false,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(isError: true));
      throw Exception(e);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      showSnackBar(event.context, e.toString());
    }
  }

  Future _refresh(AuthRefreshEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final User user = await authRepository.refresh();
      emit(state.copyWith(
        user: user,
        isLoading: false,
        isLoggedIn: true,
      ));
    } on DioError {
      emit(state.copyWith(isError: true));
      // throw Exception(e);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // throw Exception(e);
    }
  }
}
