import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_break_report.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/model/response_user_search.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_employee_search.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class BreakReportSearchProvider extends ChangeNotifier {
  DateTime? breakDate;
  DateTime? selectedDate;
  ResponseBreakReport? responseBreakReport;
  bool isLoading = false;
  User? userObj;
  ResponseOfficialInfo? officialInfo;

  BreakReportSearchProvider() {
    breakReportHistory();
    getOfficialInfo();
  }

  void breakReportHistory() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyBreakReport = BodyBreakReport(
        date: breakDate?.toLocal().toString().split(" ")[0] ?? "",
        userId: userObj?.id ?? userIdKey);
    var apiResponse = await Repository.breakReportHistory(bodyBreakReport);
    if (apiResponse.result == true) {
      responseBreakReport = apiResponse.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  /// get data from EmployeeData screen
  void getEmployeeData(BuildContext context) async {
    userObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AttendanceEmployeeSearch()),
    );
    breakReportHistory();
    getOfficialInfo();
    notifyListeners();
  }

  /// getOfficialInfo API .............
  void getOfficialInfo() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(
      userId: userObj?.id ?? userIdKey,
    );

    var apiResponseOfficial = await ProfileRepository.getOfficialInfo(
        bodyUserId, AppConst.officialSlug);
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

  /// Select date data of joining function.....
  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: breakDate != null ? breakDate!.toLocal() : DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      breakDate = selectedDate!.toLocal();
      breakReportHistory();
      notifyListeners();
    }
  }
}
