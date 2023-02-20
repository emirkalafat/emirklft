import 'package:flutter/material.dart';

import '../../data/database.dart';
import '../../widgets/animated_circular_indicator.dart';
import '../../widgets/default_widgets.dart';

class MySkillsSection extends StatelessWidget {
  const MySkillsSection({
    Key? key,
    required this.verticalScroll,
  }) : super(key: key);

  final ScrollController verticalScroll;

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;
    return Container(
      constraints: buildDefaultConstraints(),
      //color: colorScheme.background,
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 100.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Yeteneklerim",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: screenSize.width - 200,
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /*
                    !Visibility(
                      visible: MediaQuery.of(context).size.width < 1000,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_circle_left),
                        onPressed: () {},
                      ),
                    ),
                    */
                    Flexible(
                      flex: 1,
                      child: Scrollbar(
                        trackVisibility: true,
                        thumbVisibility: true,
                        controller: verticalScroll,
                        interactive: true,
                        child: ListView.builder(
                          controller: verticalScroll,
                          itemCount: skills.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 230,
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: AnimatedCircularIndicator(
                                  title: skills.keys.elementAt(index),
                                  percentage: skills.values.elementAt(index),
                                  image: skillImages[index],
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    //TODO: Üzerinde çalışılacak
                    /*
                    !Visibility(
                      visible: MediaQuery.of(context).size.width < 1000,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_circle_right),
                        onPressed: () {},
                      ),
                    ),
                    */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
