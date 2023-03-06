import 'package:client/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events/events_bloc.dart';
import '../core/style.dart';
import '../core/utils.dart';
import '../data/events/models/event.dart';
import '../widgets/search_box.dart';

class EventsScreen extends StatefulWidget {
  final String uid;
  const EventsScreen({
    super.key,
    required this.uid,
  });

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(
          EventsGetUserEventsEvent(
            uid: widget.uid,
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Event> events = context.watch<EventsBloc>().state.events ?? [];
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final bool isLoading =
        context.select<EventsBloc, bool>((bloc) => bloc.state.isLoading);
    final bool isError =
        context.select<EventsBloc, bool>((bloc) => bloc.state.isError);
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
              onTap: () => context.read<EventsBloc>().add(
                    EventsGetUserEventsEvent(
                      uid: widget.uid,
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
    if (events.isEmpty) {
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
                  scrollDirection: Axis.vertical,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final Event event = events[index];
                    final int color = int.parse(event.color ?? '');
                    final int daysBeforeEvent = daysBetween(
                      DateTime.now(),
                      event.eventDate,
                    );
                    return EventWidget(
                      event: event,
                      color: color,
                      daysBeforeEvent: daysBeforeEvent,
                    );
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
