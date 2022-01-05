import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final double temperature;
  final String city;
  final int condition;

  LocationScreen({this.temperature, this.city, this.condition});

  @override
  _LocationScreenState createState() => _LocationScreenState(
        temperature: this.temperature,
        city: this.city,
        condition: this.condition,
      );
}

class _LocationScreenState extends State<LocationScreen> {
  double temperature;
  String city;
  int condition;

  _LocationScreenState({this.temperature, this.city, this.condition});

  final WeatherModel weatherModel = WeatherModel();

  Future<void> getCurrentLocationWeatherData() async {
    var decodedData = await WeatherModel().getWeatherData();

    setState(() {
      temperature = decodedData['main']['temp'];
      condition = decodedData['weather'][0]['id'];
      city = decodedData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      getCurrentLocationWeatherData();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var enteredCity = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) {
                          return CityScreen();
                        }),
                      );
                      if(enteredCity!=null){
                       var decodedData = await weatherModel.getWeatherDataForCity(enteredCity);
                       setState(() {
                         temperature = decodedData['main']['temp'];
                         condition = decodedData['weather'][0]['id'];
                         city = decodedData['name'];
                       });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString(),
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weatherModel.getWeatherIcon(condition)}️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temperature.toInt())} ${city}",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
