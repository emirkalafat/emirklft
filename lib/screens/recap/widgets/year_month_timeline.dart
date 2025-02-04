
// Timeline Widgets
import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/widgets/month_timeline.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class YearMonthTimeline extends StatelessWidget {
  final Map<int, Map<int, List<Activity>>> groupedActivities;
  final Function(Activity)? onActivityTap;

  const YearMonthTimeline({
    super.key,
    required this.groupedActivities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            width: 400.0,
            child: _buildYearTimeline(colorScheme),
          ),
        ),
      ),
    );
  }

  Widget _buildYearTimeline(ColorScheme colorScheme) {
    return FixedTimeline.tileBuilder(
      theme: _getTimelineTheme(colorScheme, isYear: true),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: groupedActivities.length,
        contentsBuilder: _buildYearContent,
        indicatorBuilder: (_, __) =>
            const OutlinedDotIndicator(borderWidth: 3.0),
        connectorBuilder: (_, __, ___) => const SolidLineConnector(),
      ),
    );
  }

  Widget _buildYearContent(BuildContext context, int yearIndex) {
    final year = groupedActivities.keys.toList()[yearIndex];
    final monthActivities = groupedActivities[year]!;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$year',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          const SizedBox(height: 10.0),
          MonthTimeline(
            monthActivities: monthActivities,
            onActivityTap: onActivityTap,
          ),
        ],
      ),
    );
  }

  TimelineThemeData _getTimelineTheme(ColorScheme colorScheme, {bool isYear = false}) {
    return TimelineThemeData(
      nodePosition: 0,
      color: isYear ? colorScheme.primary : Colors.grey,
      indicatorTheme: IndicatorThemeData(
        position: 0,
        size: isYear ? 30.0 : 20.0,
      ),
      connectorTheme: ConnectorThemeData(
        thickness: isYear ? 3.0 : 2.0,
      ),
    );
  }
}
