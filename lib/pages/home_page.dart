import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/api/weather_api.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_weather_app/pages/search_page.dart';
import 'package:flutter_weather_app/widgets/bottom_list.dart';
import 'package:flutter_weather_app/widgets/current_weather.dart';

class HomePage extends StatefulWidget {
  final WeatherForecast? locationWeather;

  const HomePage({Key? key, required this.locationWeather}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherForecast> weatherObj;
  late String _cityName;

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      weatherObj = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff00A1FF),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  weatherObj = WeatherApi().fetchWeatherForecast();
                });
              },
              child: const Icon(
                CupertinoIcons.location_circle,
                color: Colors.white,
                size: 30,
              ),
            ),
            Row(
              children: const [
                Icon(CupertinoIcons.map_fill, color: Colors.white),
                Text(
                  'openweathermap.org',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )
              ],
            ),
            GestureDetector(
              child: const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 30,
              ),
              onTap: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    weatherObj = WeatherApi().fetchWeatherForecast(
                      cityName: _cityName,
                      isCity: true,
                    );
                  });
                }
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast>(
            future: weatherObj,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    CurrentWeather(snapshot: snapshot),
                    ButtomListView(snapshot: snapshot),
                  ],
                );
              } else {
                return const Center(
                    child: Text(
                  'City not found\n Please enter correct city',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
