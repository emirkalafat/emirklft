import 'package:blog_web_site/models/version.dart';
import 'package:blog_web_site/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final versionsRepositoryProvider = Provider((ref) {
  return VersionsRepository(firestore: ref.watch(firestoreProvider));
});

class VersionsRepository {
  final FirebaseFirestore _firestore;

  VersionsRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Stream<List<Version>> getAppVersions(
      String storageID, bool showBetaVersions) {
    if (showBetaVersions) {
      return showcaseappsCollection
          .doc(storageID)
          .collection('versions')
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Version.fromMap(doc.data())).toList();
      });
    } else {
      return showcaseappsCollection
          .doc(storageID)
          .collection('versions')
          .where('isBeta', isEqualTo: false)
          .orderBy('date', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Version.fromMap(doc.data())).toList();
      });
    }
  }

  Future<List<Version>> getFutureAppVersion(
      String storageID, bool showBetaVersions) async {
    return await showcaseappsCollection
        .doc(storageID)
        .collection('versions')
        .orderBy('date', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) => Version.fromMap(doc.data())).toList();
    });
  }

  Future<void> addVersion(String storageID, Version version) async {
    await showcaseappsCollection
        .doc(storageID)
        .collection('versions')
        .add(version.toMap());
  }

  Future<void> updateVersion(String storageID, String versionId, Version version) async {
    await showcaseappsCollection
        .doc(storageID)
        .collection('versions')
        .doc(versionId)
        .update(version.toMap());
  }

  Future<void> deleteVersion(String storageID, String versionId) async {
    await showcaseappsCollection
        .doc(storageID)
        .collection('versions')
        .doc(versionId)
        .delete();
  }

  CollectionReference<Map<String, dynamic>> get showcaseappsCollection {
    return _firestore.collection('showcase_apps');
  }
}
