import 'dart:html';

import 'package:blog_web_site/screens/contact.dart';
import 'package:blog_web_site/screens/home_screen.dart';
import 'package:blog_web_site/screens/projects_screen.dart';
import 'package:blog_web_site/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../widgets/closable_search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.initialIndex, required this.projects})
      : super(key: key);

  final int initialIndex;
  final List<Map<String, dynamic>> projects;

  final List<String> menuItems = [
    'Ana Sayfa',
    'Projelerim',
    'İletişim',
  ];

  final List<IconData> menuIcons = [
    Icons.home,
    Icons.work,
    Icons.mail,
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  bool _isScreenSelected(int index) {
    return currentIndex == index;
  }

  onPageNameTap(int index) {
    Beamer.of(context).update(
      configuration: RouteInformation(
        location: index == 2
            ? '/?tab=contact'
            : index == 1
                ? '/?tab=projects'
                : '/?tab=home',
      ),
      rebuild: false,
    );
    setState(() {
      currentIndex = index;
    });
    Navigator.of(context).maybePop();
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final titleQuery = (context.currentBeamLocation.state as BeamState)
        .queryParameters['title'];
    final screenSize = MediaQuery.of(context).size;
    final isSmall = ResponsiveWidget.isSmallScreen(context);
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Arama',
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                  ),
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
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: index == currentIndex
                                    ? primaryColor
                                    : onSurface,
                              ),
                        ),
                        onTap: () {
                          onPageNameTap(index);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info),
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
      appBar: NewGradientAppBar(
        gradient: isSmall
            ? RadialGradient(
                radius: 4,
                colors: [
                  colorScheme.onPrimary,
                  colorScheme.onTertiary,
                ],
              )
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  colorScheme.onPrimary,
                  colorScheme.onPrimary,
                  colorScheme.onTertiary,
                  colorScheme.onTertiary,
                  colorScheme.onTertiary,
                ],
              ),
        centerTitle: ResponsiveWidget.isSmallScreen(context),
        title: InkWell(
          child: Text("Ahmet Emir Kalafat",
              style: TextStyle(color: colorScheme.onPrimaryContainer)),
          onTap: () {
            onPageNameTap(0);
          },
        ),
        actions: ResponsiveWidget.isSmallScreen(context)
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
                    onPressed: () {
                      onPageNameTap(i);
                    },
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
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationVersion: '0.1',
                    );
                  },
                  child: const Text("Lisanslar"),
                ),
                const ClosableSearchBar(),
              ],
      ),
      body: IndexedStack(
        alignment: AlignmentDirectional.center,
        index: currentIndex,
        children: [
          const AnaSayfa(),
          MyProjectsPage(projects: widget.projects),
          const ContactWithMe(),
        ],
      ),
    );
  }
}
