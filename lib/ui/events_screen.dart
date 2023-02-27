import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events/events_bloc.dart';
import '../core/style.dart';
import '../data/events/models/event.dart';

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
  void didUpdateWidget(covariant EventsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    context.read<EventsBloc>().add(
          EventsGetUserEventsEvent(
            uid: widget.uid,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final List<Event> events = context.watch<EventsBloc>().state.events ?? [];
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final bool isLoading =
        context.select<EventsBloc, bool>((bloc) => bloc.state.isLoading);
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    if (events.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'It seems to me or here is somehow empty?',
            textAlign: TextAlign.center,
            style: AppTheme.hintStyle,
          ),
        ],
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final Event event = events[index];
          final int color = int.parse(event.color ?? '');
          return Container(
            height: height * .3,
            width: width * .2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueGrey.shade900,
                  Colors.grey.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: event.isFinished
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.grey,
                          ),
                        ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      event.priority,
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
