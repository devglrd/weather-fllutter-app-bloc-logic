import 'package:flutter/material.dart';
import 'package:weather/model/weather.dart';

class WeatherDetail extends StatelessWidget {
  final Weather weather;
  WeatherDetail({this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Detail Weather App of "),
      ),
      body: WeatherDetailPage(weather),
    );
  }
}

class WeatherDetailPage extends StatelessWidget {
  final Weather weather;
  WeatherDetailPage(this.weather);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${weather.cityName}",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "${weather.temperature.toStringAsFixed(1)} °C",
            style: TextStyle(fontSize: 80),
          ),
        ],
      ),
    );
  }
}
