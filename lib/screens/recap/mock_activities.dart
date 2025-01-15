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
      Activity(
        id: '5',
        title: 'The Witcher',
        description: 'Netflix',
        startedDate: DateTime(2022, 12, 1),
        finishedDate: DateTime(2023, 1, 15),
        type: ActivityType.tvShow,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '6',
        title: 'The Mandalorian',
        description: 'Disney+',
        startedDate: DateTime(2022, 6, 1),
        finishedDate: DateTime(2022, 6, 30),
        type: ActivityType.tvShow,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '7',
        title: 'The Lord of the Rings',
        description: 'J.R.R. Tolkien',
        startedDate: DateTime(2024, 1, 1),
        finishedDate: DateTime(2024, 2, 15),
        type: ActivityType.movie,
        status: ActivityStatus.finished,
      ),
      Activity(
        id: '8',
        title: 'The Hobbit',
        description: 'J.R.R. Tolkien',
        startedDate: DateTime(2024, 1, 13),
        finishedDate: DateTime(2024, 2, 15),
        type: ActivityType.movie,
        status: ActivityStatus.finished,
      ),
    ];
  }
}