class ProjectDetailModel {
  final String id;
  final String name;
  final String explanation;
  final String? image;
  final String? googlePlayLink;
  final String? appStoreLink;
  final Map<String, String>? additionalLinks;
  final String storageID;

  ProjectDetailModel({
    required this.id,
    required this.name,
    required this.explanation,
    this.image,
    this.googlePlayLink,
    this.appStoreLink,
    this.additionalLinks,
    required this.storageID,
  });

  factory ProjectDetailModel.fromMap(Map<String, dynamic> map) {
    return ProjectDetailModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      explanation: map['explanation'] ?? '',
      image: map['image'],
      googlePlayLink: map['googlePlayLink'],
      appStoreLink: map['appStoreLink'],
      additionalLinks: map['additionalLinks'] != null 
          ? Map<String, String>.from(map['additionalLinks']) 
          : null,
      storageID: map['storageID'] ?? '',
    );
  }
}
