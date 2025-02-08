import 'package:blog_web_site/core/utils/utils.dart';
import 'package:flutter/material.dart';

class ExternalLinkButton extends StatelessWidget {
  final String url;
  final String label;
  final IconData iconData;

  const ExternalLinkButton({
    required this.url,
    required this.label,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Utils.startUrl(url);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 24.0),
            Text(
              label.toUpperCase(),
              style:  TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
