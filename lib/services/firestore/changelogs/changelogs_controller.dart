import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changelogProvider = StreamProvider.family((ref, String id) {
  final changelogController = ref.watch(changelogsControllerProvider.notifier);
  return changelogController.getChangelogByID(id);
});

final changelogAllProvider = StreamProvider((ref) {
  final changelogController = ref.watch(changelogsControllerProvider.notifier);
  return changelogController.changelogAll;
});

final changelogsControllerProvider =
    StateNotifierProvider<ChangelogsController, bool>((ref) {
  final changelogsRepository = ref.watch(changelogsRepositoryProvider);
  return ChangelogsController(changelogsRepository: changelogsRepository);
});

class ChangelogsController extends StateNotifier<bool> {
  final ChangelogsRepository _changelogsRepository;
  ChangelogsController({required ChangelogsRepository changelogsRepository})
      : _changelogsRepository = changelogsRepository,
        super(false);

  Stream<List<Changelog>> getChangelogByID(String id) {
    return _changelogsRepository.getChangelogByID(id);
  }

  Stream<List<Changelog>> get changelogAll {
    return _changelogsRepository.changelogAll;
  }
}
