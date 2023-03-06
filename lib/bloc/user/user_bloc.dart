import 'package:bloc/bloc.dart';
import 'package:client/data/friends/repository/friends_repository.dart';
import 'package:client/data/user/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../data/user/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final FriendsRepository friendsRepository;
  UserBloc({
    required this.userRepository,
    required this.friendsRepository,
  }) : super(UserState()) {
    on<UserGetUserEvent>(_getUser);
  }

  Future _getUser(UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      UserStatus userStatus = UserStatus.notFriends;
      final User user = await userRepository.getUser(event.id);
      final List<String> friendRequest =
          await friendsRepository.getFriendRequests(event.uid);
      final List<String> friendSuggestions =
          await friendsRepository.getFriendSuggestions(event.uid);
      final List<User> friends = await friendsRepository.getFriends(event.uid);
      for (String id in friendRequest) {
        if (event.id == id) {
          userStatus = UserStatus.requestSended;
        }
      }
      for (String id in friendSuggestions) {
        if (event.id == id) {
          userStatus = UserStatus.requestReceived;
        }
      }
      for (User friend in friends) {
        if (event.id == friend.id) {
          userStatus = UserStatus.friends;
        }
      }
      emit(
        state.copyWith(
          user: user,
          isLoading: false,
          userStatus: userStatus,
        ),
      );
    } on DioError catch (e) {
      emit(
        state.copyWith(isError: true),
      );
      throw Exception(e.toString());
    } catch (e) {
      emit(
        state.copyWith(isError: true),
      );
      throw Exception(e.toString());
    }
  }
}
