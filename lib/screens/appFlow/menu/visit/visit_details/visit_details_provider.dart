import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_visit_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:image_picker/image_picker.dart';

class VisitDetailsProvider extends ChangeNotifier {
  ResponseVisitDetails? visitDetails;
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = {};
  int? visitIdServer;
  double latitude = 22.705514565035855;
  double longitude = 90.35603514863132;
  var initialPosition = const CameraPosition(target: LatLng(23.791901, 90.426801), zoom: 14.4746);
  String? latitudeServer;
  String? longitudeServer;
  String? youLocationServer;
  bool isLoading = false;
  List imageFile = [];
  File? attachmentPath;
  List? imageListSever = [];
  List locationListServer = [];
  bool isUpdateBottomShow = false;

  VisitDetailsProvider(int? visitID) {
    updatePosition();
    visitDetailsApi(visitID);
    visitIdServer = visitID;
  }

  hideUpdateButton() {
    if (visitDetails?.data?.status == "Cancelled") {
      isUpdateBottomShow = false;
    } else if (visitDetails?.data?.status == "Completed") {
      isUpdateBottomShow = false;
    } else {
      isUpdateBottomShow = true;
    }
    notifyListeners();
  }

  ///Pick image from Camera and Gallery
  Future<dynamic> pickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 700,
                maxWidth: 700,
                imageQuality: 100);
            imageFile.add(File(image!.path));
            attachmentPath = File(image.path);
            updateImageVisitApi(attachmentPath);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            imageFile.add(File(imageGallery!.path));
            attachmentPath = File(imageGallery.path);
            updateImageVisitApi(attachmentPath);
            notifyListeners();
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

  /// Update Image Visit API
  void updateImageVisitApi(File? file) async {
    var apiResponse = await Repository.updateImageVisit(visitIdServer, file);
    if (apiResponse.result == true) {
      imageListSever?.add(apiResponse.data?.data ?? "");
      Fluttertoast.showToast(
          msg: apiResponse.data?.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(apiResponse.message);
      }
    }
  }

  Future<void> visitDetailsApi(int? visitID) async {
    var apiResponse = await Repository.visitDetails(visitID);
    if (apiResponse.result == true) {
      visitDetails = apiResponse.data;
      imageListSever?.clear();
      visitDetails?.data?.imageListVisit?.map((e) {
        var path = e.filePath;
        imageListSever?.add(path ?? "");
      }).toList();

      visitDetails?.data?.schedules?.map((e) async {
        var latitude = e.latitude;
        var longitude = e.longitude;
        var lat = double.parse(latitude.toString());
        var log = double.parse(longitude.toString());
        List pm = await placemarkFromCoordinates(lat, log);
        Placemark placeMark = pm[0];
        youLocationServer =
            "${placeMark.street ?? ""},${placeMark.locality ?? ""} ${placeMark.postalCode ?? ""}";
        locationListServer.add(youLocationServer ?? "");
        notifyListeners();
      }).toList();
      hideUpdateButton();
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  goToPosition(LatLng latLng) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15)));
    getMarkerData(latLng.latitude, latLng.longitude);
    notifyListeners();
  }

  /// get address from lat log
  Future<dynamic> updatePosition() async {
    Position pos = await _determinePosition();
    latitudeServer = pos.latitude.toString();
    longitudeServer = pos.longitude.toString();
    latitude = pos.longitude;
    longitude = pos.longitude;
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

  void getMarkerData(double? markerLat, double? markerLog) {
    markers.add(Marker(
      markerId: MarkerId(markerLat.toString()),
      position: LatLng(markerLat!, markerLog!), //position of marker
      infoWindow: const InfoWindow(
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    notifyListeners();
  }

  changeStatusVisitApi() async {
    updatePosition();
    var bodyChangeStatus = BodyChangeStatus(
        visitId: visitIdServer,
        status: visitDetails?.data?.nextStatus?.status,
        latitude: latitudeServer,
        longitude: longitudeServer,
        cancelNote: "");
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
      await visitDetailsApi(visitIdServer);
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      notifyListeners();
    }
  }
}
