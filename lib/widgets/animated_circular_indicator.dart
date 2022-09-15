import 'package:flutter/material.dart';

class AnimatedCircularIndicator extends StatelessWidget {
  final double percentage;
  final String title;
  const AnimatedCircularIndicator({
    Key? key,
    required this.title,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: const Duration(seconds: 1),
            builder: (context, double value, child) {
              return Stack(fit: StackFit.expand, children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  value: value,
                  color: colorScheme.primary,
                ),
                Center(child: Text('${(value * 100).toInt()}%')),
              ]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
