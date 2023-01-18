import 'dart:io';
import 'dart:convert';
import '../api/weather_api.dart';
import '../models/weather_data.dart';

import 'package:http/http.dart';

class WeatherRepository {
  final OpenWeatherAPI openWeatherAPI;
  final Client client;

  WeatherRepository({required this.openWeatherAPI, required this.client});

  Future<WeatherData?> getWeather({required String city}) => _getData(
        uri: openWeatherAPI.weather(city),
        builder: (data) => WeatherData.fromJson(data),
      );

  Future<T?> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw Exception("Invalid Api key");
        case 404:
          throw Exception("Open weather not found");
        default:
          throw Exception("Error Api");
      }
    } on SocketException catch (_) {
      throw Exception("No internet connection");
    }
  }
}
