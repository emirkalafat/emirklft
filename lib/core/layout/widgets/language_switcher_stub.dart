import 'package:flutter/material.dart';

class LanguageSwitcherStub extends StatelessWidget {
  const LanguageSwitcherStub({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TR',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        Container(
          height: 1,
          width: 16,
          color: Colors.white.withValues(alpha: 0.1),
          margin: const EdgeInsets.symmetric(vertical: 4),
        ),
        Text(
          'EN',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.4),
              ),
        ),
      ],
    );
  }
}
