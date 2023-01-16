import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';

class CityCard extends StatelessWidget {
  final City city;
  final Function(String) onTapItem;

  const CityCard({super.key, required this.city, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Column(
        children: [
          Image(image: AssetImage(city.path!)),
          ListTile(
            title: Text(city.city!),
            subtitle: Text(city.country!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => onTapItem(city.city!),
          ),
        ],
      ),
    );
  }
}
