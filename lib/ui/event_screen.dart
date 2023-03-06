import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/bloc/event/event_bloc.dart';
import 'package:client/bloc/events/events_bloc.dart';
import 'package:client/data/events/repository/events_repository.dart';
import 'package:client/ui/friends_screen.dart';
import 'package:client/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth/auth_bloc.dart';
import '../core/constants.dart';
import '../core/style.dart';
import '../data/events/models/event.dart';
import '../widgets/info_title.dart';

class EventScreen extends StatefulWidget {
  final String? id;
  const EventScreen({
    super.key,
    required this.id,
  });

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    final String? uid = context.read<AuthBloc>().state.user?.id;
    context.read<EventBloc>().add(
          EventGetEventEvent(
            eventId: widget.id ?? '',
            context: context,
            userId: uid ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EventState state = context.watch<EventBloc>().state;
    final Event? event =
        context.select<EventBloc, Event?>((bloc) => bloc.state.event);
    final int color = int.parse(event?.color ?? '0');
    final bool isAdmin =
        context.select<EventBloc, bool>((bloc) => bloc.state.isAdmin);
    final String uid = context.select<AuthBloc, String>(
      (bloc) => bloc.state.user?.id ?? '',
    );
    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else if (state.isError) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
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
            ],
          ),
        ),
      );
    } else if (!state.isLoading &&
        !state.isError &&
        color != 0 &&
        event != null) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Color(
                  color,
                ),
                actions: isAdmin && !event.isFinished
                    ? [
                        PopupMenuButton(
                          color: Colors.black,
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              child: InkWell(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return FriendsScreen(
                                      uid: uid,
                                      eventMembers: event.members ?? [],
                                      eventId: event.id,
                                    );
                                  },
                                ),
                                borderRadius: BorderRadius.circular(12),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.person_add_alt_1_rounded,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.edit,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: InkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: Text(
                                      'Do you really want to end the event?',
                                      style: AppTheme.hintStyle,
                                    ),
                                    content: Text(
                                      'After the event ends, you will no longer be able to edit it. You will not be able to undo this action.',
                                      style: AppTheme.smallStyle,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          context.read<EventBloc>().add(
                                                EventFinishEventEvent(
                                                  eventId: event.id,
                                                  context: context,
                                                  adminId: uid,
                                                ),
                                              );
                                          context.pop();
                                        },
                                        isDefaultAction: true,
                                        child: Text(
                                          'Yes',
                                          style: AppTheme.hintStyle,
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          'No',
                                          style: AppTheme.hintStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: InkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: Text(
                                      'Do you really want to delete the event?',
                                      style: AppTheme.hintStyle,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          context.read<EventBloc>().add(
                                                EventDeleteEventEvent(
                                                  eventId: event.id,
                                                  context: context,
                                                  userId: uid,
                                                ),
                                              );
                                          context.read<EventsBloc>().add(
                                                EventsGetUserEventsEvent(
                                                  uid: uid,
                                                ),
                                              );
                                          context.pop();
                                          context.pop();
                                        },
                                        isDefaultAction: true,
                                        child: Text(
                                          'Yes',
                                          style: AppTheme.hintStyle,
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () => context.pop(),
                                        child: Text(
                                          'No',
                                          style: AppTheme.hintStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    : isAdmin && event.isFinished
                        ? [
                            InkWell(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text(
                                    'Do you really want to delete the event?',
                                    style: AppTheme.hintStyle,
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        context.read<EventBloc>().add(
                                              EventDeleteEventEvent(
                                                eventId: event.id,
                                                context: context,
                                                userId: uid,
                                              ),
                                            );
                                        context.read<EventsBloc>().add(
                                              EventsGetUserEventsEvent(
                                                uid: uid,
                                              ),
                                            );
                                        context.pop();
                                        context.pop();
                                      },
                                      isDefaultAction: true,
                                      child: Text(
                                        'Yes',
                                        style: AppTheme.hintStyle,
                                      ),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () => context.pop(),
                                      child: Text(
                                        'No',
                                        style: AppTheme.hintStyle,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  size: 32,
                                ),
                              ),
                            ),
                          ]
                        : null,
                expandedHeight: height * .3,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      event.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: AppTheme.smallStyle,
                    ),
                  ),
                  centerTitle: true,
                  background: event.picture != null
                      ? CachedNetworkImage(
                          imageUrl: '$baseUrl/${event.picture}',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            color: Color(
                              color,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              size: 50,
                            ),
                          ),
                          fit: BoxFit.cover,
                        )
                      : InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 32,
                          ),
                        ),
                ),
                floating: true,
                pinned: true,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    event.isFinished
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 32,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.grey.shade700,
                              size: 32,
                            ),
                          ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/${event.type}.png',
                          height: height * .04,
                          color: Colors.yellow.shade200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            event.type,
                            style: AppTheme.hintStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            event.membersCount.toString(),
                            textAlign: TextAlign.justify,
                            style: AppTheme.hintStyle,
                          ),
                        ),
                        Icon(
                          Icons.people,
                          color: Colors.grey.shade300,
                          size: 32,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            event.priority,
                            style: AppTheme.hintStyle,
                          ),
                        ),
                        if (event.priority == 'Low')
                          const Icon(
                            Icons.label_important,
                            color: Colors.grey,
                            size: 32,
                          ),
                        if (event.priority == 'Medium')
                          const Icon(
                            Icons.label_important,
                            color: Colors.yellow,
                            size: 32,
                          ),
                        if (event.priority == 'High')
                          const Icon(
                            Icons.label_important,
                            color: Colors.orange,
                            size: 32,
                          ),
                        if (event.priority == 'Very high')
                          const Icon(
                            Icons.label_important,
                            color: Colors.red,
                            size: 32,
                          ),
                      ],
                    ),
                  ],
                ),
                if (event.description.isNotEmpty)
                  const InfoTitle(
                    icon: Icons.description,
                    title: 'Description',
                  ),
                if (event.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      event.description,
                      textAlign: TextAlign.justify,
                      style: AppTheme.hintStyle,
                    ),
                  ),
                const InfoTitle(
                  icon: Icons.people,
                  title: 'Members',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: SizedBox(
                    height: height * .12,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: event.members?.length,
                      itemBuilder: (context, index) {
                        final EventMember? member = event.members?[index];
                        return InkWell(
                          onTap: member?.user.id != uid
                              ? () => context.goNamed(
                                    'user',
                                    queryParams: {
                                      'id': member?.user.id,
                                    },
                                  )
                              : null,
                          onLongPress: member?.user.id != event.authorId &&
                                  !event.isFinished
                              ? () => showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: Column(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                '$baseUrl/${member?.user.pic}',
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return CircleAvatar(
                                                radius: 25,
                                                backgroundImage: imageProvider,
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.grey.shade700,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.grey.shade700,
                                              child: const Icon(
                                                Icons.error,
                                                size: 25,
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              member?.user.username ?? '',
                                              style: AppTheme.smallStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Text(
                                        'Member management menu',
                                        style: AppTheme.smallStyle,
                                      ),
                                      actions: [
                                        if (member?.isAdmin == false)
                                          CupertinoDialogAction(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Make admin',
                                                    style: AppTheme.hintStyle,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.admin_panel_settings,
                                                  size: 32,
                                                ),
                                              ],
                                            ),
                                          )
                                        else
                                          CupertinoDialogAction(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Make regular user',
                                                    style: AppTheme.hintStyle,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.admin_panel_settings,
                                                  size: 32,
                                                ),
                                              ],
                                            ),
                                          ),
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            context.read<EventBloc>().add(
                                                  EventDeleteMemberEvent(
                                                    eventId: event.id,
                                                    context: context,
                                                    userId:
                                                        member?.user.id ?? '',
                                                    adminId: uid,
                                                  ),
                                                );
                                            context.pop();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Kick user',
                                                  style: AppTheme.hintStyle,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.door_back_door,
                                                size: 32,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              : null,
                          borderRadius: BorderRadius.circular(21),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: '$baseUrl/${member?.user.pic}',
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 25,
                                        backgroundImage: imageProvider,
                                      );
                                    },
                                    placeholder: (context, url) => CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey.shade700,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.grey.shade700,
                                      child: const Icon(
                                        Icons.error,
                                        size: 25,
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  if (member?.isAdmin == true)
                                    const Icon(
                                      Icons.admin_panel_settings,
                                      color: Colors.blueGrey,
                                    ),
                                  if (member?.isAdmin == false)
                                    const Icon(
                                      Icons.person,
                                      color: Colors.blueGrey,
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  member?.user.username ?? '',
                                  style: AppTheme.smallStyle
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const InfoTitle(
                  icon: Icons.alarm,
                  title: 'Date&Time',
                ),
                Text(
                  'Date: ${defaultDateFormat.format(event.eventDate)}',
                  textAlign: TextAlign.left,
                  style: AppTheme.hintStyle,
                ),
                Text(
                  'Time: ${defaultTimeFormat.format(event.eventDate)}',
                  textAlign: TextAlign.left,
                  style: AppTheme.hintStyle,
                ),
                const InfoTitle(
                  icon: Icons.admin_panel_settings,
                  title: 'Author',
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: '$baseUrl/${event.author?.pic}',
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: imageProvider,
                          );
                        },
                        placeholder: (context, url) => CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade700,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade700,
                          child: const Icon(
                            Icons.error,
                            size: 32,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '@${event.author?.username}',
                              style: AppTheme.hintStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              event.author?.email ?? '',
                              style: AppTheme.hintStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
