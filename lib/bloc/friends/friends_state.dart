part of 'friends_bloc.dart';

class FriendsState {
  final List<User>? friends;
  final bool isLoading;
  final bool isError;
  FriendsState({
    this.friends,
    this.isLoading = false,
    this.isError = false,
  });

  FriendsState copyWith({
    List<User>? friends,
    bool isLoading = false,
    bool isError = false,
  }) {
    return FriendsState(
      friends: friends ?? this.friends,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
