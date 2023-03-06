import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/bloc/friends/friends_bloc.dart';
import 'package:client/bloc/user/user_bloc.dart';
import 'package:client/data/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../core/constants.dart';
import '../core/style.dart';
import '../data/user/models/user.dart';

class UserScreen extends StatefulWidget {
  final String? id;
  const UserScreen({
    super.key,
    required this.id,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    final String? uid = context.read<AuthBloc>().state.user?.id;
    context.read<UserBloc>().add(
          UserGetUserEvent(
            id: widget.id ?? '',
            uid: uid ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = context.select<AuthBloc, String>(
      (bloc) => bloc.state.user?.id ?? '',
    );
    final User? user =
        context.select<UserBloc, User?>((bloc) => bloc.state.user);
    final bool isLoading =
        context.select<UserBloc, bool>((bloc) => bloc.state.isLoading);
    final bool isFriendActionsLoading =
        context.select<UserBloc, bool>((bloc) => bloc.state.isLoading);
    final bool isError =
        context.select<UserBloc, bool>((bloc) => bloc.state.isError);
    final UserStatus userStatus = context.select<UserBloc, UserStatus>(
        (bloc) => bloc.state.userStatus ?? UserStatus.notFriends);
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    if (isError) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 32,
              color: Colors.orange.shade700,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Something went wrong...',
                textAlign: TextAlign.center,
                style: AppTheme.hintStyle,
              ),
            ),
            InkWell(
              onTap: () => context.read<UserBloc>().add(
                    UserGetUserEvent(
                      id: widget.id ?? '',
                      uid: uid,
                    ),
                  ),
              borderRadius: BorderRadius.circular(21),
              child: const Icon(
                Icons.replay_circle_filled_outlined,
                size: 50,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: '$baseUrl/${user?.pic}',
                  imageBuilder: (context, imageProvider) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 120,
                          backgroundImage: imageProvider,
                        ),
                        Positioned(
                          top: 25,
                          right: 10,
                          child: InkWell(
                            onTap: () {},
                            radius: 32,
                            borderRadius: BorderRadius.circular(21),
                            child: Icon(
                              Icons.edit,
                              size: 36,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  placeholder: (context, url) => CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.grey.shade700,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.grey.shade700,
                    child: const Icon(
                      Icons.error,
                      size: 55,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '@${user?.username}',
                  style: AppTheme.mainStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  user?.email ?? '',
                  style: AppTheme.hintStyle,
                ),
              ),
              if (userStatus == UserStatus.friends)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FriendsBloc>().add(
                            FriendsDeleteFromFriendsEvent(
                              uid: uid,
                              friendId: widget.id ?? '',
                            ),
                          );
                      context.read<UserBloc>().add(
                            UserGetUserEvent(id: widget.id ?? '', uid: uid),
                          );
                    },
                    child: isFriendActionsLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Delete from friends',
                            style: AppTheme.smallStyle,
                          ),
                  ),
                )
              else if (userStatus == UserStatus.notFriends)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FriendsBloc>().add(
                            FriendsDeleteFromFriendsEvent(
                              uid: uid,
                              friendId: widget.id ?? '',
                            ),
                          );
                      context.read<UserBloc>().add(
                            UserGetUserEvent(id: widget.id ?? '', uid: uid),
                          );
                    },
                    child: isFriendActionsLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Add to friend',
                            style: AppTheme.smallStyle,
                          ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
