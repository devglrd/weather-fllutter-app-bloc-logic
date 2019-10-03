import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super(props);

}

class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather(this.cityName) : super([cityName]); 
}

class SendWheather extends WeatherEvent{
  final double temp;
  SendWheather(this.temp) : super([temp]); 
}
