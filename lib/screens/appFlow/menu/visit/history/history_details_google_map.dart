import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/history/history_visit_details_provider.dart';
import 'package:provider/provider.dart';

class HistoryDetailsGoogleMap extends StatelessWidget {
  const HistoryDetailsGoogleMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryVisitDetailsProvider>(builder: (_,provider,__){
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
