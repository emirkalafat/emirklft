import 'package:blog_web_site/models/version.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/firestore/versions/versions_repository.dart';

final versionsProvider = StreamProvider.family((ref, String id) {
  final versionsController = ref.watch(versionsControllerProvider.notifier);
  return versionsController.getAppVersions(id);
});

final versionsControllerProvider =
    StateNotifierProvider<VersionsController, bool>((ref) {
  final versionsRepository = ref.watch(versionsRepositoryProvider);
  return VersionsController(versionsRepository: versionsRepository);
});

class VersionsController extends StateNotifier<bool> {
  final VersionsRepository _versionsRepository;
  VersionsController({required VersionsRepository versionsRepository})
      : _versionsRepository = versionsRepository,
        super(false);

  Stream<List<Version>> getAppVersions(String id) {
    return _versionsRepository.getAppVersions(id);
  }

  Future<void> addVersion(String id, Version version) async {
    await _versionsRepository.addVersion(id, version);
  }
}
