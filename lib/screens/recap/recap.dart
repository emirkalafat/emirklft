import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class RecapScreen extends StatelessWidget {
  const RecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedActivities = _groupActivitiesByYear();

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Recap')),
      body: ListView.builder(
        itemCount: groupedActivities.keys.length,
        itemBuilder: (context, index) {
          final year = groupedActivities.keys.toList()[index];
          final activities = groupedActivities[year]!;
          return _YearCard(year: year, activities: activities);
        },
      ),
    );
  }
}

class _YearCard extends StatelessWidget {
  const _YearCard({required this.year, required this.activities});

  final int year;
  final List<_Activity> activities;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360.0,
        child: Card(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '$year',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const Divider(height: 1.0),
              _ActivitiesTimeline(activities: activities),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivitiesTimeline extends StatelessWidget {
  const _ActivitiesTimeline({required this.activities});

  final List<_Activity> activities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: const Color(0xff989898),
          indicatorTheme: const IndicatorThemeData(
            position: 0,
            size: 20.0,
          ),
          connectorTheme: const ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: activities.length,
          contentsBuilder: (_, index) {
            final activity = activities[index];
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(activity.description),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            return const OutlinedDotIndicator(borderWidth: 2.5);
          },
          connectorBuilder: (_, index, ___) => const SolidLineConnector(),
        ),
      ),
    );
  }
}

// Mock data
Map<int, List<_Activity>> _groupActivitiesByYear() {
  final activities = [
    _Activity(
      title: 'Puslu Kıtalar Atlası',
      description: 'İhsan Oktay Anar',
      date: DateTime(2025, 1, 1),
    ),
    _Activity(
      title: '1984',
      description: 'George Orwell',
      date: DateTime(2024, 6, 15),
    ),
    _Activity(
      title: 'Dune',
      description: 'Frank Herbert',
      date: DateTime(2023, 9, 1),
    ),
    _Activity(
      title: 'Hayvan Çiftliği',
      description: 'George Orwell',
      date: DateTime(2023, 4, 15),
    ),
  ];

  final grouped = <int, List<_Activity>>{};
  for (var activity in activities) {
    final year = activity.date.year;
    grouped.putIfAbsent(year, () => []);
    grouped[year]!.add(activity);
  }

  return grouped;
}

class _Activity {
  const _Activity({
    required this.title,
    required this.description,
    required this.date,
  });

  final String title;
  final String description;
  final DateTime date;
}
