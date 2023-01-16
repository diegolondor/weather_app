import 'package:flutter/material.dart';

class CityDetails extends StatelessWidget {
  final String city;
  final String country;

  const CityDetails({super.key, required this.city, required this.country});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$city, $country",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
