import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/services/providers.dart';

import '../models/project_detail_model.dart';

final projectDetailsRepositoryProvider = Provider((ref) {
  return ProjectDetailsRepository(firestore: ref.watch(firestoreProvider));
});

class ProjectDetailsRepository {
  final FirebaseFirestore _firestore;

  ProjectDetailsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<ProjectDetailModel>> getProjectByID(String id) {
    return _firestore
        .collection('showcase_apps')
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProjectDetailModel.fromJson(doc.data()))
            .toList());
  }

  CollectionReference<Map<String, dynamic>> get showcaseappsCollection =>
      _firestore.collection('showcase_apps');
}
