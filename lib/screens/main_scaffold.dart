import 'package:blog_web_site/screens/contact.dart';
import 'package:blog_web_site/screens/hakkimda.dart';
import 'package:blog_web_site/screens/home_screen.dart';
import 'package:blog_web_site/screens/projects_screen.dart';
import 'package:blog_web_site/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../widgets/closable_search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.initialIndex, required this.projects})
      : super(key: key);

  final int initialIndex;
  final List<Map<String, dynamic>> projects;

  final List<String> menuItems = [
    'Ana Sayfa',
    'Hakkımda',
    'Projelerim',
    'İletişim',
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
        location: index == 3
            ? '/?tab=contact'
            : index == 2
                ? '/?tab=projects'
                : index == 1
                    ? '/?tab=about'
                    : '/?tab=home',
      ),
      rebuild: false,
    );
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmall = ResponsiveWidget.isSmallScreen(context);
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final onSurface = colorScheme.onSurface;
    return Scaffold(
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
                          index == 0
                              ? Icons.home
                              : index == 1
                                  ? Icons.person
                                  : index == 2
                                      ? Icons.work
                                      : Icons.contact_mail,
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
      appBar: AppBar(
        centerTitle: ResponsiveWidget.isSmallScreen(context),
        title: InkWell(
          child: const Text("Ahmet Emir Kalafat"),
          onTap: () {
            onPageNameTap(0);
          },
        ),
        actions: ResponsiveWidget.isSmallScreen(context)
            ? null
            : [
                for (int i = 1; i < widget.menuItems.length; i++)
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
        index: currentIndex,
        children: [
          const AnaSayfa(),
          const HakkimdaPage(),
          MyProjectsPage(projects: widget.projects),
          const ContactWithMe(),
        ],
      ),
    );
  }
}
