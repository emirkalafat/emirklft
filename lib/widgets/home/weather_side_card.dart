import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

import 'package:blog_web_site/core/string_extensions.dart';

class WeatherSideCard extends StatefulWidget {
  final double width;
  final double height;
  const WeatherSideCard({
    super.key,
    this.width = 180,
    this.height = 380,
  });

  @override
  State<WeatherSideCard> createState() => _WeatherSideCardState();
}

class _WeatherSideCardState extends State<WeatherSideCard> {
  bool isMetric = true;

  Position? konum;
  late WeatherFactory wf;
  Weather? w;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializeWeather();
  }

  Future<void> initializeWeather() async {
    prefs = await SharedPreferences.getInstance();
    wf = WeatherFactory("8afeaa7003fbb9940622882daf57b218",
        language: Language.TURKISH);

    // Check cached location
    final cachedLat = prefs.getDouble('weather_lat');
    final cachedLng = prefs.getDouble('weather_lng');

    if (cachedLat != null && cachedLng != null) {
      try {
        w = await wf.currentWeatherByLocation(cachedLat, cachedLng);
        setState(() {});
      } catch (e) {
        // If cache fetch fails, clear cache
        await prefs.remove('weather_lat');
        await prefs.remove('weather_lng');
      }
    }
  }

  Future<void> getLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return;
      }

      konum = await Geolocator.getCurrentPosition(
          locationSettings: WebSettings(accuracy: LocationAccuracy.low));

      // Cache the location
      await prefs.setDouble('weather_lat', konum!.latitude);
      await prefs.setDouble('weather_lng', konum!.longitude);

      w = await wf.currentWeatherByLocation(konum!.latitude, konum!.longitude);
      setState(() {});
    } catch (e) {
      // Handle errors
    }
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
                      final permission = await Geolocator.checkPermission();
                      if (permission == LocationPermission.denied) {
                        await Geolocator.requestPermission();
                      }
                      await getLocation();
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
                          ? isMetric
                              ? '${w?.temperature!.celsius!.round()} '
                              : '${w?.temperature!.fahrenheit!.round()} '
                          : '',
                      children: [
                        TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(decoration: TextDecoration.underline),
                            text: isMetric ? '°C' : '°F',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isMetric = !isMetric;
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
                  "Rüzgar Hızı: ${isMetric ? "${w?.windSpeed} m/s" : "${((w?.windSpeed ?? 0.0) * 2.2369).toStringAsFixed(2)} mph"}",
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
