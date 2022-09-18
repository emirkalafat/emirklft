import 'package:flutter/material.dart';

import 'animated_circular_indicator.dart';

class MySkills extends StatelessWidget {
  const MySkills({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GridView.count(
      mainAxisSpacing: 20,
      //scrollDirection: Axis.horizontal,
      crossAxisCount: screenSize.width > 1000 ? 4 : 2,
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedCircularIndicator(
            title: 'Flutter',
            percentage: 0.75,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedCircularIndicator(
            title: 'Java',
            percentage: 0.8,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedCircularIndicator(
            title: 'Python',
            percentage: 0.6,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: AnimatedCircularIndicator(
            title: 'C',
            percentage: 0.8,
          ),
        ),
      ],
    );
  }
}
