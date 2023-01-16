import 'package:flutter/material.dart';

class WeatherExtras extends StatelessWidget {
  final String humidity;
  final String maxTemp;
  final String minTemp;
  const WeatherExtras({
    Key? key,
    required this.humidity,
    required this.maxTemp,
    required this.minTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DetailRow(title: "HUMIDITY", detail: "$humidity%"),
          DetailRow(title: "MIN TEMP", detail: "$minTemp%"),
          DetailRow(title: "MAX TEMP", detail: "$maxTemp%"),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String? title;
  final String? detail;
  const DetailRow({Key? key, this.title, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TextDetail(text: title!), TextDetail(text: detail!)],
    );
  }
}

class TextDetail extends StatelessWidget {
  final String text;
  const TextDetail({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ));
  }
}
