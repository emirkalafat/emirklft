import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import 'package:blog_web_site/core/string_extensions.dart';

class WeatherSideCard extends StatefulWidget {
  const WeatherSideCard({super.key});

  @override
  State<WeatherSideCard> createState() => _WeatherSideCardState();
}

class _WeatherSideCardState extends State<WeatherSideCard> {
  bool isCelcius = true;

  Position? konum;
  late WeatherFactory wf;
  Weather? w;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    konum = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    wf = WeatherFactory("8afeaa7003fbb9940622882daf57b218",
        language: Language.TURKISH);
    w = await wf.currentWeatherByLocation(
        konum?.latitude ?? 41.0111, konum?.altitude ?? 28.9711);
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
                'https://openweathermap.org/img/wn/${w?.weatherIcon ?? '01d'}@2x.png'),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium,
                  text: w != null
                      ? isCelcius
                          ? '${w?.temperature!.celsius!.round()} '
                          : '${w?.temperature!.fahrenheit!.round()} '
                      : '',
                  children: [
                    TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(decoration: TextDecoration.underline),
                        text: isCelcius ? '°C' : '°F',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isCelcius = !isCelcius;
                            });
                          })
                  ]),
            ),
            const SizedBox(height: 8),
            Text(w?.weatherDescription!.toTitleCase() ?? ''),
            const SizedBox(height: 8),
            Text(w?.areaName ?? ''),
            const SizedBox(height: 8),
            Text(w?.country ?? ''),
            const SizedBox(height: 8),
            Text('${w?.humidity ?? ''}'),
            const SizedBox(height: 8),
            Text('${w?.windSpeed ?? ''}'),
            const SizedBox(height: 8),
            Text('${w?.windDegree ?? ''}'),
          ],
        ),
      ),
    );
  }
}
