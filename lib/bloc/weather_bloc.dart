import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:weather/model/weather.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    print('Type of receive Event in bloc is ${event.runtimeType}');
    if (event is SendWheather) {
      yield CustomWeatherState(event.temp);
    }
    if (event is GetWeather) {
      yield LoadingWeatherState();
      final weather = await _fetchWeather(event.cityName);
      yield LoadedWeatherState(weather);
    }
  }

  Future<Weather> _fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
          cityName: cityName, temperature: 20 + Random().nextDouble());
    });
  }

  Future<Weather> _makeCustom(double temp) {
    return Future.delayed(Duration(seconds: 3), () {
      return Weather(cityName: "a", temperature: temp);
    });
  }
}
