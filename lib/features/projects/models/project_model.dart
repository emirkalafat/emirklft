import 'dart:convert';

class ProjectModel {
  String id;
  String storageID;
  String name;
  String explanation;
  String? image;
  String? category;
  List<String>? stack;
  String? variant; // 'featured', 'tile', 'split'
  String? googlePlayLink;
  String? appStoreLink;
  String? githubLink;
  Map<String, dynamic>? additionalLinks;

  ProjectModel({
    required this.id,
    required this.storageID,
    required this.name,
    required this.explanation,
    this.image,
    this.category,
    this.stack,
    this.variant,
    this.googlePlayLink,
    this.appStoreLink,
    this.githubLink,
    this.additionalLinks,
  });

  ProjectModel copyWith({
    String? id,
    String? storageID,
    String? name,
    String? explanation,
    String? image,
    String? category,
    List<String>? stack,
    String? variant,
    String? googlePlayLink,
    String? appStoreLink,
    String? githubLink,
    Map<String, dynamic>? additionalLinks,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      storageID: storageID ?? this.storageID,
      name: name ?? this.name,
      explanation: explanation ?? this.explanation,
      image: image ?? this.image,
      category: category ?? this.category,
      stack: stack ?? this.stack,
      variant: variant ?? this.variant,
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
      'category': category,
      'stack': stack,
      'variant': variant,
      'googlePlayLink': googlePlayLink,
      'appStoreLink': appStoreLink,
      'githubLink': githubLink,
      'additionalLinks': additionalLinks,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'] ?? '',
      storageID: map['storageID'] ?? '',
      name: map['name'] ?? '',
      explanation: map['explanation'] ?? '',
      image: map['image'],
      category: map['category'],
      stack: map['stack'] != null ? List<String>.from(map['stack']) : null,
      variant: map['variant'],
      googlePlayLink: map['googlePlayLink'],
      appStoreLink: map['appStoreLink'],
      githubLink: map['githubLink'],
      additionalLinks: map['additionalLinks'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source));
}
