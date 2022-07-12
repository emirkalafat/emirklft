import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:blog_web_site/color_schemes.dart';
import 'package:blog_web_site/responsive.dart';
import 'package:blog_web_site/widgets/first_page.dart';
import 'package:blog_web_site/widgets/side_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'values/values.dart';

void main() {
  runApp(ProviderScope(child: WebApp()));
}

final availablePages = <String, WidgetBuilder>{
  'First Page': (_) => const FirstPage(),
  'Second Page': (_) => Container(),
};

class WebApp extends ConsumerWidget {
  WebApp({Key? key}) : super(key: key);
  final AnimateIconController controller = AnimateIconController();
  final selectedPageNameProvider = StateProvider<String>((ref) {
    // default value
    return availablePages.keys.first;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
      // watch for state changes inside selectedPageNameProvider
      final selectedPageKey = ref.watch(selectedPageNameProvider.state).state;
      // return the WidgetBuilder using the key as index
      return availablePages[selectedPageKey]!;
    });
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);
    return AdaptiveTheme(
      light: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      dark: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        title: StringConst.appName,
        home: ResponsiveLayout(
          content: selectedPageBuilder(context),
          menu: SideArea(
            controller: controller,
            selectedPageNameProvider: selectedPageNameProvider,
          ),
        ),
      ),
    );
  }
}
