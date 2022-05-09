import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_weather_app/models/weather_forecast_daily.dart';

class ExtraWeather extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const ExtraWeather({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;

    var humidity = forecastList![0].humidity!;
    var wind = forecastList[0].speed!;
    var rain = forecastList[0].clouds!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(CupertinoIcons.wind, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              wind.toString() + " Km/h",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Wind",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.drop, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              humidity.toString() + " %",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Humidity",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
        Column(
          children: [
            const Icon(CupertinoIcons.cloud_rain, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              rain.toString() + " %",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "Rain",
              style: TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}
