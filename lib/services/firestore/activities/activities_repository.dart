import 'package:blog_web_site/screens/recap/activity.dart';
import 'package:blog_web_site/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesRepositoryProvider = Provider<ActivitiesRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ActivitiesRepository(firestore: firestore);
});

class ActivitiesRepository {
  final FirebaseFirestore _firestore;

  ActivitiesRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<Activity>> getActivitiesStream() {
    return activitiesCollection
        .orderBy('startedDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Activity.fromMap(doc.data()..['id'] = doc.id))
            .toList());
  }

  Future<List<Activity>> getActivities() async {
    final snapshot = await activitiesCollection
        .orderBy('startedDate', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Activity.fromMap(doc.data()..['id'] = doc.id))
        .toList();
  }

  Future<Activity?> getActivity(String id) async {
    final doc = await activitiesCollection.doc(id).get();
    if (!doc.exists) return null;
    return Activity.fromMap(doc.data()!..['id'] = doc.id);
  }

  Future<void> addActivity(Activity activity) async {
    await activitiesCollection.doc(activity.id).set(activity.toMap());
  }

  Future<void> updateActivity(Activity activity) async {
    await activitiesCollection.doc(activity.id).update(activity.toMap());
  }

  Future<void> deleteActivity(String id) async {
    await activitiesCollection.doc(id).delete();
  }

  CollectionReference<Map<String, dynamic>> get activitiesCollection =>
      _firestore.collection('activities');
}
