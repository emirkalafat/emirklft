import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:blog_web_site/services/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/utils.dart';

final userProvider = StateProvider<User?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, User?>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  )..appStarted(),
);

class AuthController extends StateNotifier<User?> {
  final AuthRepository _authRepository;
  final Ref _ref;
  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _authRepository.authStateChanges.listen((user) {
      state = user;
      _ref.read(userProvider.notifier).state = user;
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    state = _authRepository.currentUser;
  }

  void logOut(BuildContext context) async {
    final res = await _authRepository.logOut();
    res.fold(
      (l) => showTopSnackBar(
        Overlay.of(context),
        CustomNotification(message: l.message),
      ),
      (r) {
        context.beamToNamed('/auth');
        Beamer.of(context).update();
      },
    );
  }
}
