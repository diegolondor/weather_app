import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weatherData.dart';
import 'package:weather_app/repository/weather_repository.dart';

import '../data.dart';

void main() {
  group('weather', () {
    test('status=200', () async {
      final mockClient = MockClient((request) async {
        return Response(json.encode(jsonResponseWeather), 200);
      });
      final api = OpenWeatherAPI();
      final weatherRepository =
          WeatherRepository(openWeatherAPI: api, client: mockClient);
      final expectedResponse = WeatherData.fromJson(jsonResponseWeather);
      final actualResponse =
          await weatherRepository.getWeather(city: "Medellin");
      expect(actualResponse!.toJson(), equals(expectedResponse.toJson()));
    });
  });
}
