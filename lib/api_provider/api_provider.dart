import 'package:flutter/foundation.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_base_settings.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class ApiProvider extends ChangeNotifier {
  String? checkStatus;
  bool? checkIn;
  bool? checkOut;

  bool? isFaceRegistered;

  int? inHour, inMin, inSec;
  int? outHour, outMin, outSec;
  bool? isHr;
  bool? isAdmin;
  ResponseBaseSetting? baseSetting;

  ApiProvider() {
    setAttendanceStatus();
    getBaseSetting();
  }

  setAttendanceStatus() {
    checkStatus = "Check In";
    notifyListeners();
  }

  /// check In-out status API
  checkInCheckOutStatus() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
    var apiResponse = await Repository.attendanceStatus(bodyUserId);
    if (apiResponse.result == true) {
      checkIn = apiResponse.data?.data?.checkin;
      checkOut = apiResponse.data?.data?.checkout;
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
    }
  }

  getBaseSetting() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.data != null) {
      baseSetting = apiResponse.data;
      isFaceRegistered = baseSetting?.data?.isFaceRegistered;
      if (kDebugMode) {
        print('isFaceRegistered $isFaceRegistered');
      }
      isHr = baseSetting?.data?.isHr;
      isAdmin = baseSetting?.data?.isAdmin;
      inHour = baseSetting?.data?.dutySchedule?.startTime?.hour;
      inMin = baseSetting?.data?.dutySchedule?.startTime?.min;
      inSec = baseSetting?.data?.dutySchedule?.startTime?.sec;

      outHour = baseSetting?.data?.dutySchedule?.endTime?.hour;
      outMin = baseSetting?.data?.dutySchedule?.endTime?.min;
      outSec = baseSetting?.data?.dutySchedule?.endTime?.sec;
      notifyListeners();
    }
  }
}
