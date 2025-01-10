import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'activity.dart';

class RecapScreen extends StatelessWidget {
  const RecapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedActivities = _groupActivitiesByYearAndMonth(getMockActivities());

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
                                final month =
                                    monthActivities.keys.toList()[monthIndex];
                                final activities = monthActivities[month]!;

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          indicatorTheme:
                                              const IndicatorThemeData(
                                            position: 0,
                                            size: 15.0,
                                          ),
                                          connectorTheme:
                                              const ConnectorThemeData(
                                            thickness: 1.5,
                                          ),
                                        ),
                                        builder: TimelineTileBuilder.connected(
                                          connectionDirection:
                                              ConnectionDirection.before,
                                          itemCount: activities.length,
                                          contentsBuilder: (_, activityIndex) {
                                            final activity =
                                                activities[activityIndex];
                                            return _buildActivityContent(activity);
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

  List<Activity> getMockActivities() {
    return [
      Activity(
        id: '1',
        title: 'Puslu Kıtalar Atlası',
        description: 'İhsan Oktay Anar',
        startedDate: DateTime(2025, 1, 1),
        finishedDate: DateTime(2025, 1, 15),
        type: ActivityType.book,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '2',
        title: '1984',
        description: 'George Orwell',
        startedDate: DateTime(2024, 6, 15),
        type: ActivityType.book,
        status: ActivityStatus.ongoing,
      ),
      Activity(
        id: '3',
        title: 'Dune',
        description: 'Frank Herbert',
        startedDate: DateTime(2023, 9, 1),
        finishedDate: DateTime(2023, 9, 30),
        type: ActivityType.movie,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '4',
        title: 'The Last of Us',
        description: 'HBO',
        startedDate: DateTime(2023, 4, 15),
        type: ActivityType.tvShow,
        status: ActivityStatus.ongoing,
      ),
    ];
  }

  Map<int, Map<int, List<Activity>>> _groupActivitiesByYearAndMonth(List<Activity> activities) {
    final groupedByYear = <int, List<Activity>>{};
    for (var activity in activities) {
      final year = activity.startedDate?.year ?? 0;
      groupedByYear.putIfAbsent(year, () => []);
      groupedByYear[year]!.add(activity);
    }

    final groupedByYearAndMonth = <int, Map<int, List<Activity>>>{};
    for (var year in groupedByYear.keys) {
      groupedByYearAndMonth[year] = _groupByMonth(groupedByYear[year]!);
    }

    return groupedByYearAndMonth;
  }

  Map<int, List<Activity>> _groupByMonth(List<Activity> activities) {
    final grouped = <int, List<Activity>>{};
    for (var activity in activities) {
      final month = activity.startedDate?.month ?? 0;
      grouped.putIfAbsent(month, () => []);
      grouped[month]!.add(activity);
    }
    return grouped;
  }

  Color _getActivityTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.book:
        return Colors.blue;
      case ActivityType.movie:
        return Colors.red;
      case ActivityType.tvShow:
        return Colors.purple;
      case ActivityType.other:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getActivityTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.book:
        return Icons.book;
      case ActivityType.movie:
        return Icons.movie;
      case ActivityType.tvShow:
        return Icons.tv;
      case ActivityType.other:
        return Icons.category;
      default:
        return Icons.category;
    }
  }

  Widget _buildActivityContent(Activity activity) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getActivityTypeIcon(activity.type),
                color: _getActivityTypeColor(activity.type),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              if (activity.status == ActivityStatus.ongoing)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Devam ediyor',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(activity.description),
          const SizedBox(height: 4),
          Text(
            '${_formatDate(activity.startedDate)} - ${activity.status == ActivityStatus.finished ? _formatDate(activity.finishedDate) : 'Devam ediyor'}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    final months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return months[month - 1];
  }
}
