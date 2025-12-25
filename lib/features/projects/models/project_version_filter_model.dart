class ProjectVersionFilterModel {
  String storageID;
  bool showBetaVersions;
  ProjectVersionFilterModel({
    required this.storageID,
    required this.showBetaVersions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectVersionFilterModel &&
        other.storageID == storageID &&
        other.showBetaVersions == showBetaVersions;
  }

  @override
  int get hashCode => storageID.hashCode ^ showBetaVersions.hashCode;
}
