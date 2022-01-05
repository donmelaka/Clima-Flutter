import 'dart:io';

import 'package:geolocator/geolocator.dart';

class Location {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position _location;

  double get latitude {
    return _location.latitude;
  }

  double get longitude {
    return _location.longitude;
  }

  Future<void> findCurrentLocation() async {
    try {
      _location = await _geolocatorPlatform.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
      print(_location);
      sleep(Duration(seconds: 3));
    } catch (e) {
      print(e);
    }
  }
}
