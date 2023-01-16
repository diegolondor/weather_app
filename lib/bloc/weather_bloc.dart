import 'package:rxdart/subjects.dart';
import 'package:weather_app/bloc/base_bloc.dart';
import 'package:weather_app/models/weatherData.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherBloc implements BaseBloc {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository});

  final _weatherFetcher = PublishSubject<WeatherData>();
  final _loading = PublishSubject<bool>();

  Stream<WeatherData> get weather => _weatherFetcher.stream;

  @override
  void dispose() {
    _loading.close();
    _weatherFetcher.close();
  }

  @override
  get isLoading => _loading.stream;

  getWeather({required String city}) async {
    _loading.sink.add(true);
    try {
      WeatherData? currentWeather =
          await weatherRepository.getWeather(city: city);
      if (currentWeather != null) {
        _weatherFetcher.sink.add(currentWeather);
      } else {
        _weatherFetcher.sink.addError('error');
      }

      _loading.sink.add(false);
    } catch (e) {
      _loading.sink.add(false);
      _weatherFetcher.sink.addError('error general');
    }
  }
}
