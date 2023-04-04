import 'package:blog_web_site/models/changelog_model.dart';
import 'package:blog_web_site/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final changelogsRepositoryProvider = Provider((ref) {
  return ChangelogsRepository(firestore: ref.watch(firestoreProvider));
});

class ChangelogsRepository {
  final FirebaseFirestore _firestore;

  ChangelogsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<Changelog>> getChangelogByID(String id) {
    return showcaseCollection.where('id', isEqualTo: id).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Changelog.fromMap(doc.data())).toList());
  }

  Stream<List<Changelog>> get changelogAll =>
      showcaseCollection.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Changelog.fromMap(doc.data())).toList());

  CollectionReference<Map<String, dynamic>> get showcaseCollection =>
      _firestore.collection('showcase_apps');
}
