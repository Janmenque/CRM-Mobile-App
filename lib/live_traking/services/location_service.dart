import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'dart:io' as platform;

class LocationService {

  var location = Location();
  bool isTry = true;

  LocationService() {

    location.hasPermission().then((value){

      if(value == PermissionStatus.granted){
        if(platform.Platform.isAndroid) location.changeSettings(interval: 10000,distanceFilter: 5);
        location.enableBackgroundMode(enable: true);
        location.onLocationChanged.listen((locationData) {
          _locationController.add(locationData);
        });
      }
    });
  }

  //continuously emit location updates
  final StreamController<LocationData> _locationController = StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationController.stream;

  Future<LocationData?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      return userLocation;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

}
