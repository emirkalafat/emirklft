import 'dart:convert';

class Version {
  String version;
  String date;
  List<dynamic> changes;
  List<dynamic> fixes;
  Version({
    required this.version,
    required this.date,
    required this.changes,
    required this.fixes,
  });

  Version copyWith({
    String? version,
    String? date,
    List<String>? changes,
    List<String>? fixes,
  }) {
    return Version(
      version: version ?? this.version,
      date: date ?? this.date,
      changes: changes ?? this.changes,
      fixes: fixes ?? this.fixes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'date': date,
      'changes': changes,
      'fixes': fixes,
    };
  }

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(
      version: map['version'],
      date: map['date'],
      changes: map['changes'] ?? [],
      fixes: map['fixes'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Version.fromJson(String source) =>
      Version.fromMap(json.decode(source));
}
