import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final String event;
  final String year;

  const TimelineWidget({
    Key? key,
    required this.event,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '• $year •',
            style: TextStyle(
              fontSize: 28,
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            //overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: colorScheme.tertiary,
              thickness: 1,
            ),
          ),
          SelectableText(
            event,
            style: const TextStyle(
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
