import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class VisitCancelProvider extends ChangeNotifier {
  String? latitudeServer;
  String? longitudeServer;
  int? visitIdServer;
  var cancelNoteTextController = TextEditingController();

  VisitCancelProvider(int? visitId){
    visitIdServer = visitId;
    updatePosition();
  }
  /// get address from lat log
  Future<dynamic> updatePosition() async {
    Position pos = await _determinePosition();
    latitudeServer = pos.latitude.toString();
    longitudeServer = pos.longitude.toString();
    notifyListeners();
  }

  /// get permission from user and get lat log
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  /// Cancel Status api
  changeStatusVisitApi(context) async {
    if (cancelNoteTextController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogEmptyField(
              title: "Filed Empty",
              subTitle: "Give a note. Field cannot be empty",
            );
          });
    }else {
      var bodyChangeStatus = BodyChangeStatus(
          visitId: visitIdServer,
          status: "cancelled",
          latitude: latitudeServer,
          longitude: longitudeServer,
          cancelNote: cancelNoteTextController.text);
      var apiResponse = await Repository.changeStatusVisit(bodyChangeStatus);
      if (apiResponse.result == true) {
        Fluttertoast.showToast(
            msg: apiResponse.data?.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
        notifyListeners();
        NavUtil.replaceScreen(context, VisitDetails(visitID: visitIdServer,));
      } else {
        Fluttertoast.showToast(
            msg: apiResponse.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
        notifyListeners();
      }
    }

  }
}
