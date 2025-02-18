import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_break_report.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class BreakReportProvider extends ChangeNotifier{
  DateTime? breakDate;
  DateTime? selectedDate;
  ResponseBreakReport? responseBreakReport;
  bool isLoading = false;
  BreakReportProvider(){
    breakReportHistory();
  }


  void breakReportHistory() async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyBreakReport = BodyBreakReport(date: breakDate?.toLocal().toString().split(" ")[0] ?? "",userId: userId);
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

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: breakDate != null
            ? breakDate!.toLocal()
            : DateTime.now(),
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