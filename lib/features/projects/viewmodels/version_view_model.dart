import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_web_site/core/providers/error_provider.dart';
import '../models/project_version_filter_model.dart';
import '../models/version_model.dart';
import '../repositories/versions_repository.dart';

final versionsProvider =
    StreamProvider.family((ref, ProjectVersionFilterModel searchModel) {
  final versionsController = ref.watch(versionsControllerProvider.notifier);
  return versionsController.getAppVersions(
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

  Stream<List<VersionModel>> getAppVersions(
      String storageID, bool showBetaVersions) {
    return _versionsRepository.getAppVersions(storageID, showBetaVersions);
  }

  Future<List<VersionModel>> getFutureAppVersion(
      String storageID, bool showBetaVersions) async {
    return await _versionsRepository.getFutureAppVersion(
        storageID, showBetaVersions);
  }

  Future<bool> addVersion(String storageID, VersionModel version) async {
    state = true;
    try {
      await _versionsRepository.addVersion(storageID, version);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> updateVersion(
      String storageID, String versionId, VersionModel version) async {
    state = true;
    try {
      await _versionsRepository.updateVersion(storageID, versionId, version);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> deleteVersion(String storageID, String versionId) async {
    state = true;
    try {
      await _versionsRepository.deleteVersion(storageID, versionId);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }
}
