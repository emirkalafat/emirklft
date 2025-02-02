import 'package:blog_web_site/models/version.dart';
import 'package:blog_web_site/screens/projects/project_details_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/firestore/versions/versions_repository.dart';

final versionsProvider =
    StreamProvider.family((ref, ProjectDetailsInfoModel searchModel) {
  final versionsController = ref.watch(versionsControllerProvider.notifier);
  return versionsController.getAppVersions(
      searchModel.storageID, searchModel.showBetaVersions);
});

final versionsFutureProvider =
    FutureProviderFamily((ref, ProjectDetailsInfoModel searchModel) async {
  final versionsController = ref.watch(versionsControllerProvider.notifier);
  return await versionsController.getFutureAppVersion(
      searchModel.storageID, searchModel.showBetaVersions);
});

final versionsControllerProvider =
    StateNotifierProvider<VersionsController, bool>((ref) {
  final versionsRepository = ref.watch(versionsRepositoryProvider);
  return VersionsController(versionsRepository: versionsRepository, ref: ref);
});

class VersionsController extends StateNotifier<bool> {
  final VersionsRepository _versionsRepository;
  final Ref _ref;
  VersionsController(
      {required VersionsRepository versionsRepository, required Ref ref})
      : _versionsRepository = versionsRepository,
        _ref = ref,
        super(false);

  Stream<List<Version>> getAppVersions(
      String storageID, bool showBetaVersions) {
    return _versionsRepository.getAppVersions(storageID, showBetaVersions);
  }

  Future<List<Version>> getFutureAppVersion(
      String storageID, bool showBetaVersions) async {
    return await _versionsRepository.getFutureAppVersion(
        storageID, showBetaVersions);
  }

  //Future<void> addVersion(String id, Version version) async {
  //  await _versionsRepository.addVersion(id, version);
  //}
}
