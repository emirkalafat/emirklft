import 'package:beamer/beamer.dart';
import 'package:blog_web_site/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

import 'avatar_textbox.dart';
import 'search_bar.dart';

Widget buildAppBar(BuildContext context, int selectedIndex) {
  var screenSize = MediaQuery.of(context).size;
  return Container(
    constraints: const BoxConstraints(maxHeight: 900, minHeight: 700),
    width: screenSize.width,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/background.jpg'),
      ),
    ),
    child: Stack(
      children: [
        AvatarAndTextBox(screenSize: screenSize),
        Positioned(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 860, maxWidth: 639),
          ),
        ),
        Positioned(
          bottom: 0,
          child: MyAppBar(currentIndex: selectedIndex),
        ),
      ],
    ),
  );
}

class MyAppBar extends StatefulWidget {
  int currentIndex;

  MyAppBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  var isSearching = false;

  onPageNameTap(int index) {
    Beamer.of(context).update(
      configuration: RouteInformation(
        location: index == 2
            ? '/?tab=projects'
            : index == 1
                ? '/?tab=about'
                : '/?tab=home',
      ),
      rebuild: false,
    );
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                        setState(() {
                          isSearching = true;
                        });
                      },
                      icon: const Icon(Icons.search),
                    ),
            ],
    );
  }
}

class Menu extends StatefulWidget {
  Menu({super.key, required this.currentIndex});
  int currentIndex = 0;

  static const List<String> menuItems = [
    'Hakkımda',
    'Projelerim',
    'İletişim',
    'Lisanslar',
  ];

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  onPageNameTap(int index) {
    Beamer.of(context).update(
      configuration: RouteInformation(
        location: index == 2
            ? '/?tab=projects'
            : index == 1
                ? '/?tab=about'
                : '/?tab=home',
      ),
      rebuild: false,
    );
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(maxWidth: 1110),
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: List.generate(
          Menu.menuItems.length,
          (index) => buildMenuItem(index),
        ),
      ),
    );
  }

  Widget buildMenuItem(int index) => TextButton(
        onPressed: () {
          onPageNameTap(1);
        },
        child: Text(
          Menu.menuItems[index],
        ),
      );
}
