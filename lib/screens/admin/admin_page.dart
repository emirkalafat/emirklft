import 'package:blog_web_site/screens/admin/dialogs/activity_form_dialog.dart';
import 'package:blog_web_site/screens/admin/dialogs/changelog_form_dialog.dart';
import 'package:blog_web_site/screens/admin/dialogs/version_form_dialog.dart';
import 'package:blog_web_site/screens/admin/tabs/activity_management_tab.dart';
import 'package:blog_web_site/screens/admin/tabs/changelog_management_tab.dart';
import 'package:blog_web_site/screens/admin/tabs/version_management_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:blog_web_site/services/auth/auth_controller.dart';
import 'package:blog_web_site/services/firestore/changelogs/changelogs_controller.dart';
import 'package:blog_web_site/models/changelog_model.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this); // Changed from 2 to 3
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logOut(context);
              context.go('/');
            },
            child: const Text('Çıkış Yap'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Changelog'),
            Tab(text: 'Versions'),
            Tab(text: 'Activities'), // New tab
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChangelogManagementTab(),
          VersionManagementTab(),
          ActivityManagementTab(), // New tab content
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (_tabController.index) {
            case 0:
              showDialog(
                context: context,
                builder: (context) => const ChangelogFormDialog(),
              );
              break;
            case 1:
              if (ref.read(selectedChangelogIdProvider) != null) {
                showDialog(
                  context: context,
                  builder: (context) => VersionFormDialog(
                    storageID: ref.read(selectedChangelogIdProvider)!,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a project first'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              break;
            case 2:
              showDialog(
                context: context,
                builder: (context) => const ActivityFormDialog(),
              );
              break;
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Add a provider for selected changelog
final selectedChangelogIdProvider = StateProvider<String?>((ref) => null);

// Changelog için arama provider'ı ekle (dosyanın üst kısmına)
final changelogSearchQueryProvider = StateProvider<String>((ref) => '');

// Filtrelenmiş changelog'lar için provider
final filteredChangelogsProvider = Provider<AsyncValue<List<Changelog>>>((ref) {
  final changelogsAsync = ref.watch(changelogAllProvider);
  final searchQuery = ref.watch(changelogSearchQueryProvider).toLowerCase();

  return changelogsAsync.when(
    data: (changelogs) {
      if (searchQuery.isEmpty) return AsyncValue.data(changelogs);

      return AsyncValue.data(changelogs.where((changelog) {
        return changelog.name.toLowerCase().contains(searchQuery) ||
            changelog.explanation.toLowerCase().contains(searchQuery) ||
            changelog.storageID.toLowerCase().contains(searchQuery);
      }).toList());
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
