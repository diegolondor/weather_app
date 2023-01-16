import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather_app/models/city.dart';

class CitiesRepository {
  Future<List<City>> getCities() async {
    var jsonText = await rootBundle.loadString('assets/cities.json');
    final jsonResult = json.decode(jsonText).cast<Map<String, dynamic>>();
    return jsonResult.map<City>((json) => City.fromJson(json)).toList();
  }
}
