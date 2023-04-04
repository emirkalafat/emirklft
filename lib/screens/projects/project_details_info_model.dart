import 'dart:convert';

class ProjectDetailsInfoModel {
  String storageID;
  bool showBetaVersions;
  ProjectDetailsInfoModel({
    required this.storageID,
    required this.showBetaVersions,
  });

  @override
  String toString() =>
      'ProjectDetailsInfoModel(storageID: $storageID, showBetaVersions: $showBetaVersions)';

  Map<String, dynamic> toMap() {
    return {
      'storageID': storageID,
      'showBetaVersions': showBetaVersions,
    };
  }

  factory ProjectDetailsInfoModel.fromMap(Map<String, dynamic> map) {
    return ProjectDetailsInfoModel(
      storageID: map['storageID'] ?? '',
      showBetaVersions: map['showBetaVersions'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectDetailsInfoModel.fromJson(String source) =>
      ProjectDetailsInfoModel.fromMap(json.decode(source));

  ProjectDetailsInfoModel copyWith({
    String? storageID,
    bool? showBetaVersions,
  }) {
    return ProjectDetailsInfoModel(
      storageID: storageID ?? this.storageID,
      showBetaVersions: showBetaVersions ?? this.showBetaVersions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectDetailsInfoModel &&
        other.storageID == storageID &&
        other.showBetaVersions == showBetaVersions;
  }

  @override
  int get hashCode => storageID.hashCode ^ showBetaVersions.hashCode;
}
