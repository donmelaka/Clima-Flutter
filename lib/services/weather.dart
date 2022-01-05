import 'package:clima/utilities/constants.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {

  Future getWeatherData() async{
    var location = Location();
    await location.findCurrentLocation();
    var lat = location.latitude;
    var long = location.longitude;

    print('Returned lat: ${location.latitude}');
    print('Returned lon: ${location.longitude}');

    var networkHelper = NetworkHelper(
        url:
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$kApiKey&units=metric');
    return networkHelper.getData();
  }

  Future getWeatherDataForCity(String city) async{
    var networkHelper = NetworkHelper(
        url:
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$kApiKey&units=metric');
    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
