import 'package:flutter/material.dart';

import 'animated_circular_indicator.dart';

class MySkills extends StatelessWidget {
  const MySkills({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AnimatedCircularIndicator(
              title: 'Flutter',
              percentage: 0.75,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AnimatedCircularIndicator(
              title: 'Java',
              percentage: 0.8,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AnimatedCircularIndicator(
              title: 'Python',
              percentage: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AnimatedCircularIndicator(
              title: 'C',
              percentage: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
