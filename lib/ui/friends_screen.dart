import 'package:client/bloc/event/event_bloc.dart';
import 'package:client/bloc/friends/friends_bloc.dart';
import 'package:client/data/events/models/event.dart';
import 'package:client/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/style.dart';
import '../data/user/models/user.dart';
import '../widgets/search_box.dart';
import '../widgets/user_widget.dart';

class FriendsScreen extends StatefulWidget {
  final String uid;
  final List<EventMember> eventMembers;
  final String? eventId;
  const FriendsScreen({
    super.key,
    required this.uid,
    this.eventMembers = const [],
    this.eventId,
  });

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> eventMemberIds = [];
  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(
          FriendsGetFriendsEvent(
            userId: widget.uid,
          ),
        );
    if (widget.eventMembers.isNotEmpty) {
      for (EventMember member in widget.eventMembers) {
        eventMemberIds.add(member.user.id);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final bool isLoading = context.select<FriendsBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final List<User> friends = context.select<FriendsBloc, List<User>>(
      (bloc) => bloc.state.friends ?? [],
    );
    final bool isError =
        context.select<FriendsBloc, bool>((bloc) => bloc.state.isError);
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
              onTap: () => context.read<FriendsBloc>().add(
                    FriendsGetFriendsEvent(
                      userId: widget.uid,
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
    if (friends.isEmpty) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/empty.png',
              height: height * .2,
            ),
            Text(
              'It seems to me or here is somehow empty?',
              textAlign: TextAlign.center,
              style: AppTheme.hintStyle,
            ),
            SubmitButton(
              content: Text(
                'Add friend',
                style: AppTheme.hintStyle,
              ),
              onTap: () {},
              height: height * 0.05,
              width: width,
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            SearchBox(
              controller: _searchController,
              onChanged: (query) {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Sort',
                    style: AppTheme.hintStyle,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  // PopupMenuButton(itemBuilder:(context) {

                  // },)
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.sort_rounded,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final User friend = friends[index];
                    if (eventMemberIds.contains(friend.id)) {
                      return null;
                    } else {
                      return UserWidget(
                        onTap: widget.eventId != null
                            ? () {
                                context.read<EventBloc>().add(
                                      EventAddMemberEvent(
                                        eventId: widget.eventId ?? '',
                                        context: context,
                                        userId: friend.id,
                                        adminId: widget.uid,
                                      ),
                                    );
                                context.pop();
                              }
                            : () => context.goNamed(
                                  'user',
                                  queryParams: {
                                    'id': friend.id,
                                  },
                                ),
                        user: friend,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
