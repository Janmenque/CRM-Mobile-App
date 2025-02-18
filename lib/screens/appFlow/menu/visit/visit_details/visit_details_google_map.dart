import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details_provider.dart';
import 'package:provider/provider.dart';

class VisitDetailsGoogleMap extends StatelessWidget {
  const VisitDetailsGoogleMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailsProvider>(builder: (_, provider, __) {
      return GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: provider.initialPosition,
        markers: Set<Marker>.of(provider.markers),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          provider.mapController.complete(controller);
        },
      );
    });
  }
}
