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

  Future<List<Activity>> getActivities() async {
    final snapshot = await activitiesCollection.get();
    return snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList();
  }

  Future<Activity?> getActivity(String id) async {
    final doc = await activitiesCollection.doc(id).get();
    if (!doc.exists) return null;
    return Activity.fromMap(doc.data()!..['id'] = doc.id);
  }

  //Future<void> addActivity(Activity activity) async {
  //  await activitiesCollection.add(activity.toMap());
  //}

  //Future<void> updateActivity(Activity activity) async {
  //  await activitiesCollection.doc(activity.id).update(activity.toMap());
  //}

  //Future<void> deleteActivity(Activity activity) async {
  //  await activitiesCollection.doc(activity.id).delete();
  //}

  CollectionReference<Map<String, dynamic>> get activitiesCollection =>
      _firestore.collection('activities');
}
