import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({this.city, this.country, this.path});

  String? city;
  String? country;
  String? path;

  factory City.fromJson(Map<String, dynamic> json) => City(
        city: json["city"],
        country: json["country"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "country": country,
        "path": path,
      };
}
