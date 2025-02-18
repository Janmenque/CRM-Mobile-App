import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_all_leave_request.dart';
import 'package:hrm_app/data/model/response_approval_list.dart';
import 'package:hrm_app/data/model/response_leave_summary.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_type/leave_type.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class LeaveSummaryProvider extends ChangeNotifier {
  ResponseLeaveSummary? responseLeaveSummary;
  ResponseApprovalList? approvalList;
  ResponseAllLeaveRequest? leaveTypeList;
  bool isLoading = false;
  int tabIndex = 0;
  String? monthYear;
  String? currentMonth;
  DateTime? selectedDate;

  LeaveSummaryProvider(AnimationController controller, context) {
    applyLeave(controller, context);
    getLeaveSummary();
    getApprovalList();
    allLeaveRequest();
    getDate();
  }

  applyLeave(AnimationController controller, context) {
    controller.addListener(() {
      if (controller.value.toInt() == 1) {
        NavUtil.navigateScreen(context, const LeaveType());
        controller.reset();
      } else {}
      notifyListeners();
    });
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

  ///get all leave request list
  Future allLeaveRequest() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
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

  tabViewList(int index) {
    tabIndex = index;
    notifyListeners();
  }

  getApprovalList() async {
    var apiResponse = await Repository.getApprovalListApi();
    if (apiResponse.result == true) {
      approvalList = apiResponse.data;
      notifyListeners();
    } else {}
  }

  /// get Leave summary API
  getLeaveSummary() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
    final apiResponse = await Repository.leaveSummary(bodyUserId);
    if (apiResponse.result == true) {
      responseLeaveSummary = apiResponse.data;
      notifyListeners();
    }
    notifyListeners();
  }
}
