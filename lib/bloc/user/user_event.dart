part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetUserEvent extends UserEvent {
  final String id;
  final String uid;

  UserGetUserEvent({
    required this.id,
    required this.uid,
  });
}
