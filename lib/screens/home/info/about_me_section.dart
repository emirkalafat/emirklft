import 'package:blog_web_site/core/constants.dart';
import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //final screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DelayedWidget(
      from: DelayFrom.top,
      delayDuration: const Duration(milliseconds: 1800),
      child: Card(
        //margin: const EdgeInsets.symmetric(horizontal: 32),
        color: colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Hakkımda",
                  style: textTheme.headlineMedium,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: Divider(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              SelectableText(
                AppConstants.aboutMeText,
                textAlign: TextAlign.center,
                style: textTheme.labelLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
