import 'package:rxdart/rxdart.dart';
import 'package:weather_app/bloc/base_bloc.dart';

import '../models/city.dart';
import '../repository/cities_repository.dart';

class CitiesBloc implements BaseBloc {
  final CitiesRepository citiesRepository;
  final _citiesFetcher = PublishSubject<List<City>>();
  final _loading = PublishSubject<bool>();

  CitiesBloc({required this.citiesRepository});

  Stream<List<City>> get city => _citiesFetcher.stream;

  @override
  void dispose() {
    _citiesFetcher.close();
    _loading.close();
  }

  @override
  get isLoading => _loading.stream;

  getCities() async {
    _loading.sink.add(true);
    try {
      List<City>? cities = await citiesRepository.getCities();
      _citiesFetcher.sink.add(cities);
      _loading.sink.add(false);
    } catch (e) {
      _loading.sink.add(false);
      _citiesFetcher.sink.addError(e);
    }
  }
}
