import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

class RecapScreen extends StatelessWidget {
  const RecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedActivities = _Activity.groupActivitiesByYearAndMonth();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SizedBox(
              width: 400.0,
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  color: Colors.blue,
                  indicatorTheme: const IndicatorThemeData(
                    position: 0,
                    size: 30.0,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 3.0,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  itemCount: groupedActivities.length,
                  contentsBuilder: (_, yearIndex) {
                    final year = groupedActivities.keys.toList()[yearIndex];
                    final monthActivities = groupedActivities[year]!;
                    
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$year',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                              nodePosition: 0,
                              color: Colors.grey,
                              indicatorTheme: const IndicatorThemeData(
                                position: 0,
                                size: 20.0,
                              ),
                              connectorTheme: const ConnectorThemeData(
                                thickness: 2.0,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemCount: monthActivities.length,
                              contentsBuilder: (_, monthIndex) {
                                final month = monthActivities.keys.toList()[monthIndex];
                                final activities = monthActivities[month]!;
                                
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getMonthName(month),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      FixedTimeline.tileBuilder(
                                        theme: TimelineThemeData(
                                          nodePosition: 0,
                                          color: Colors.grey.shade400,
                                          indicatorTheme: const IndicatorThemeData(
                                            position: 0,
                                            size: 15.0,
                                          ),
                                          connectorTheme: const ConnectorThemeData(
                                            thickness: 1.5,
                                          ),
                                        ),
                                        builder: TimelineTileBuilder.connected(
                                          connectionDirection: ConnectionDirection.before,
                                          itemCount: activities.length,
                                          contentsBuilder: (_, activityIndex) {
                                            final activity = activities[activityIndex];
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
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
                                                  Text(activity.description),
                                                ],
                                              ),
                                            );
                                          },
                                          indicatorBuilder: (_, index) =>
                                              const OutlinedDotIndicator(),
                                          connectorBuilder: (_, index, ___) =>
                                              const SolidLineConnector(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) =>
                                  const OutlinedDotIndicator(borderWidth: 2.0),
                              connectorBuilder: (_, index, ___) =>
                                  const SolidLineConnector(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  indicatorBuilder: (_, index) =>
                      const OutlinedDotIndicator(borderWidth: 3.0),
                  connectorBuilder: (_, index, ___) =>
                      const SolidLineConnector(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    final months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return months[month - 1];
  }
}

// Mock data
class _Activity {
  const _Activity({
    required this.title,
    required this.description,
    required this.date,
  });

  final String title;
  final String description;
  final DateTime date;

  static Map<int, Map<int, List<_Activity>>> groupActivitiesByYearAndMonth() {
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

    final groupedByYear = <int, List<_Activity>>{};
    for (var activity in activities) {
      final year = activity.date.year;
      groupedByYear.putIfAbsent(year, () => []);
      groupedByYear[year]!.add(activity);
    }

    final groupedByYearAndMonth = <int, Map<int, List<_Activity>>>{};
    for (var year in groupedByYear.keys) {
      groupedByYearAndMonth[year] = _groupByMonth(groupedByYear[year]!);
    }

    return groupedByYearAndMonth;
  }

  static Map<int, List<_Activity>> _groupByMonth(List<_Activity> activities) {
    final grouped = <int, List<_Activity>>{};
    for (var activity in activities) {
      final month = activity.date.month;
      grouped.putIfAbsent(month, () => []);
      grouped[month]!.add(activity);
    }

    return grouped;
  }
}
