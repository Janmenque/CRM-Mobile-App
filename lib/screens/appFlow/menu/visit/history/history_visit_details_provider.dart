import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryVisitDetailsProvider extends ChangeNotifier {
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> markers = <Marker>[];
  var initialPosition =
      const CameraPosition(target: LatLng(23.791901, 90.426801), zoom: 14.4746);

  HistoryVisitDetailsProvider() {
    markers.add(faysal);
    markers.add(faysalChowdhury);

  }

  var faysal = const Marker(
    markerId: MarkerId("fdfsfsdf"),
    position: LatLng(23.791119, 90.406719),
    infoWindow: InfoWindow(title: "Faysal chowdhury")
  );

  var faysalChowdhury = const Marker(
      markerId: MarkerId("fdfsfsdf"),
      position: LatLng(23.750140, 90.390452),
      infoWindow: InfoWindow(title: "Palash Chowdhury")
  );



  goToPosition(LatLng latLng) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15)));

  }
}
