import 'package:blog_web_site/core/providers/error_provider.dart';
import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/services/firestore/activities/activities_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesStreamProvider = StreamProvider<List<Activity>>((ref) {
  final activitiesController = ref.watch(activitiesControllerProvider.notifier);
  return activitiesController.getActivitiesStream();
});

final activitiesProvider = FutureProvider<List<Activity>>((ref) {
  final activitiesController = ref.watch(activitiesControllerProvider.notifier);
  return activitiesController.getFutureActivities();
});

final activityProvider = FutureProvider.family<Activity?, String>((ref, id) {
  final activitiesController = ref.watch(activitiesControllerProvider.notifier);
  return activitiesController.getActivity(id);
});

final activitiesControllerProvider =
    StateNotifierProvider<ActivitiesController, bool>((ref) {
  final activitiesRepository = ref.watch(activitiesRepositoryProvider);
  return ActivitiesController(
      activitiesRepository: activitiesRepository, ref: ref);
});

class ActivitiesController extends StateNotifier<bool> {
  final ActivitiesRepository _activitiesRepository;
  final Ref _ref;

  ActivitiesController(
      {required ActivitiesRepository activitiesRepository, required Ref ref})
      : _activitiesRepository = activitiesRepository,
        _ref = ref,
        super(false);

  Stream<List<Activity>> getActivitiesStream() {
    return _activitiesRepository.getActivitiesStream();
  }

  Future<List<Activity>> getFutureActivities() async {
    return await _activitiesRepository.getActivities();
  }

  Future<Activity?> getActivity(String id) async {
    return await _activitiesRepository.getActivity(id);
  }

  Future<bool> addActivity(Activity activity) async {
    state = true;
    try {
      await _activitiesRepository.addActivity(activity);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> updateActivity(Activity activity) async {
    state = true;
    try {
      await _activitiesRepository.updateActivity(activity);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> deleteActivity(String id) async {
    state = true;
    try {
      await _activitiesRepository.deleteActivity(id);
      return true;
    } catch (e) {
      _ref.read(errorProvider.notifier).state = e.toString();
      return false;
    } finally {
      state = false;
    }
  }
}
