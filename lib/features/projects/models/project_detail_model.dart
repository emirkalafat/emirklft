class ProjectDetailModel {
  final String id;
  final String name;
  final String explanation;
  final String? googlePlayLink;
  final String? appStoreLink;
  final Map<String, String>? additionalLinks;
  final String storageID;

  ProjectDetailModel({
    required this.id,
    required this.name,
    required this.explanation,
    this.googlePlayLink,
    this.appStoreLink,
    this.additionalLinks,
    required this.storageID,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      explanation: json['explanation'] ?? '',
      googlePlayLink: json['googlePlayLink'],
      appStoreLink: json['appStoreLink'],
      additionalLinks: Map<String, String>.from(json['additionalLinks'] ?? {}),
      storageID: json['storageID'] ?? '',
    );
  }
}
