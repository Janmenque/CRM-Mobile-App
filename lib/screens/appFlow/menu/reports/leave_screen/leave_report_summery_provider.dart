import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/report_response/leave_response/report_leave_summery_response.dart';
import 'package:hrm_app/data/server/respository/report_repository/leave_report_repository/report_leave_summery_repository.dart';
import 'package:intl/intl.dart';

class ReportLeaveSummaryProvider extends ChangeNotifier{
  String? currentMonth;
  String? monthYear;
  DateTime? selectedDate;
  ReportLeaveSummeryResponse? summeryResponse;
  bool isLoading = false;

  ReportLeaveSummaryProvider(){
    getDate();
    getSupportSummeryList();
  }

  Future getSupportSummeryList() async {
    final data = {'date': monthYear};
    final response =
    await LeaveReportRepository.postLeaveSummery(data);
    if (response.result == true) {
      summeryResponse = response.data;
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
        getSupportSummeryList();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}