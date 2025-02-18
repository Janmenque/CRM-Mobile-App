import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_details/visit_details.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:intl/intl.dart';

class RescheduleVisitProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  String? visitDate;
  var noteTextController = TextEditingController();
  String? latitudeServer;
  String? longitudeServer;
  int? visitIdServer;

  RescheduleVisitProvider(int? visitId) {
    updatePosition(visitId);
  }

  /// select date ......
  Future selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      visitDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      if (kDebugMode) {
        print(visitDate);
      }
      notifyListeners();
    }
  }

  /// get address from lat log
  Future<dynamic> updatePosition(int? visitId) async {
    Position pos = await _determinePosition();
    latitudeServer = pos.latitude.toString();
    longitudeServer = pos.longitude.toString();
    visitIdServer = visitId;
    visitDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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

  /// create reschedule visit
  rescheduleVisitApi(context) async {
    var bodyRescheduleVisit = BodyRescheduleVisit(
        visitId: visitIdServer,
        date: visitDate,
        latitude: latitudeServer,
        longitude: longitudeServer,
        note: noteTextController.text);
    var apiResponse =
        await Repository.createRescheduleVisitApi(bodyRescheduleVisit);
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
      NavUtil.replaceScreen(
          context,
          VisitDetails(
            visitID: visitIdServer,
          ));

    } else {
      Fluttertoast.showToast(
          msg: apiResponse.data?.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
