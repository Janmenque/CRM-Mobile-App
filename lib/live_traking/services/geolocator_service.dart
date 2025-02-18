import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

ValueNotifier<List<geocoding.Placemark>?> addressNotifier = ValueNotifier(null);

class GeoLocatorService extends ChangeNotifier{
  bool isTry = true;

  //get current position
  Stream<Position> getCoords() {

    LocationSettings settings = const LocationSettings(accuracy: LocationAccuracy.high,);

    return Geolocator.getPositionStream(locationSettings: settings);
  }
  //get current future
  Future<Position?> getCordFuture() {
    return Geolocator.getLastKnownPosition();
  }

  ///get address by position
  Future<List<geocoding.Placemark>?> getAddress(Position position) async {
    addressNotifier.value = await GeocodingPlatform.instance?.placemarkFromCoordinates(position.latitude, position.longitude,);
    addressNotifier.notifyListeners();
    return addressNotifier.value;
  }

  ///calculate distance
  Future<double> getDistance(LatLng origin, LatLng destination) async {
    return Geolocator.distanceBetween(origin.latitude, origin.longitude,
        destination.latitude, destination.longitude);
  }
}
