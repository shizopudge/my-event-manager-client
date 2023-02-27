part of 'auth_bloc.dart';

class AuthState {
  final User? user;
  final bool isLoggedIn;
  final bool isLoading;
  final bool isError;

  AuthState({
    this.user,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.isError = false,
  });

  AuthState copyWith({
    User? user,
    bool isLoggedIn = false,
    bool isLoading = false,
    bool isError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoggedIn: isLoggedIn,
      isLoading: isLoading,
      isError: isError,
    );
  }
}
