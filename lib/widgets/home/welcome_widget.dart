import 'dart:ui';

import 'package:flutter/material.dart';

import '../default_widgets.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    Key? key,
    required this.screenSize,
    required this.scroll,
  }) : super(key: key);

  final Size screenSize;
  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: buildDefaultConstraints(
          minHeight: (screenSize.height - 56),
          maxHeight: (screenSize.height - 56),
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        //color: Colors.black,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    //Spacer(),
                    Text(
                      "Hoş Geldiniz",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    //Spacer(flex: 2),
                  ],
                ),
                const Text(
                  "Flutter ile yazdığım blog sitem.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
          ),
        ),
      ),
    );
  }
}
