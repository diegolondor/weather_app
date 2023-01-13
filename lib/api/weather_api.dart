class OpenWeatherAPI {
  final String apiKey;

  static const String _urlBase = "api.openweathermap.org";
  static const String _path = "/data/2.5/weather";
  static const String _scheme = "https";
  static const String _units = "metric";

  OpenWeatherAPI(this.apiKey);

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
      {"q": city, "appid": apiKey, "units": _units};
}
