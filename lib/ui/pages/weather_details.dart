import 'package:flutter/material.dart';
import 'package:weather_app/models/weatherData.dart';
import 'package:weather_app/ui/widgets/city_details.dart';
import 'package:weather_app/ui/widgets/weather_detailed.dart';
import 'package:weather_app/ui/widgets/weather_extras.dart';
import 'package:animate_do/animate_do.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherData data =
        ModalRoute.of(context)!.settings.arguments as WeatherData;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade400],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SlideInDown(
                child: CityDetails(
                  city: data.name!,
                  country: data.sys!.country!,
                ),
              ),
              ZoomIn(
                child: WeatherDetailed(
                    imageWeather: data.weather![0].imageWeather,
                    tempeture: data.main!.temp!.round().toString(),
                    main: data.weather![0].main!),
              ),
              SlideInUp(
                child: WeatherExtras(
                  humidity: data.main!.humidity!.round().toString(),
                  maxTemp: data.main!.tempMax!.round().toString(),
                  minTemp: data.main!.tempMin!.round().toString(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
