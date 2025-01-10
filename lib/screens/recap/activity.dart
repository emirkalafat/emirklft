import 'dart:convert';

enum ActivityType { book, movie, tvShow, other, unknown }

enum ActivityStatus { ongoing, finished, unknown }


abstract class ActivityRepository {
  List<Activity> getActivities();
}

class Activity {
  String id;
  String title;
  String description;
  String? imageUrl;
  String? url;
  DateTime? startedDate;
  DateTime? finishedDate;

  ActivityStatus status;
  ActivityType type;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.url,
    this.startedDate,
    this.finishedDate,
    this.status = ActivityStatus.unknown,
    this.type = ActivityType.unknown,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? url,
    DateTime? startedDate,
    DateTime? finishedDate,
    ActivityType? type,
    ActivityStatus? status,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
      startedDate: startedDate ?? this.startedDate,
      finishedDate: finishedDate ?? this.finishedDate,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'url': url,
      'startedDate': startedDate?.millisecondsSinceEpoch,
      'finishedDate': finishedDate?.millisecondsSinceEpoch,
      'type': type.name,
      'status': status.name,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      url: map['url'] ?? '',
      startedDate: DateTime.fromMillisecondsSinceEpoch(map['startedDate']),
      finishedDate: DateTime.fromMillisecondsSinceEpoch(map['finishedDate']),
      type: ActivityType.values.firstWhere(
        (element) => element.name == map['type'],
        orElse: () => ActivityType.unknown,
      ),
      status: ActivityStatus.values.firstWhere(
        (element) => element.name == map['status'],
        orElse: () => ActivityStatus.unknown,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Activity(id: $id, title: $title, description: $description, imageUrl: $imageUrl, url: $url, startedDate: $startedDate, finishedDate: $finishedDate, status: $status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.url == url &&
        other.startedDate == startedDate &&
        other.finishedDate == finishedDate &&
        other.status == status &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        url.hashCode ^
        startedDate.hashCode ^
        finishedDate.hashCode ^
        status.hashCode ^
        type.hashCode;
  }
}

class ActivityGrouper {
  static Map<int, Map<int, List<Activity>>> groupByYearAndMonth(
      List<Activity> activities) {
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

  static Map<int, List<Activity>> _groupByMonth(List<Activity> activities) {
    final grouped = <int, List<Activity>>{};
    for (var activity in activities) {
      final month = activity.startedDate?.month ?? 0;
      grouped.putIfAbsent(month, () => []);
      grouped[month]!.add(activity);
    }
    return grouped;
  }
}
