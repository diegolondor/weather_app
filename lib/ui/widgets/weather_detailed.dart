import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WeatherDetailed extends StatelessWidget {
  static const String urlIcons = "http://openweathermap.org/img/wn/";
  final String imageWeather;
  final String tempeture;
  final String main;

  const WeatherDetailed(
      {super.key,
      required this.imageWeather,
      required this.tempeture,
      required this.main});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$tempeture°",
          style: const TextStyle(
            fontSize: 90,
            color: Colors.white,
          ),
        ),
        Image.network(
          imageWeather,
        ),
        Text(
          main,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
