import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blog_web_site/core/theme.dart';
import 'package:blog_web_site/screens/blog/blog.dart';
import 'package:blog_web_site/screens/contact_with_me/contact.dart';
import 'package:blog_web_site/screens/home/home_screen.dart';
import 'package:blog_web_site/screens/projects/projects_screen.dart';
import 'package:blog_web_site/services/firebase_storage/storage_controller.dart';
import 'package:blog_web_site/widgets/animated_opacity_when_hovered.dart';

const _screensToDisplay = [
  AnaSayfa(),
  MyBlog(),
  MyProjectsPage(),
  ContactWithMe(),
];

class HomePage extends ConsumerStatefulWidget {
  HomePage({Key? key, required this.initialIndex}) : super(key: key);

  final int initialIndex;

  final List<String> menuItems = [
    'Ana Sayfa',
    'Blog',
    'Projelerim',
    'İletişim',
  ];

  final List<IconData> menuIcons = [
    Icons.home,
    Icons.article,
    Icons.work,
    Icons.mail,
  ];

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;

  bool _isScreenSelected(int index) => currentIndex == index;

  onPageNameTap(int index) {
    Beamer.of(context).update(
      configuration: RouteInformation(
        location: index == 3
            ? '/?tab=contact'
            : index == 2
                ? '/?tab=projects'
                : index == 1
                    ? '/?tab=blog'
                    : '/?tab=home',
      ),
      rebuild: false,
    );
    setState(() {
      currentIndex = index;
    });
    Navigator.of(context).maybePop();
  }

  void toggleTheme() => ref.read(themeNotifierProvider.notifier).toggleTheme();

  bool get isDark =>
      ref.watch(themeNotifierProvider.notifier).theme == ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    return Scaffold(
      backgroundColor: colorScheme.background,
      endDrawer: isSmall
          ? Drawer(
              child: ListView(
                children: [
                  const SizedBox(height: 48),
                  Column(
                    children: List.generate(widget.menuItems.length, (index) {
                      return ListTile(
                        leading: Icon(
                          widget.menuIcons[index],
                          color:
                              index == currentIndex ? primaryColor : onSurface,
                        ),
                        title: Text(
                          widget.menuItems[index],
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: index == currentIndex
                                        ? primaryColor
                                        : onSurface,
                                  ),
                        ),
                        onTap: () => onPageNameTap(index),
                      );
                    }),
                  ),
                  ListTile(
                    leading: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: colorScheme.onBackground,
                    ),
                    trailing: Switch.adaptive(
                      value: isDark,
                      onChanged: (value) => toggleTheme(),
                    ),
                    title: const Text('Karanlık Tema'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: colorScheme.onBackground,
                    ),
                    title: const Text("Lisanslar"),
                    onTap: () {
                      Navigator.pop(context);
                      showAboutDialog(context: context);
                    },
                  ),
                ],
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: isSmall,
        title: AnimatedOpacityWhenHovered(
          child: GestureDetector(
            child: const Text("Ahmet Emir Kalafat"),
            onTap: () => onPageNameTap(0),
          ),
        ),
        actions: isSmall
            ? null
            : [
                for (int i = 0; i < widget.menuItems.length; i++)
                  //? Sayfa sayısı kadar buton oluşturuyoruz. Bu butonlar seçilen sayfalara gitmemizi sağlıyor.
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          _isScreenSelected(i) ? primaryColor : onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => onPageNameTap(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.menuItems[i]),
                        if (_isScreenSelected(i))
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              width: 20,
                              height: 3,
                            ),
                          )
                      ],
                    ),
                  ),
                //!for döngüsünün sonu
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => showAboutDialog(
                    context: context,
                    applicationVersion: '2.0.0',
                  ),
                  child: const Text("Lisanslar"),
                ),
                IconButton(
                  onPressed: toggleTheme,
                  icon: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: colorScheme.onBackground,
                  ),
                ),
              ],
      ),
      body: _screensToDisplay.elementAt(currentIndex),
      floatingActionButton: Visibility(
        visible: currentIndex == 1,
        child: FloatingActionButton(
          onPressed: currentIndex == 1
              ? () => setState(() => ref.invalidate(blogPostsFuture))
              : null,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
