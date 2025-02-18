import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_all_leave_request.dart';
import 'package:hrm_app/data/model/response_leave_summary.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_employee_search.dart';
import 'package:hrm_app/data/model/response_user_search.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class EmployeeLeaveHistoryProvider extends ChangeNotifier{
  User? userObj;
  ResponseOfficialInfo? officialInfo;
  ResponseLeaveSummary? responseLeaveSummary;
  ResponseAllLeaveRequest? leaveTypeList;
  String? currentMonth;
  bool isLoading = false;
  String? monthYear;
  DateTime? selectedDate;

  EmployeeLeaveHistoryProvider(){
    getOfficialInfo();
    getLeaveSummary();
    allLeaveRequest();
    getDate();
  }

  /// get Leave summary API
  getLeaveSummary() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var userId = userObj?.id ?? userIdKey;
    var bodyUserId = BodyUserId(userId: userId);
    final apiResponse = await Repository.leaveSummary(bodyUserId);
    if (apiResponse.result == true) {
      responseLeaveSummary = apiResponse.data;
      notifyListeners();
    }
    notifyListeners();
  }

  /// get data from EmployeeData screen
  void getEmployeeData(BuildContext context) async {
    userObj = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AttendanceEmployeeSearch()),
    );
    getOfficialInfo();
    getLeaveSummary();
    allLeaveRequest();
    getDate();
    notifyListeners();
  }

  /// Get current date and Format
  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM').format(currentDate);
    monthYear = DateFormat('MMMM,y').format(currentDate);
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        currentMonth = DateFormat('y-MM').format(selectedDate!);
        monthYear = DateFormat('MMMM,y').format(selectedDate!);
        allLeaveRequest();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
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

  ///get all leave request list
  Future allLeaveRequest() async {
    var userIdKey = await SPUtill.getIntValue(SPUtill.keyUserId);
    var userId = userObj?.id ?? userIdKey;
    var bodyLeaveRequest = BodyLeaveRequest(userId: userId,month: currentMonth);
    var apiResponse = await Repository.allLeaveRequest(bodyLeaveRequest);
    if (apiResponse.result == true) {
      leaveTypeList = apiResponse.data;
      isLoading = true;
      if (kDebugMode) {
        print(leaveTypeList?.data?.availableLeave);
      }
      notifyListeners();
    } else {

    }
  }

}
