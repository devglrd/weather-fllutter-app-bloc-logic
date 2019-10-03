import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/bloc/bloc.dart';
import 'package:weather/model/weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class LoadingWeatherState extends WeatherState {}

class LoadedWeatherState extends WeatherState {
  final Weather weather;

  LoadedWeatherState(this.weather) : super([weather]);
}

class CustomWeatherState extends WeatherState {
  final double temp;
  CustomWeatherState(this.temp) : super([temp]);
}
