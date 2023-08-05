import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import 'package:blog_web_site/core/string_extensions.dart';

class WeatherSideCard extends StatefulWidget {
  final double width;
  final double height;
  const WeatherSideCard({
    Key? key,
    this.width = 180,
    this.height = 380,
  }) : super(key: key);

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
        konum?.latitude ?? 41.0111, konum?.longitude ?? 28.9711);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (w == null) ...[
                const Icon(Icons.location_disabled),
                const SizedBox(height: 8),
                const Text(
                  'Konum Bilgisi Alınamadı',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Geolocator.requestPermission();
                      getLocation();
                      setState(() {});
                    },
                    child: const Text('Tekrar Dene')),
              ],
              if (w != null) ...[
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
                Text(
                  w!.weatherDescription!.toTitleCase(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text('Konum: ${w?.areaName ?? ''} ${w?.country ?? ''}'),
                const SizedBox(height: 8),
                Text(
                  'Nem Oranı: ${w?.humidity ?? ''}',
                  style: bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rüzgar Hızı: ${w?.windSpeed ?? ''} m/s',
                  style: bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Rüzgar Açısı: ${w?.windDegree ?? ''}',
                  style: bodySmall,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
