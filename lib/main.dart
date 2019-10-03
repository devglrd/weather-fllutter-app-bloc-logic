import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/bloc.dart';
import 'package:weather/model/weatherDetail.dart';

import 'model/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  WeatherPage({Key key}) : super(key: key);

  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherBloc weatherBloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Weather App"),
      ),
      body: BlocProvider<WeatherBloc>(
          builder: (BuildContext context) => weatherBloc,
          child: WeatherHomePage()),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocListener(
        bloc: BlocProvider.of<WeatherBloc>(context),
        listener: (context, state) {
          if (state is LoadedWeatherState) {
            print('Loaded : ${state.weather.cityName}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherDetail(
                          weather: state.weather,
                        )));
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<WeatherBloc>(context),
          builder: (BuildContext context, WeatherState state) {
            print("Type OF STATE ${state.runtimeType}");
            if (state is InitialWeatherState) {
              return buildInitialInput();
            } else if (state is CustomWeatherState) {
              return Center(
                child: Text(
                    "Your temp choose is ${state.temp} .. Make some Api Call wait 2 sec and state change"),
              );
            } else if (state is LoadingWeatherState) {
              return buildLoading();
            }
            return buildInitialInput();
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(child: CityInputField());
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    Key key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: 'Rentrer le pays que vous voulez',
              style: TextStyle(color: Colors.cyan, fontSize: 23.0)),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextField(
            controller: myController,
            //onSubmitted: submitCityName,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Enter a city",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
            onPressed: () {
              submitCityName(myController.text);
            },
            color: Colors.black,
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Apply ",
              style: TextStyle(color: Colors.cyan),
            ))
      ],
    );
  }

  void submitCityName(String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.dispatch(SendWheather(10));
    Future.delayed(Duration(seconds: 5), () {
      return weatherBloc.dispatch(GetWeather(cityName));
    });

    // We will use the city name to search for the fake forecast
  }
}
