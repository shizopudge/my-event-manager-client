import 'package:bloc/bloc.dart';
import 'package:client/data/friends/repository/friends_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../data/user/models/user.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsRepository friendsReposiotry;
  FriendsBloc({required this.friendsReposiotry}) : super(FriendsState()) {
    on<FriendsGetFriendsEvent>(_getFriends);
    on<FriendsDeleteFromFriendsEvent>(_deleteFromFriends);
  }

  Future _getFriends(
      FriendsGetFriendsEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<User> friends =
          await friendsReposiotry.getFriends(event.userId);
      emit(
        state.copyWith(friends: friends, isLoading: false),
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

  Future _deleteFromFriends(
      FriendsDeleteFromFriendsEvent event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await friendsReposiotry.deleteFromFriends(event.uid, event.friendId);
      final List<User> friends = await friendsReposiotry.getFriends(event.uid);
      emit(
        state.copyWith(friends: friends, isLoading: false),
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
