import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_weather_app/utilities/forecast_util.dart';

class ButtomListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const ButtomListView({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '7 - day weather forecast'.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 160,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xff00A1FF).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: forecastCard(snapshot, index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: snapshot.data!.list!.length,
            ),
          )
        ],
      ),
    );
  }
}

Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data.list;
  var dayOfWeek = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  dayOfWeek = fullDate.split(',')[0]; // Tue
  var tempMin = forecastList[index].temp.min.toStringAsFixed(0);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        '$tempMin °C',
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      Image(
        image: AssetImage(
          Util.findIcon('${forecastList[index].weather![0].main}', false),
        ),
        width: 55,
        height: 55,
      ),
      Text(
        dayOfWeek,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      )
    ],
  );
}
