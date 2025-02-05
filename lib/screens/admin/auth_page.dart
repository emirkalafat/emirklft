import 'package:go_router/go_router.dart';
import 'package:blog_web_site/screens/admin/admin_page.dart';
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
    if (ref.read(authProvider).currentUser != null) {
      return const AdminPage();
    }

    return SignInScreen(
        auth: ref.read(authProvider),
        showAuthActionSwitch: false,
        providers: [EmailAuthProvider()],
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
            if (context.mounted) {
              context.go('/admin');
            }
          }),
        ]);
  }
}
