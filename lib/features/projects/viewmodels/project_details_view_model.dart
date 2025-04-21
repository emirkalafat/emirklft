import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_detail_model.dart';
import '../repositories/project_details_repository.dart';

final projectDetailStreamProvider = StreamProvider.family((ref, String id) {
  final projectDetailsController = ref.watch(projectDetailsControllerProvider.notifier);
  return projectDetailsController.getProjectByID(id);
});

final projectDetailsControllerProvider =
    StateNotifierProvider<ProjectDetailsController, bool>((ref) {
  final projectDetailsRepository = ref.watch(projectDetailsRepositoryProvider);
  return ProjectDetailsController(
    projectDetailsRepository: projectDetailsRepository,
    ref: ref,
  );
});

class ProjectDetailsController extends StateNotifier<bool> {
  final ProjectDetailsRepository _projectDetailsRepository;
  final Ref _ref;

  ProjectDetailsController({
    required ProjectDetailsRepository projectDetailsRepository,
    required Ref ref,
  })  : _projectDetailsRepository = projectDetailsRepository,
        _ref = ref,
        super(false);

  Stream<List<ProjectDetailModel>> getProjectByID(String id) {
    return _projectDetailsRepository.getProjectByID(id);
  }
}
