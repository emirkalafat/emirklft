import 'package:beamer/beamer.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/utils.dart';
import '../../services/providers.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
        auth: ref.read(authProvider),
        showAuthActionSwitch: false,
        headerBuilder: (context, constraints, shrinkOffset) {
          return Center(
            child: Text(
              'Ahmet Emir Kalafat Admin Giriş',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 24),
            ),
          );
        },
        actions: [
          AuthStateChangeAction<AuthFailed>((context, state) => showTopSnackBar(
                Overlay.of(context),
                CustomNotification(
                  message: state.exception.toString(),
                ),
              )),
          AuthStateChangeAction<SignedIn>((context, state) {
            Beamer.of(context).popToNamed('/admin');
            Beamer.of(context).update();
          }),
        ]);
  }
}
