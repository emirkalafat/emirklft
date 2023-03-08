import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:blog_web_site/services/providers.dart';
import 'package:blog_web_site/core/typedefs/failure.dart';
import 'package:blog_web_site/core/typedefs/type_defs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final firebaseStorageProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putFile(file!);

      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Map<String, FullMetadata>> get blogPosts async {
    Map<String, FullMetadata> dataList = {};
    try {
      final storageRef = _firebaseStorage.ref();
      final list = await storageRef.child('blog').child('posts').list();
      for (var item in list.items) {
        final FullMetadata metadata = await item.getMetadata();
        final data = await item.getData();
        final String s = String.fromCharCodes(data!)
            .replaceAll('ð', 'ğ')
            .replaceAll('þ', 'ş')
            .replaceAll('ý', 'ı')
            .replaceAll('Ý', 'İ');

        dataList.addAll({s: metadata});
      }
      return right(dataList);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  /*
  ///Şimdilik bilgi depolama fonksiyonuna ihtiyaç yok

  FutureEither<String> storeData({
    required String path,
    required String id,
    required Uint8List? data,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      UploadTask uploadTask = ref.putData(data!, metadata);

      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  */
}
