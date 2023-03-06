part of 'friends_bloc.dart';

@immutable
abstract class FriendsEvent {}

class FriendsGetFriendsEvent extends FriendsEvent {
  final String userId;

  FriendsGetFriendsEvent({required this.userId});
}

class FriendsDeleteFromFriendsEvent extends FriendsEvent {
  final String uid;
  final String friendId;

  FriendsDeleteFromFriendsEvent({
    required this.uid,
    required this.friendId,
  });
}
