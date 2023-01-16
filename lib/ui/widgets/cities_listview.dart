import 'package:flutter/material.dart';
import 'package:weather_app/ui/widgets/city_card.dart';

import '../../models/city.dart';

class CitiesListview extends StatelessWidget {
  final List<City>? cities;
  final Function(String) onTapItem;

  const CitiesListview(
      {super.key, required this.cities, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(10),
          child: CityCard(city: cities![index], onTapItem: onTapItem),
        ),
        itemCount: cities == null ? 0 : cities!.length,
      ),
    );
  }
}
