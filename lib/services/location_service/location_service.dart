import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:handy/utils/global_variables.dart';

Future<void> permissions() async {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    log('Location permissions are denied');
  }

  position = await getDeviceLocation();
}

Future<Position> getDeviceLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude = position.latitude;
    longitude = position.longitude;
    log("Latitude :: $latitude");
    log("Longitude :: $longitude");

    return position;
  } catch (e) {
    log("Error getting location: $e");

    return Position(
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }
}
