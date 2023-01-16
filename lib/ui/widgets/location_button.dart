import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  final Function() onPressed;

  const LocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue,
      child: const Icon(Icons.pin_drop),
    );
  }
}
