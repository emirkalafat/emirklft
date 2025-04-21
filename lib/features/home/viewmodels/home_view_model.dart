import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/home_model.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomePageModel>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomePageModel> {
  HomeViewModel()
      : super(HomePageModel(
          title: 'Ana Sayfa',
          description: 'Hoş geldiniz',
          featuredContent: [],
        ));

  Future<void> loadHomePageData() async {
    // Firebase veya API çağrıları burada yapılacak
  }
}
