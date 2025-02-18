import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_all_user.dart';
import 'package:hrm_app/data/model/response_attendace_status.dart';
import 'package:hrm_app/data/model/response_location.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/home/attendeance/late_checkin_reason/late_checkin_reason.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;

import '../../navigation_bar/buttom_navigation_bar.dart';

class AttendanceProvider extends ChangeNotifier {
  String? youLocationServer;
  Position? pos;
  bool isLoading = false;
  String? currentTime;
  String? currentTimeServer;
  String? currentDate;
  String? currentDateSever;
  ResponseAllUser? responseAllUser;
  int? remoteModeType = 0;
  String? countryServer;
  String? countryCodeServer;
  String? cityServer;
  String? latitudeServer;
  String? longitudeServer;
  bool? isCheckIn;
  String? checkStatus;
  bool? checkIn;
  bool? checkOut;
  int? checkInID;
  String? checkInTime;
  String? inTime;
  String? outTime;
  String? stayTime;
  double? isIPEnabled;
  double? latitudeBariKoi;
  double? longitudeBariKoi;
  int? attendanceCheckInID;
  ResponseLocation? responseLocation;
  Placemark? placeMark;
  BodyCheckIn? bodyCheckIn;
  bool? isMultiCheckIn;
  String? attendanceMethod;
  bool? isCheckInVisible;
  String? qrCode;
  int? checkInCheckOutStatusId;
  List<Shift>? shifts;
  Shift? shift;
  bool isCheckedInClicked = false;

  AttendanceProvider(AnimationController controller, BuildContext context) {
    remoteType();
    getSettingBase();
    updatePosition();
    checkInCheckOutStatus(context);
    currentDateTime();
    getAttendance(controller, context);
    _checkGps(context);
  }


  selectShift(Shift? shiftValue){
    shift = shiftValue;
    notifyListeners();
  }



