import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../values/values.dart';
import 'page_list_tiles.dart';

class SideArea extends ConsumerStatefulWidget {
  const SideArea({
    Key? key,
    required this.controller,
    required this.selectedPageNameProvider,
  }) : super(key: key);

  final AnimateIconController controller;
  final StateProvider<String> selectedPageNameProvider;
  @override
  ConsumerState<SideArea> createState() => _SideAreaState();
}

class _SideAreaState extends ConsumerState<SideArea> {
  @override
  Widget build(BuildContext context) {
    final selectedPageName =
        ref.watch(widget.selectedPageNameProvider.state).state;
    bool onThemePressed() {
      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
          ? AdaptiveTheme.of(context).setLight()
          : AdaptiveTheme.of(context).setDark();
      return true;
      //Navigator.of(context).pop();
    }

    void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
      // only change the state if we have selected a different page
      if (ref.read(widget.selectedPageNameProvider.state).state != pageName) {
        ref.read(widget.selectedPageNameProvider.state).state = pageName;
        //close drawer on screen select when screen has drawer
        if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
          Navigator.of(context).pop();
        }
      }
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                const DrawerHeader(
                  child: CircleAvatar(
                    maxRadius: 48,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
                for (var pageName in availablePages.keys)
                  PageListTile(
                    pageName: pageName,
                    selectedPageName: selectedPageName,
                    onPressed: () => _selectPage(context, ref, pageName),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                ElevatedButton.icon(
                  icon: AnimateIcons(
                    startIcon:
                        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.sunny,
                    endIcon:
                        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                            ? Icons.dark_mode
                            : Icons.sunny,
                    controller: widget.controller,
                    onStartIconPress: onThemePressed,
                    onEndIconPress: onThemePressed,
                    duration: const Duration(milliseconds: 500),
                    clockwise: false,
                    startIconColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                    endIconColor:
                        Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                  onPressed: onThemePressed,
                  label: const Text("Temayı Değiştir"),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AboutListTile(
                    icon: Icon(Icons.favorite),
                    //applicationIcon: Icon(Icons.favorite),
                    applicationName: StringConst.appName,
                    applicationVersion: StringConst.appVersion,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
