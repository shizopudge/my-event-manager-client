part of 'user_bloc.dart';

class UserState {
  final User? user;
  final UserStatus? userStatus;
  final bool isLoading;
  final bool isError;
  UserState({
    this.user,
    this.userStatus = UserStatus.notFriends,
    this.isLoading = false,
    this.isError = false,
  });

  UserState copyWith({
    User? user,
    UserStatus? userStatus = UserStatus.notFriends,
    bool isLoading = false,
    bool isError = false,
  }) {
    return UserState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
