

import 'package:geolocator/geolocator.dart';

class Location {
  double lattitude;
  double longtitude;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      print(position);
      lattitude = position.latitude;
      longtitude = position.longitude;

    } catch (e) {
      print(e);
    }
  }

}