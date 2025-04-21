import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/error_provider.dart';
import '../models/project_model.dart';
import '../repositories/projects_repository.dart';

final projectsProvider = StreamProvider((ref) {
  final projectsController = ref.watch(projectsControllerProvider.notifier);
  return projectsController.changelogAll;
});

final projectsControllerProvider =
    StateNotifierProvider<ProjectsController, bool>((ref) {
  final projectsRepository = ref.watch(projectsRepositoryProvider);
  return ProjectsController(changelogsRepository: projectsRepository, ref: ref);
});

class ProjectsController extends StateNotifier<bool> {
  final ProjectsRepository _changelogsRepository;
  final Ref _ref;
  ProjectsController(
      {required ProjectsRepository changelogsRepository, required Ref ref})
      : _changelogsRepository = changelogsRepository,
        _ref = ref,
        super(false);

  Stream<List<ProjectModel>> getChangelogByID(String id) {
    return _changelogsRepository.getChangelogByID(id);
  }

  Stream<List<ProjectModel>> get changelogAll {
    return _changelogsRepository.changelogAll;
  }

  Future<bool> addChangelog(ProjectModel changelog) async {
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

  Future<bool> updateChangelog(ProjectModel changelog) async {
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
