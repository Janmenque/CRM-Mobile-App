import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';

class CreateVisitProvider extends ChangeNotifier {
  var visitTitleTextController = TextEditingController();
  var visitDescriptionTextController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  ResponseOfficialInfo? officialInfo;
  String? visitDate;
  String? errorMassage;
  String? titleError;


  CreateVisitProvider() {
    getOfficialInfo();
  }

  void resetTextField() {
    visitTitleTextController.text = "";
    notifyListeners();
  }


  /// select date ......
  Future selectDate(BuildContext context) async {
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

  /// getOfficialInfo API .............
  void getOfficialInfo() async {
    visitDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(
      userId: userId,
    );

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

  /// getCreateVisit API .............
  void getCreateVisit(context) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyCreateVisit = BodyCreateVisit(
        userId: userId,
        title: visitTitleTextController.text,
        description: visitDescriptionTextController.text,
        date: visitDate);
    var apiResponse = await Repository.createVisitApi(bodyCreateVisit);
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
      resetTextField();
      NavUtil.replaceScreen(context, const VisitScreen());
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      titleError = apiResponse.error?.laravelValidationError?.title;
      errorMassage = apiResponse.message;
      notifyListeners();
    }
  }
}
