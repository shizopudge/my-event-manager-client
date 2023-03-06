import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/events/events_bloc.dart';
import '../core/style.dart';

class StatsScreen extends StatefulWidget {
  final String? uid;
  const StatsScreen({
    super.key,
    required this.uid,
  });

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(
          EventsGetUserEventsEvent(
            uid: widget.uid ?? '',
          ),
        );
    context.read<EventsBloc>().add(
          EventsGetFinishedUserEventsEvent(
            uid: widget.uid ?? '',
          ),
        );
    context.read<EventsBloc>().add(
          EventsGetUnfinishedUserEventsEvent(
            uid: widget.uid ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final int? eventsCount =
        context.select<EventsBloc, int?>((bloc) => bloc.state.events?.length);
    final int? finishedEventsCount = context
        .select<EventsBloc, int?>((bloc) => bloc.state.finishedEvents?.length);
    final int? unfinishedEventsCount = context.select<EventsBloc, int?>(
        (bloc) => bloc.state.unfinishedEvents?.length);
    final bool isLoading =
        context.select<EventsBloc, bool>((bloc) => bloc.state.isLoading);
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Statistics',
            style: AppTheme.hintStyle,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        eventsCount.toString(),
                        style: AppTheme.hintStyle.copyWith(
                          color: Colors.yellow.shade200,
                        ),
                      ),
                      Text(
                        'Events',
                        style: AppTheme.smallStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        finishedEventsCount.toString(),
                        style: AppTheme.hintStyle.copyWith(
                          color: Colors.yellow.shade200,
                        ),
                      ),
                      Text(
                        'Finished events',
                        style: AppTheme.smallStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        unfinishedEventsCount.toString(),
                        style: AppTheme.hintStyle.copyWith(
                          color: Colors.yellow.shade200,
                        ),
                      ),
                      Text(
                        'Unfinished events',
                        style: AppTheme.smallStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
