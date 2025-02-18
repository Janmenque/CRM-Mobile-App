import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_leave_type.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_calender/leave_calender.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class LeaveTypeProvider extends ChangeNotifier {
  ResponseLeaveType? leaveTypeList;
  AvailableLeave? selectedLeaveType;
  int? leaveTypeId;
  bool isLoading = false;

  LeaveTypeProvider() {
    leaveTypeApi();
  }

  /// select leave type
  void leaveTypeSelected(AvailableLeave val) {
    selectedLeaveType = val;


    leaveTypeId = selectedLeaveType?.id;
    if (kDebugMode) {
      print(selectedLeaveType?.id);
    }
    notifyListeners();
  }

  /// leave Type API
  void leaveTypeApi() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyUserId = BodyUserId(userId: userId);
    var apiResponse = await Repository.leaveTypeApi(bodyUserId);
    if (apiResponse.result == true) {
      leaveTypeList = apiResponse.data;
      isLoading = true;
      notifyListeners();
    } else {
      if (kDebugMode) {
        print(apiResponse.data!.message);
      }
    }
  }

  void getLeaveType(BuildContext context) {
    if (leaveTypeId != null) {
      selectedLeaveType = null;
      NavUtil.replaceScreen(
          context,
          LeaveCalender(
            leaveTypeId: leaveTypeId,
          ));
      Navigator.canPop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomDialogError(
              title: "Select leave type",
              subTitle:
                  "you must be select a leave type.please select what kind of leave you want to take ",
            );
          });
    }
  }
}
