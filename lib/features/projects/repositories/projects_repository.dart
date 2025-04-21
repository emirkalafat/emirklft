import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/providers.dart';

import '../models/project_model.dart';

final projectsRepositoryProvider = Provider((ref) {
  return ProjectsRepository(firestore: ref.watch(firestoreProvider));
});


class ProjectsRepository {
  final FirebaseFirestore _firestore;

  ProjectsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<ProjectModel>> getChangelogByID(String id) {
    return showcaseCollection.where('id', isEqualTo: id).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data())).toList());
  }

  Stream<List<ProjectModel>> get changelogAll =>
      showcaseCollection.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ProjectModel.fromMap(doc.data())).toList());

  CollectionReference<Map<String, dynamic>> get showcaseCollection =>
      _firestore.collection('showcase_apps');

  Future<void> addChangelog(ProjectModel changelog) async {
    await showcaseCollection.doc(changelog.id).set(changelog.toMap());
  }

  Future<void> updateChangelog(ProjectModel changelog) async {
    await showcaseCollection.doc(changelog.id).update(changelog.toMap());
  }

  Future<void> deleteChangelog(String id) async {
    await showcaseCollection.doc(id).delete();
  }
}