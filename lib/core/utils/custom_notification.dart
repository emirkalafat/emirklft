import 'package:flutter/material.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    super.key,
    required this.message,
    this.isError = false,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colorScheme.onPrimaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}
