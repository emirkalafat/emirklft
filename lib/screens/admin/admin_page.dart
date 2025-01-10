import 'package:beamer/beamer.dart';
import 'package:blog_web_site/services/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text('MErhaba'),
          TextButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logOut(context);
                context.popToNamed('/linktree');
                Beamer.of(context).update();
              },
              child: const Text('Çıkış Yap'))
        ],
      ),
    ));
  }
}
