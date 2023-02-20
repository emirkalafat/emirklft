import 'package:flutter/material.dart';

import '../../widgets/default_widgets.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    Key? key,
    required this.scroll,
  }) : super(key: key);

  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return
        //Material(
        //  child:
        Container(
      constraints: buildDefaultConstraints(
        minHeight: (screenSize.height - 56),
        maxHeight: (screenSize.height - 56),
      ),
      //decoration: BoxDecoration(
      //  color: colorScheme.background,
      //  //image: DecorationImage(
      //  //  image: AssetImage('assets/images/background.jpg'),
      //  //  fit: BoxFit.fill,
      //  //),
      //),
      //color: Colors.black,
      //child: BackdropFilter(
      //  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //  child: Container(
      //    decoration: BoxDecoration(
      //      color: Colors.black.withOpacity(0.0),
      //    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const CircleAvatar(
            radius: 128,
            foregroundImage: AssetImage('assets/images/profile1.jpg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //Spacer(),
              Text(
                "Hoş Geldiniz!",
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  //color: Colors.white,
                ),
              ),
              //Spacer(flex: 2),
            ],
          ),
          const Text(
            "Ben Emir Kalafat\nFlutter Uygulama Geliştirici",
            style: TextStyle(
              //color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
                onPressed: () {
                  scroll.animateTo(screenSize.height - 150,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.ease);
                },
                icon: const Icon(Icons.arrow_downward)),
          )
        ],
      ),
      //),
      //  ),
      //),
    );
  }
}
