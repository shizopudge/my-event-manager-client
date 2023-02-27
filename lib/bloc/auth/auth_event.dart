part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;

  AuthLoginEvent(
      {required this.context, required this.email, required this.password});
}

class AuthRegistrationEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String username;

  AuthRegistrationEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.context});
}

class AuthLogoutEvent extends AuthEvent {
  final BuildContext context;

  AuthLogoutEvent({required this.context});
}

class AuthRefreshEvent extends AuthEvent {
  final BuildContext context;

  AuthRefreshEvent({required this.context});
}
