import 'package:blog_web_site/core/providers/error_provider.dart';
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
  return ChangelogsController(
      changelogsRepository: changelogsRepository, ref: ref);
});

class ChangelogsController extends StateNotifier<bool> {
  final ChangelogsRepository _changelogsRepository;
  final Ref _ref;
  ChangelogsController(
      {required ChangelogsRepository changelogsRepository, required Ref ref})
      : _changelogsRepository = changelogsRepository,
        _ref = ref,
        super(false);

  Stream<List<Changelog>> getChangelogByID(String id) {
    return _changelogsRepository.getChangelogByID(id);
  }

  Stream<List<Changelog>> get changelogAll {
    return _changelogsRepository.changelogAll;
  }

  Future<bool> addChangelog(Changelog changelog) async {
    state = true;
    try {
      await _changelogsRepository.addChangelog(changelog);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> updateChangelog(Changelog changelog) async {
    state = true;
    try {
      await _changelogsRepository.updateChangelog(changelog);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> deleteChangelog(String id) async {
    state = true;
    try {
      await _changelogsRepository.deleteChangelog(id);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }
}
