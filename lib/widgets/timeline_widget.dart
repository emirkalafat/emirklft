import 'dart:math';

import 'package:blog_web_site/core/theme.dart';
import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final String event;
  final String year;

  const TimelineWidget({
    super.key,
    required this.event,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 350,
      height: 250,
      child: Card(
        color: Theme.of(context).brightness == Brightness.dark
            ? darkGreenPalette
                .elementAt(Random().nextInt(darkGreenPalette.length))
            : lightGreenPalette
                .elementAt(Random().nextInt(lightGreenPalette.length)),
        child: Padding(
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
                  color: colorScheme.onSurface,
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
        ),
      ),
    );
  }
}
