import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_details_response.dart';
import 'package:hrm_app/data/server/respository/daily_leave_repository/daily_leave_repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class DailyLeaveDetailsProvider extends ChangeNotifier {
  String leave = '';
  DailyLeaveDetailsResponse? detailsResponse;
  int? employeeId;
  String? date;
  String? leaveType;
  bool isLoading = false;

  DailyLeaveDetailsProvider(String leaveStatus, String dateMonth, onLeave ,{int? id}) {
    employeeId = id;
    date = dateMonth;
    leave = leaveStatus;
    leaveType = onLeave;
    detailsLeave();
  }

  Future detailsLeave() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var id = employeeId ?? userId;
    final data = {'month': date, 'user_id': id,'leave_type': leaveType, 'leave_status': leave};
    final response = await DailyLeaveRepository.dailyLeaveDetails(data);
    detailsResponse = response.data;
    isLoading = true;
    notifyListeners();
  }
}
