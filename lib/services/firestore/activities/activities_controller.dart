import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/services/firestore/activities/activities_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesProvider = FutureProvider((ref) {
  final activitiesController = ref.watch(activitiesControllerProvider.notifier);
  return activitiesController.getFutureActivities();
});

final activitiesControllerProvider =
    StateNotifierProvider<ActivitiesController, bool>((ref) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider);
  return ActivitiesController(
      activitiesRepository: activitiesRepository, ref: ref);
});

final activityProvider = FutureProvider.family<Activity?, String>((ref, id) {
  final activitiesController = ref.watch(activitiesControllerProvider.notifier);
  return activitiesController.getActivity(id);
});

class ActivitiesController extends StateNotifier<bool> {
  final ActivitiesRepository _activitiesRepository;
  final Ref _ref;

  ActivitiesController(
      {required ActivitiesRepository activitiesRepository, required Ref ref})
      : _activitiesRepository = activitiesRepository,
        _ref = ref,
        super(false);

  Future<List<Activity>> getFutureActivities() async {
    return await _activitiesRepository.getActivities();
  }

  Future<Activity?> getActivity(String id) async {
    return await _activitiesRepository.getActivity(id);
  }
}
