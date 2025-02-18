import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/report_response/attendance_response/r_attendence_response.dart';
import 'package:hrm_app/data/server/respository/report_repository/attendance_report_repository/attendance_report_repository.dart';
import 'package:intl/intl.dart';

class AttendanceSummeryProvider extends ChangeNotifier {
  String? currentMonth;
  String? monthYear;
  DateTime? selectedDate;
  ReportAttendanceResponse? attendanceResponse;
  bool isLoading = false;

  AttendanceSummeryProvider() {
    getDate();
    postSupportSummeryList();
  }

  Future postSupportSummeryList() async {
    final data = {'date': monthYear};
    final response =
        await AttendanceReportRepository.postReportAttendance(data);
    if (response.result == true) {
      attendanceResponse = response.data;
      isLoading = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  /// Get current date and Format
  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM').format(currentDate);
    monthYear = DateFormat('y-M-d').format(currentDate);
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        currentMonth = DateFormat('y-MM').format(selectedDate!);
        monthYear = DateFormat('y-M-d').format(selectedDate!);
        postSupportSummeryList();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}
