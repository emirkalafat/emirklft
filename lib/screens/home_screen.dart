import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/side_menu.dart';
import '../widgets/utils.dart';

Map<String, String> links = {
  'GitHub': 'https://github.com/emirkalafat',
  'LinkedIn': 'https://www.linkedin.com/in/emir-kalafat/',
  //'Twitter': '',
  'Instagram': 'https://www.secure.instagram.com/garlicmanklft/',
  'Youtube': 'https://www.youtube.com/channel/UCg2As3couk4eZztAgNfowPQ',
};

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        primary: true,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 1500,
                minWidth: 1200,
                maxHeight: screenSize.height - 56),
            child: screenSize.width < 800
                ? const HomeScreenMainSide()
                : Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: MainScreenSideMenu(),
                      ),
                      Expanded(
                        flex: 7,
                        child: HomeScreenMainSide(),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenMainSide extends StatefulWidget {
  const HomeScreenMainSide({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenMainSide> createState() => _HomeScreenMainSideState();
}

class _HomeScreenMainSideState extends State<HomeScreenMainSide> {
  List<Color?> color = List.generate(links.length, (index) => null);

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Hello World!"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (currentTheme.mode == AdaptiveThemeMode.dark) {
                  currentTheme.setThemeMode(AdaptiveThemeMode.light);
                } else {
                  currentTheme.setThemeMode(AdaptiveThemeMode.dark);
                }
              },
              child: const Text("Temayı Değiştir"),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                showTopSnackBar(
                  context,
                  const MyCustomTopBar(
                    message: 'Bildirim Testi',
                  ),
                );
              },
              child: const Text("Notification Test")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                context.beamToNamed('/enfestarifler');
              },
              child: const Text("Enfes Tarifler Gizlilik Sözleşmesi"),
            ),
          ),
          const Spacer(),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('İnternette Ben ve Daha Fazla Ben'),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 45),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              //prototypeItem: CircularProgressIndicator(),

              //NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onHover: (value) {
                    setState(() {
                      color[index] =
                          value ? Colors.blue : colorScheme.onBackground;
                    });
                  },
                  onTap: () {
                    Utils.startUrl(links.values.elementAt(index));
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    //color: Colors.black,
                    child: Text(
                      links.keys.elementAt(index),
                      style: TextStyle(
                          color: color[index] ?? colorScheme.onBackground),
                    ),
                  ),
                ),
              ),
              itemCount: links.length,
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomTopBar extends StatelessWidget {
  const MyCustomTopBar({
    Key? key,
    required this.message,
    this.isError = false,
  }) : super(key: key);

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}
