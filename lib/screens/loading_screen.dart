import 'dart:convert';

import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/location.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  double lat;
  double long;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;

  @override
  void initState() {
    super.initState();
    loadLocationData();
  }

  void loadLocationData() async {
     var decodedData = await WeatherModel().getWeatherData();

    double temperature = decodedData['main']['temp'];
    int condition = decodedData['weather'][0]['id'];
    var city = decodedData['name'];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationScreen(temperature:temperature, city: city, condition: condition,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
