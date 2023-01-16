import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weatherData.dart';

import '../data.dart';

main() {
  group('weather image', () {
    test('imageWeather from json is valid', () {
      WeatherData weatherData = WeatherData.fromJson(jsonResponseWeather);
      expect(weatherData.weather![0].imageWeather,
          equals('http://openweathermap.org/img/wn/11n@2x.png'));
    });

    test('default image is valid', () {
      Weather weather = Weather.fromJson(jsonWeather);
      expect(weather.imageWeather,
          equals('http://openweathermap.org/img/wn/01d@2x.png'));
    });

    test('default images is valid', () {
      WeatherData weatherData = WeatherData.fromJson(jsonResponseWeather);
      expect(weatherData.weather![0].imageWeather,
          isNot(equals('http://openweathermap.org/img/wn/01d@2x.png')));
    });
  });
}
