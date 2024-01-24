import 'package:flutter/material.dart';

class AnimatedCircularIndicator extends StatelessWidget {
  final double percentage;
  final String title;
  final Widget image;
  const AnimatedCircularIndicator({
    super.key,
    required this.title,
    required this.percentage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: const Duration(seconds: 1),
            builder: (context, double value, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 15,
                    value: value,
                    color: colorScheme.primary,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: image,
                        ),
                        Text('${(value * 100).toInt()}%'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        //const SizedBox(
        //  height: 20,
        //),
        //Padding(
        //  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        //  child: Text(
        //    title,
        //    maxLines: 1,
        //    overflow: TextOverflow.ellipsis,
        //  ),
        //),
      ],
    );
  }
}
