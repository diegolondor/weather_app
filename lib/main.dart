import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/repository/cities_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/ui/pages/home_page.dart';
import 'package:weather_app/ui/pages/weather_details.dart';

void main() => runApp(
      MyApp(
        citiesRepository: CitiesRepository(),
        weatherRepository: WeatherRepository(
          openWeatherAPI: OpenWeatherAPI(),
          client: Client(),
        ),
      ),
    );

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final CitiesRepository citiesRepository;
  const MyApp(
      {super.key,
      required this.citiesRepository,
      required this.weatherRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      routes: {
        'home': (context) => HomePage(
              citiesRepository: citiesRepository,
              weatherRepository: weatherRepository,
            ),
        'details': (context) => const WeatherDetailsPage()
      },
      initialRoute: 'home',
    );
  }
}
