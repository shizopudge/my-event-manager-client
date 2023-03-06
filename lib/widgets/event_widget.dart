import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../core/style.dart';
import '../data/events/models/event.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final int color;
  final int daysBeforeEvent;

  const EventWidget({
    super.key,
    required this.event,
    required this.color,
    required this.daysBeforeEvent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(
        'event',
        queryParams: {
          'id': event.id,
        },
      ),
      borderRadius: BorderRadius.circular(21),
      child: Container(
        margin: const EdgeInsets.all(5),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (event.picture != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CachedNetworkImage(
                  imageUrl: '$baseUrl/${event.picture}',
                  imageBuilder: (context, imageProvider) {
                    return CircleAvatar(
                      radius: 24,
                      backgroundImage: imageProvider,
                    );
                  },
                  placeholder: (context, url) => CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade700,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade700,
                    child: const Icon(
                      Icons.error,
                      size: 32,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.title,
                textAlign: TextAlign.center,
                style: AppTheme.hintStyle,
              ),
            ),
            if (event.isFinished)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The event is finished!',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ],
              ),
            Divider(
              color: Color(color),
              thickness: 1.5,
            ),
            event.description.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      event.description,
                      textAlign: TextAlign.justify,
                      style: AppTheme.smallStyle,
                    ),
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                event.isFinished
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.grey.shade700,
                        ),
                      ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/${event.type}.png',
                      height: 24,
                      color: Colors.yellow.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.type,
                        style: AppTheme.smallStyle,
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
                        style: AppTheme.smallStyle,
                      ),
                    ),
                    Icon(
                      Icons.people,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.priority,
                        style: AppTheme.smallStyle,
                      ),
                    ),
                    if (event.priority == 'Low')
                      const Icon(
                        Icons.label_important,
                        color: Colors.grey,
                      ),
                    if (event.priority == 'Medium')
                      const Icon(
                        Icons.label_important,
                        color: Colors.yellow,
                      ),
                    if (event.priority == 'High')
                      const Icon(
                        Icons.label_important,
                        color: Colors.orange,
                      ),
                    if (event.priority == 'Very high')
                      const Icon(
                        Icons.label_important,
                        color: Colors.red,
                      ),
                  ],
                ),
              ],
            ),
            if (event.isFinished)
              const SizedBox()
            else if (daysBeforeEvent == 0 &&
                timeBefore(event.eventDate).isNotEmpty &&
                timeBefore(event.eventDate) != 'started')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.alarm,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The event will start in ${timeBefore(event.eventDate)}!',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ],
              )
            else if (daysBeforeEvent == 0 &&
                timeBefore(event.eventDate) == 'started')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timelapse,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The event is already started',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ],
              )
            else if (daysBeforeEvent == 0 &&
                timeBefore(event.eventDate).isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timelapse,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The event is passed',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ],
              )
            else if (daysBeforeEvent < 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timelapse,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'The event is passed',
                      style: AppTheme.smallStyle,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          defaultDateFormat.format(event.eventDate),
                          style: AppTheme.smallStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Days before event:',
                        style: AppTheme.smallStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          daysBeforeEvent.toString(),
                          style: AppTheme.smallStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
