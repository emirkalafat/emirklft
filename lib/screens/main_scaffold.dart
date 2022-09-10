import 'dart:convert';

import 'package:blog_web_site/screens/contact.dart';
import 'package:blog_web_site/screens/hakkimda.dart';
import 'package:blog_web_site/screens/home_screen.dart';
import 'package:blog_web_site/screens/projects_screen.dart';
import 'package:blog_web_site/widgets/responsive_widget.dart';
import 'package:blog_web_site/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:http/http.dart' as http;

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
  bool isSearching = false;

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
    return Scaffold(
      endDrawer: isSmall
          ? Drawer(
              child: ListView(
                children: [
                  const SizedBox(height: 48),
                  buildSearchBar(),
                  Column(
                    children: List.generate(widget.menuItems.length, (index) {
                      return ListTile(
                        title: Text(widget.menuItems[index]),
                        onTap: () {
                          onPageNameTap(index);
                        },
                      );
                    }),
                  ),
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
                TextButton(
                  onPressed: () {
                    onPageNameTap(1);
                  },
                  child: const Text('Hakkımda'),
                ),
                TextButton(
                  onPressed: () {
                    onPageNameTap(2);
                  },
                  child: const Text('Projelerim'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('İletişim'),
                ),
                TextButton(
                  onPressed: () {
                    showAboutDialog(context: context);
                  },
                  child: const Text('Lisanslar'),
                ),
                isSearching
                    ? buildSearchBar()
                    : IconButton(
                        onPressed: () {
                          setState(
                            () {
                              isSearching = true;
                            },
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
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
