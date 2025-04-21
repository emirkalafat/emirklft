import 'dart:convert';

import 'package:flutter/foundation.dart';

class VersionModel {
  String version;
  String date;
  bool isBeta;
  List<dynamic> changes;
  List<dynamic> fixes;
  VersionModel({
    required this.version,
    required this.date,
    required this.isBeta,
    required this.changes,
    required this.fixes,
  });

  VersionModel.empty({
    this.version = '',
    this.date = '',
    this.isBeta = false,
    this.changes = const [],
    this.fixes = const [],
  });

  VersionModel copyWith({
    String? version,
    String? date,
    bool? isBeta,
    List<dynamic>? changes,
    List<dynamic>? fixes,
  }) {
    return VersionModel(
      version: version ?? this.version,
      date: date ?? this.date,
      isBeta: isBeta ?? this.isBeta,
      changes: changes ?? this.changes,
      fixes: fixes ?? this.fixes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'date': date,
      'isBeta': isBeta,
      'changes': changes,
      'fixes': fixes,
    };
  }

  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      version: map['version'] ?? '',
      date: map['date'] ?? '',
      isBeta: map['isBeta'] ?? false,
      changes: map['changes'] ?? [],
      fixes: map['fixes'] ?? [],
    );
  }

  @override
  String toString() {
    return 'Version(version: $version, date: $date, isBeta: $isBeta, changes: $changes, fixes: $fixes)';
  }

  String toJson() => json.encode(toMap());

  factory VersionModel.fromJson(String source) =>
      VersionModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VersionModel &&
        other.version == version &&
        other.date == date &&
        other.isBeta == isBeta &&
        listEquals(other.changes, changes) &&
        listEquals(other.fixes, fixes);
  }

  @override
  int get hashCode {
    return version.hashCode ^
        date.hashCode ^
        isBeta.hashCode ^
        changes.hashCode ^
        fixes.hashCode;
  }
}
