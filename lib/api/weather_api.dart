class OpenWeatherAPI {
  static const String _apiKey = "24f9b57f72ae33844933ab6d8d4b1ed6";
  static const String _urlBase = "api.openweathermap.org";
  static const String _path = "/data/2.5/weather";
  static const String _scheme = "https";
  static const String _units = "metric";

  Uri weather(String city) => _buildUri(
        parametersBuilder: () => cityQueryParameters(city),
      );

  Uri _buildUri({
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: _scheme,
      host: _urlBase,
      path: _path,
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParameters(String city) =>
      {"q": city, "appid": _apiKey, "units": _units};
}
