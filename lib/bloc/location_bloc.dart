import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/bloc/base_bloc.dart';

class LocationBloc implements BaseBloc {
  final _positionFetcher = PublishSubject<Position>();
  final _city = PublishSubject<String>();
  final _loading = PublishSubject<bool>();

  Stream<Position> get position => _positionFetcher.stream;
  Stream<String> get city => _city.stream;

  @override
  void dispose() {
    _positionFetcher.close();
    _loading.close();
  }

  @override
  get isLoading => _loading.stream;

  determinePosition() async {
    _loading.sink.add(true);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _positionFetcher.sink.addError('error 1');
      _loading.sink.add(false);
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      _loading.sink.add(false);
      _positionFetcher.sink.addError('error 2');
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        _positionFetcher.sink.addError('error 3');
        _loading.sink.add(false);
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    _loading.sink.add(false);
    _positionFetcher.sink.add(position);
  }

  getCity(double latitude, double longitude) async {
    _loading.sink.add(true);
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      _loading.sink.add(false);
      _city.sink.add(placemark[0].locality!);
    } catch (e) {
      _loading.sink.add(false);
      _city.sink.addError('error');
    }
  }
}
