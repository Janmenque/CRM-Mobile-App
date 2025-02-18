import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/home/attendeance/attendance.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class LateCheckInReasonProvider extends ChangeNotifier {
  var lateCheckInController = TextEditingController();
  String? attendanceStatus;

  LateCheckInReasonProvider(String? attendanceMethod) {
    attendanceStatus = attendanceMethod;
  }

  /// Check In API
  void checkInApi(
      context,
      int? remoteModeType,
      String? currentDateSever,
      String? currentTimeServer,
      String? youLocationServer,
      String? latitudeServer,
      String? longitudeServer,
      String? cityServer,
      String? countryCodeServer,
      String? countryServer,
      String? qrCode) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    BodyCheckIn bodyCheckIn = BodyCheckIn(
        userId: userId,
        remoteModeIn: remoteModeType ?? 1,
        date: currentDateSever,
        checkIn: currentTimeServer,
        checkInLocation: youLocationServer,
        checkInLatitude: latitudeServer,
        checkInLongitude: longitudeServer,
        city: cityServer,
        countryCode: countryCodeServer,
        country: countryServer,
        reason: lateCheckInController.text,
        qrCode: qrCode);
    var apiResponse = await Repository.checkInApi(bodyCheckIn);

    if (apiResponse.result == true) {
      NavUtil.replaceScreen(context, const ButtomNavigationBar());

      notifyListeners();
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
            return CustomDialogError(
              title: "Error",
              subTitle: apiResponse.error?.message.toString() ?? "",
            );
          });
      if (kDebugMode) {
        print(apiResponse.error?.message.toString());
      }
    }
  }

  /// check out

  /// Check Out API
  void checkOutApi(
      context,
      int? remoteModeType,
      String? currentDateSever,
      String? currentTimeServer,
      String? youLocationServer,
      String? latitudeServer,
      String? longitudeServer,
      String? cityServer,
      String? countryCodeServer,
      String? countryServer,
      int? attendanceCheckInID) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyCheckOut = BodyCheckOut(
        userId: userId,
        remoteModeOut: remoteModeType ?? 1,
        date: currentDateSever,
        checkOut: currentTimeServer,
        checkOutLocation: youLocationServer,
        checkOutLatitude: latitudeServer,
        checkOutLongitude: longitudeServer,
        city: cityServer,
        countryCode: countryCodeServer,
        country: countryServer,
        reason: lateCheckInController.text);
    var apiResponse =
        await Repository.checkOutApi(bodyCheckOut, attendanceCheckInID);
    if (apiResponse.result == true) {
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
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
            return CustomDialogError(
              title: "Error",
              subTitle: apiResponse.error?.message.toString() ?? "",
            );
          });
      if (kDebugMode) {
        print(apiResponse.error?.message.toString());
      }
    }
  }

  void getReasonApi(
    int? lateReasonId,
    String? type,
    context,
  ) async {
    if (lateCheckInController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogEmptyField(
              title: "Filed Empty",
              subTitle: "Give a Reason. Field cannot be empty",
            );
          });
    } else {
      var bodyLateReason =
          BodyLateReason(type: type, reason: lateCheckInController.text);
      var apiResponse =
          await Repository.lateReasonApi(bodyLateReason, lateReasonId);
      if (apiResponse.result == true) {
        Fluttertoast.showToast(
            msg: apiResponse.message ?? "",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12.0);
        NavUtil.replaceScreen(
            context,
            const Attendance(
              navigationMenu: false,
            ));
      } else {
        Fluttertoast.showToast(
            msg: "something went wong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
      }
    }
  }
}
