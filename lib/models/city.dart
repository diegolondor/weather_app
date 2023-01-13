import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    this.city,
    this.country,
  });

  String? city;
  String? country;

  factory City.fromJson(Map<String, dynamic> json) => City(
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
      };
}
