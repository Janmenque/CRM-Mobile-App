import 'package:flutter/foundation.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_emergency.dart';
import 'package:hrm_app/data/model/response_financial.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/model/response_personal.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class MyAccountProvider extends ChangeNotifier {
  ResponseOfficialInfo? officialInfo;
  ResponsePersonal? personalInfo;
  ResponseFinancial? financialInfo;
  ResponseEmergency? emergencyInfo;

  MyAccountProvider() {
    getOfficialInfo();
    getPersonalInfo();
    getFinancialInfo();
    getEmergencyInfo();
  }

  /// getOfficialInfo API .............
  void getOfficialInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);

    var apiResponseOfficial =
        await ProfileRepository.getOfficialInfo(bodyUserId, AppConst.officialSlug);
    if (apiResponseOfficial.result == true) {
      officialInfo = apiResponseOfficial.data;
      if (kDebugMode) {
        print(apiResponseOfficial.data);
      }
      notifyListeners();
    } else {
      final errorMessage = apiResponseOfficial.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  /// getPersonalInfo API .............
  void getPersonalInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);

    var apiResponsePersonal =
        await ProfileRepository.getPersonalInfo(bodyUserId, AppConst.personalSlug);
    if (apiResponsePersonal.result == true) {
      personalInfo = apiResponsePersonal.data;
      if (kDebugMode) {
        print(apiResponsePersonal.data);
      }

      notifyListeners();
    } else {
      final errorMessage = apiResponsePersonal.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  /// getFinancialInfo API .............
  void getFinancialInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);

    var apiResponseFinancial =
        await ProfileRepository.getFinancialInfo(bodyUserId, AppConst.financialSlug);
    if (apiResponseFinancial.result == true) {
      financialInfo = apiResponseFinancial.data;
      if (kDebugMode) {
        print(apiResponseFinancial.data);
      }
      notifyListeners();
    } else {
      final errorMessage = apiResponseFinancial.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  /// getEmergencyInfo API .............
  void getEmergencyInfo() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);

    var apiResponseEmergency =
        await ProfileRepository.getEmergencyInfo(bodyUserId, AppConst.emergencySlug);
    if (apiResponseEmergency.result == true) {
      emergencyInfo = apiResponseEmergency.data;
      if (kDebugMode) {
        print(apiResponseEmergency.data);
      }
      notifyListeners();
    } else {
      final errorMessage = apiResponseEmergency.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }
}