  faceAttendance(context) async {
    EasyLoading.show(status: 'loading...');
    Future.delayed(const Duration(seconds: 3), () async {
      EasyLoading.dismiss();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _checkGps(context);
      } else {
        currentDateTime();
        checkStatus == "Check In" ? checkInApi(context) : checkOutApi(context);
      }
      notifyListeners();
    });
  }


  remoteType() async {
    int? localRemoteType =
        await SPUtill.getSelectLanguage(SPUtill.keyRemoteModeType);
    if (kDebugMode) {
      print("remote Type : $localRemoteType");
    }
    if (localRemoteType != null) {
      remoteModeType = localRemoteType;
      if (kDebugMode) {
        print("remote Type 1 : $remoteModeType");
      }
    }
    notifyListeners();
  }





  /// IP Base setting
  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      bool? isIPEnabledResponse = apiResponse.data?.data?.isIpEnabled;
      attendanceMethod = apiResponse.data?.data?.attendanceMethod;
      isMultiCheckIn = apiResponse.data?.data?.multiCheckIn;
      if (isIPEnabledResponse == true) {
        isIPEnabled = 0;
      } else {
        isIPEnabled = 1;
      }
      if (attendanceMethod == "FR") {
        isCheckInVisible = false;
      } else {
        isCheckInVisible = true;
      }
      notifyListeners();
    }
  }


  /// check In Out status
  checkInCheckOutStatus(context) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
    var apiResponse = await Repository.attendanceStatus(bodyUserId);
    if (apiResponse.result == true) {
      checkIn = apiResponse.data?.data?.checkin;
      checkOut = apiResponse.data?.data?.checkout;
      inTime = apiResponse.data?.data?.inTime;
      outTime = apiResponse.data?.data?.outTime;
      attendanceCheckInID = apiResponse.data?.data?.id;
      stayTime = apiResponse.data?.data?.stayTime;
      checkInCheckOutStatusId = apiResponse.data?.data?.id;
      shifts = apiResponse.data?.data?.shifts;
      notifyListeners();
      if (checkIn == false && checkOut == false) {
        checkStatus = "Check In";
        notifyListeners();
      } else if (checkIn == true && checkOut == true) {
        checkStatus = "Check In";
        notifyListeners();
      } else if (checkIn == true && checkOut == false) {
        checkStatus = "Check Out";
        notifyListeners();
      }
      checkInOutVisibility(context);
    }
  }

  /// check in - out Visibility
  checkInOutVisibility(context) async {
    if (isMultiCheckIn == true) {
      isCheckIn = true;
      notifyListeners();
    } else {
      if (checkIn == true && checkOut == true) {
        isCheckIn = false;
      } else {
        isCheckIn = true;
        // faceAttendance(context);
      }
      notifyListeners();
    }
  }

  /// check in - out API
  getAttendance(AnimationController controller, context) {
    controller.addListener(() async {
      if (controller.value.toInt() == 1) {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          _checkGps(context);
        } else {
          currentDateTime();
          checkStatus == "Check In"
              ? checkInApi(context)
              : checkOutApi(context);
        }
        controller.reset();
      }
      notifyListeners();
    });
  }

  loc.Location location =
      loc.Location(); //explicit reference to the Location class
  Future _checkGps(context) async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
    notifyListeners();
  }

  ///get current date time
  void currentDateTime() {
    DateTime now = DateTime.now();
    currentTimeServer = DateFormat('kk:mm', "en").format(now);
    currentTime = DateFormat('h:mm a', "en").format(now);
    currentDate = DateFormat('yMMMMEEEEd', "en").format(now);
    currentDateSever = DateFormat('y-MM-d', "en").format(now);
    notifyListeners();
  }

  /// get address from lat log
  Future<dynamic> updatePosition() async {
    notifyListeners();
    isLoading = true;
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    placeMark = pm[0];
    latitudeServer = pos.latitude.toString();
    longitudeServer = pos.longitude.toString();
    latitudeBariKoi = pos.latitude.toDouble();
    longitudeBariKoi = pos.longitude.toDouble();
    if (kDebugMode) {
      print("latitude : $latitudeServer longitude : $longitudeServer");
    }

    if (placeMark?.country?.toLowerCase() == "bangladesh") {
      getLocationApi(pos.longitude, pos.latitude);
      youLocationServer = "${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}";
    } else {
      cityServer = placeMark?.locality;
      countryCodeServer = placeMark?.isoCountryCode;
      countryServer = placeMark?.country;
      youLocationServer = "${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}";
    }
    isLoading = false;
    if (kDebugMode) {
      print(youLocationServer);
    }
    notifyListeners();
  }


  void getLocationApi(double? longitudeResult, double? latitudeResult) async {
    isLoading = true;
    var apiResponse =
        await Repository.getLocation(longitudeResult, latitudeResult);
    if (apiResponse.data?.status == 200) {
      isLoading = false;
      responseLocation = apiResponse.data;
      cityServer = responseLocation?.place?.city;
      countryCodeServer = responseLocation?.place?.postCode.toString();
      countryServer = responseLocation?.place?.country.toString();
      youLocationServer = "${responseLocation?.place?.address ?? ""} ${responseLocation?.place?.area ?? ""} ${responseLocation?.place?.city ?? ""} ${responseLocation?.place?.postCode ?? ""}";
      notifyListeners();
    } else {
      cityServer = placeMark?.locality;
      countryCodeServer = placeMark?.isoCountryCode;
      countryServer = placeMark?.country;
      youLocationServer = "${placeMark?.street ?? ""}  ${placeMark?.subLocality ?? ""} ${placeMark?.locality ?? ""} ${placeMark?.postalCode ?? ""}";
      notifyListeners();
    }
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
        await Geolocator.requestPermission();
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  isCheckInClicked(){
    isCheckedInClicked = !isCheckedInClicked;
    notifyListeners();
  }

  /// Check In API
  void checkInApi(context) async {
    isCheckInClicked();
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    bodyCheckIn = BodyCheckIn(
        userId: userId,
        remoteModeIn: remoteModeType,
        date: currentDateSever,
        checkIn: currentTimeServer,
        checkInLocation: youLocationServer,
        checkInLatitude: latitudeServer ?? pos?.latitude.toString(),
        checkInLongitude: longitudeServer ?? pos?.longitude.toString(),
        city: cityServer,
        qrCode: qrCode,
        countryCode: countryCodeServer,
        shiftId: shift?.id,
        country: countryServer);
    var apiResponse = await Repository.checkInApi(bodyCheckIn);
    isCheckInClicked();
    if (apiResponse.result == true) {
      checkInCheckOutStatus(context);
      SPUtill.setRemoteModeType(SPUtill.keyRemoteModeType, remoteModeType);
      notifyListeners();
      if (attendanceMethod == "FR") {
        checkInCheckOutStatus(context);
        NavUtil.replaceScreen(context, const ButtomNavigationBar());
      } else {
        checkInCheckOutStatus(context);
        notifyListeners();
      }
    } else {
      if (apiResponse.error?.laravelValidationError?.reason == "L") {
        SPUtill.setRemoteModeType(SPUtill.keyRemoteModeType, remoteModeType);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogLateComing(
                title: "Oops! You're late today!",
                clickGiveReason: () {
                  NavUtil.navigateScreen(
                      context,
                      LateCheckInReason(
                          remoteModeType: remoteModeType,
                          currentDateSever: currentDateSever,
                          currentTimeServer: currentTimeServer,
                          youLocationServer: youLocationServer,
                          latitudeServer: latitudeServer,
                          longitudeServer: longitudeServer,
                          cityServer: cityServer,
                          countryCodeServer: countryCodeServer,
                          countryServer: cityServer,
                          checkStatus: checkStatus,
                          qrCode: qrCode));
                },
              );
            });
      } else if (apiResponse.httpCode == 400) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogError(
                title: "Error",
                subTitle: apiResponse.error?.message.toString() ?? "",
              );
            });
      } else if (apiResponse.httpCode == 422) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogError(
                title: "Error",
                subTitle: apiResponse.error?.message.toString() ?? "",
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogError(
                title: "Error",
                subTitle: "Something went wrong, please try again.",
              );
            });
        if (kDebugMode) {
          print(apiResponse.message);
        }
      }
    }
  }

  /// Check Out API
  void checkOutApi(context) async {
    isCheckInClicked();
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyCheckOut = BodyCheckOut(
        userId: userId,
        remoteModeOut: remoteModeType,
        date: currentDateSever,
        checkOut: currentTimeServer,
        checkOutLocation: youLocationServer,
        checkOutLatitude: latitudeServer ?? pos?.latitude.toString(),
        checkOutLongitude: longitudeServer ?? pos?.longitude.toString(),
        city: cityServer,
        shiftId: shift?.id,
        countryCode: countryCodeServer,
        country: countryServer);
    var apiResponse =
        await Repository.checkOutApi(bodyCheckOut, attendanceCheckInID);
    isCheckInClicked();
    if (apiResponse.result == true) {
      if (attendanceMethod == "FR") {
        checkInCheckOutStatus(context);
        NavUtil.pushAndRemoveUntil(context, const ButtomNavigationBar());
      } else {
        checkInCheckOutStatus(context);
        notifyListeners();
      }
      checkInCheckOutStatus(context);
      SPUtill.setRemoteModeType(SPUtill.keyRemoteModeType, remoteModeType);
      notifyListeners();
    } else {
      if (apiResponse.error?.laravelValidationError?.reason == "LE") {
        SPUtill.setRemoteModeType(SPUtill.keyRemoteModeType, remoteModeType);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogLateComing(
                title: "Oops! You're early leave today!",
                clickGiveReason: () {
                  NavUtil.navigateScreen(
                      context,
                      LateCheckInReason(
                        remoteModeType: remoteModeType,
                        currentDateSever: currentDateSever,
                        currentTimeServer: currentTimeServer,
                        youLocationServer: youLocationServer,
                        latitudeServer: latitudeServer,
                        longitudeServer: longitudeServer,
                        cityServer: cityServer,
                        countryCodeServer: countryCodeServer,
                        countryServer: cityServer,
                        checkStatus: checkStatus,
                        attendanceCheckInID: attendanceCheckInID,
                        qrCode: qrCode,
                      ));
                },
              );
            });
      } else if (apiResponse.httpCode == 400) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogError(
                title: "Error",
                subTitle: apiResponse.error?.message.toString() ?? "",
              );
            });
      } else if (apiResponse.httpCode == 422) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogError(
                title: "Error",
                subTitle: apiResponse.error?.message.toString() ?? "",
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogError(
                title: "Error",
                subTitle: "Something went wrong, please try again.",
              );
            });
        if (kDebugMode) {
          print(apiResponse.error?.message.toString());
        }
      }
    }
  }
}
