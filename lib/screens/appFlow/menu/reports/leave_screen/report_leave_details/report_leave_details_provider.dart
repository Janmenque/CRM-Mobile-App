import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/report_response/leave_response/report_leave_details_response.dart';
import 'package:hrm_app/data/server/respository/report_repository/leave_report_repository/report_leave_summery_repository.dart';

class ReportLeaveDetailsProvider extends ChangeNotifier{

  String? monthYear;
  int? leaveId;
  LeaveReportDetailsResponse? reportDetailsResponse;
  bool isLoading = false;

  ReportLeaveDetailsProvider(date, id){
    monthYear = date;
    leaveId = id;
    getSupportSummeryList();
  }

  Future getSupportSummeryList() async {
    final data = {
      "date" : monthYear,
      "leave_type" : leaveId
    };

    final response =
    await LeaveReportRepository.postLeaveDetailsSummery(data);
    if (response.result == true) {
      reportDetailsResponse = response.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

}