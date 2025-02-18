import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_single_view_response.dart';
import 'package:hrm_app/data/server/respository/daily_leave_repository/daily_leave_repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class DailyLeaveSingleViewProvider extends ChangeNotifier {
  DailyLeaveSingleViewResponse? viewResponse;
  int? leaveId;
  bool? isHr;

  DailyLeaveSingleViewProvider(id) {
    getHr();
    leaveId = id;
    getViewResponse();
  }

  Future getHr() async {
    isHr = await SPUtill.getBoolValue(SPUtill.keyIsHr);
    if (kDebugMode) {
      print('is Hr $isHr');
    }
  }

  Future getViewResponse() async {
    final data = {
      'leave_id': leaveId,
    };
    final response = await DailyLeaveRepository.dailyLeaveSingleView(data);
    viewResponse = response.data;
    notifyListeners();
  }

  Future leaveApproval(String? leaveStatus, context) async {
    final data = {'leave_id': leaveId, 'leave_status': leaveStatus};
    final response =
        await DailyLeaveRepository.createLeaveApprovedRejected(data);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: response['message']);
      await getViewResponse();
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: tr('something_went_wrong'));
    }
  }
}
