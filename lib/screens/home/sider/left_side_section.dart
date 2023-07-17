import 'package:blog_web_site/widgets/delayed_widget.dart';
import 'package:blog_web_site/widgets/home/currency_side_card.dart';
import 'package:blog_web_site/widgets/home/weather_side_card.dart';
import 'package:flutter/material.dart';

class LeftSideSection extends StatelessWidget {
  final double sideSpacing;
  const LeftSideSection({
    Key? key,
    required this.sideSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: sideSpacing,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          DelayedWidget(
            delayDuration: Duration(seconds: 4),
            from: DelayFrom.left,
            child: WeatherSideCard(),
          ),
          SizedBox(height: 16),
          DelayedWidget(
            delayDuration: Duration(seconds: 5),
            from: DelayFrom.left,
            child: CurrencySideCard(),
          ),
        ],
      ),
    );
  }
}
