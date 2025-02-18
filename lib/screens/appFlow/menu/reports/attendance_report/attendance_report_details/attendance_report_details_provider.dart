import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/report_response/attendance_response/report_attendance_list_reponse.dart';
import 'package:hrm_app/data/server/respository/report_repository/attendance_report_repository/attendance_report_repository.dart';


class AttendanceReportDetailsProvider extends ChangeNotifier {
  ReportAttendanceListResponse? attendanceListResponse;
  bool isLoading = false;

  AttendanceReportDetailsProvider(String endpoint, date) {
    postSummeryList(endpoint, date);
  }

  Future postSummeryList(endpoint, date) async {
    final data = {'type': endpoint, 'date': date};
    final response =
        await AttendanceReportRepository.postReportAttendanceList(data);
    if (response.result == true) {
      attendanceListResponse = response.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: tr("something_went_wrong"));
    }
  }
}
