import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/ui/widgets/cities_listview.dart';
import 'package:weather_app/ui/widgets/custom_dialog.dart';
import 'package:weather_app/ui/widgets/location_button.dart';
import 'package:weather_app/ui/widgets/progress_indicator.dart';

import '../../bloc/cities_bloc.dart';
import '../../bloc/location_bloc.dart';
import '../../bloc/weather_bloc.dart';
import '../../models/city.dart';
import '../../models/weatherData.dart';
import '../../repository/cities_repository.dart';
import '../../repository/weather_repository.dart';

class HomePage extends StatefulWidget {
  final WeatherRepository weatherRepository;
  final CitiesRepository citiesRepository;

  const HomePage(
      {super.key,
      required this.weatherRepository,
      required this.citiesRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherBloc _weatherBloc;
  late CitiesBloc _citiesBloc;
  late LocationBloc _locationBloc;

  @override
  void initState() {
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _citiesBloc = CitiesBloc(citiesRepository: widget.citiesRepository);
    _locationBloc = LocationBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCities();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        elevation: 6,
      ),
      body: Stack(children: [
        Column(
          children: [
            StreamBuilder(builder: _citiesBuilder, stream: _citiesBloc.city)
          ],
        ),
        StreamBuilder(builder: _weatherBuilder, stream: _weatherBloc.weather),
        StreamBuilder(
            builder: _locationCityBuilder, stream: _locationBloc.city),
        StreamBuilder(
            builder: _locationPositionBuilder, stream: _locationBloc.position),
        ProgressIndicatorSB(baseBloc: _citiesBloc),
        ProgressIndicatorSB(baseBloc: _weatherBloc),
        ProgressIndicatorSB(baseBloc: _locationBloc),
      ]),
      floatingActionButton:
          LocationButton(onPressed: _onPressedFloatingActionButton),
    );
  }

  _getCities() async {
    _citiesBloc.getCities();
  }

  _showMessage(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(message: message);
          });
    });
  }

  _onTapListItem(String city) {
    _weatherBloc.getWeather(city: city);
  }

  _onPressedFloatingActionButton() {
    _locationBloc.determinePosition();
  }

  Widget _executeBuilder(
      context, AsyncSnapshot<dynamic> snapshot, Function() execute) {
    if (snapshot.hasData && snapshot.data != null) {
      execute();
    } else if (snapshot.hasError) {
      _showMessage(snapshot.error.toString());
    }

    return Container();
  }

  Widget _citiesBuilder(context, AsyncSnapshot<List<City>> citiesSnapshot) {
    if (citiesSnapshot.hasData && citiesSnapshot.data != null) {
      return CitiesListview(
          cities: citiesSnapshot.data, onTapItem: _onTapListItem);
    } else if (citiesSnapshot.hasError) {
      _showMessage(citiesSnapshot.error.toString());
    }

    return Container();
  }

  Widget _weatherBuilder(context, AsyncSnapshot<WeatherData> weatherSnapshot) {
    return _executeBuilder(
      context,
      weatherSnapshot,
      () => {
        WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pushNamed(
            context, 'details',
            arguments: weatherSnapshot.data))
      },
    );
  }

  Widget _locationCityBuilder(context, AsyncSnapshot<String> citySnapshot) {
    return _executeBuilder(context, citySnapshot,
        () => _weatherBloc.getWeather(city: citySnapshot.data!));
  }

  Widget _locationPositionBuilder(
      context, AsyncSnapshot<Position> positionSnapshot) {
    return _executeBuilder(
        context,
        positionSnapshot,
        () => _locationBloc.getCity(
            positionSnapshot.data!.latitude, positionSnapshot.data!.longitude));
  }
}
