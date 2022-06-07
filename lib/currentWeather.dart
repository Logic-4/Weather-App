import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_weather/weather.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot != null) {
              Weather _weather = snapshot.data;
              if (_weather == null) {
                return Text("Error getting weather");
              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "Bangalore\n${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              "${_weather.description}",
              style: TextStyle(fontSize: 30),
            )),
        Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              "Feels:${_weather.feelsLike}°C",
              style: TextStyle(fontSize: 30),
            )),
        Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              "H:${_weather.high}°C    L:${_weather.low}°C",
              style: TextStyle(fontSize: 25),
            )),
      ],
    );
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "bangalore";
    String apiKey = "1d5592436c6d43c47b20c2e8d2bc40d3";
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    final responce = await http.get(url);
    if (responce.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(responce.body));
    } else {
      weather = Weather(
          temp: 10, feelsLike: 10, low: 10, high: 10, description: "Cloudy");
    }

    return weather;
  }
}
