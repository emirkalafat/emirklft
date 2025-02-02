import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/screens/recap/recap.dart';

class MockActivityRepository implements ActivityRepository {
  @override
  List<Activity> getActivities() {
    return [
      Activity(
        id: '1',
        title: 'Puslu Kıtalar Atlası',
        description: 'İhsan Oktay Anar',
        startedDate: DateTime(2025, 1, 1),
        type: ActivityType.book,
        status: ActivityStatus.ongoing,
      ),
      Activity(
        id: '2',
        title: 'Normal People',
        description:
            'Normal People is an Irish romantic psychological drama produced by Element Pictures for BBC and Hulu based on the 2018 novel by Sally Rooney.',
        startedDate: DateTime(2025, 1, 20),
        finishedDate: DateTime(2025, 1, 23),
        type: ActivityType.tvShow,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '3',
        title: 'Dune: Part One',
        description:
            'Denis Villeneuve',
        startedDate: DateTime(2022, 10, 24),
        type: ActivityType.movie,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '4',
        title: 'Dune: Part Two',
        description:
            'Denis Villeneuve',
        startedDate: DateTime(2024, 3, 4),
        type: ActivityType.movie,
        status: ActivityStatus.finished,
      ),
    ];
  }
}
