import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_app/api/weather_api.dart';
import 'package:flutter_weather_app/pages/home_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherForecast();
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(locationWeather: weatherInfo);
      }));
    } catch (e) {
      log('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff030317),
      body: Center(
        child: SpinKitDoubleBounce(color: Color(0xff00A1FF), size: 100.0),
      ),
    );
  }
}
