import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/timeline_widget.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    const timeline = AppConstants.timeline;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
          children: List.generate(
              timeline.length,
              (index) => DelayedWidget(
                    from: DelayFrom.top,
                    delayDuration: Duration(milliseconds: 2000 + (200 * index)),
                    child: TimelineWidget(
                      event: timeline.values.elementAt(index),
                      year: timeline.keys.elementAt(index),
                    ),
                  ))),
    );
  }
}
