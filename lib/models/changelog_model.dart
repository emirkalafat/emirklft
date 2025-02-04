import 'dart:convert';

class Changelog {
  String id;
  String storageID;
  String name;
  String explanation;
  String? image;
  String? googlePlayLink;
  String? appStoreLink;
  String? githubLink;
  Map<String, dynamic>? additionalLinks;
  Changelog({
    required this.id,
    required this.storageID,
    required this.name,
    required this.explanation,
    this.image,
    this.googlePlayLink,
    this.appStoreLink,
    this.githubLink,
    this.additionalLinks,
  });

  Changelog copyWith({
    String? id,
    String? storageID,
    String? name,
    String? explanation,
    String? image,
    String? googlePlayLink,
    String? appStoreLink,
    String? githubLink,
    Map<String, dynamic>? additionalLinks,
  }) {
    return Changelog(
      id: id ?? this.id,
      storageID: storageID ?? this.storageID,
      name: name ?? this.name,
      explanation: explanation ?? this.explanation,
      image: image ?? this.image,
      googlePlayLink: googlePlayLink ?? this.googlePlayLink,
      appStoreLink: appStoreLink ?? this.appStoreLink,
      githubLink: githubLink ?? this.githubLink,
      additionalLinks: additionalLinks ?? this.additionalLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storageID': storageID,
      'name': name,
      'explanation': explanation,
      'image': image,
      'googlePlayLink': googlePlayLink,
      'appStoreLink': appStoreLink,
      'githubLink': githubLink,
      'additionalLinks': additionalLinks,
    };
  }

  factory Changelog.fromMap(Map<String, dynamic> map) {
    return Changelog(
      id: map['id'],
      storageID: map['storageID'],
      name: map['name'] ?? '',
      explanation: map['explanation'] ?? '',
      image: map['image'] ?? '',
      googlePlayLink: map['googlePlayLink'],
      appStoreLink: map['appStoreLink'],
      githubLink: map['githubLink'],
      additionalLinks: map['additionalLinks'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Changelog.fromJson(String source) =>
      Changelog.fromMap(json.decode(source));
}
