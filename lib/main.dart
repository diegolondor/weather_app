import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: FadeInRight(
            child: const Text('holaa'),
          ),
        ),
      ),
    );
  }
}
