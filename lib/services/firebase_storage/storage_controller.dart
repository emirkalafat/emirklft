import 'package:blog_web_site/services/firebase_storage/storage_repository.dart';
import 'package:blog_web_site/core/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogPostsFuture = FutureProvider((ref) async {
  final storageController = ref.watch(storageControllerProvider.notifier);
  return await storageController.blogPosts;
});

final storageControllerProvider = StateNotifierProvider((ref) {
  final storageRepository = ref.watch(firebaseStorageProvider);
  return StorageController(storageRepository: storageRepository);
});

class StorageController extends StateNotifier<bool> {
  final StorageRepository _storageRepository;

  StorageController({
    required StorageRepository storageRepository,
  })  : _storageRepository = storageRepository,
        super(false);

  Future<Map<String, FullMetadata>> get blogPosts async {
    final res = await _storageRepository.blogPosts;
    return res.fold(
      (l) => Utils.showSnackBar(l.message),
      (r) {
        return r;
      },
    );
  }
}
