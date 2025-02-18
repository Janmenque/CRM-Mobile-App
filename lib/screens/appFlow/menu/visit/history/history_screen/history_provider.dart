import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_visit_history.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class HistoryProvider extends ChangeNotifier {
  String? currentMonth;
  ResponseVisitHistory? responseVisitHistory;
  DateTime? selectedDate;
  String? monthYear;
  bool isLoading = false;

  HistoryProvider() {
    getDate();
    getHistoryVisit();
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
        getHistoryVisit();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  /// Get current date and Format
  getDate() {
    DateTime currentDate = DateTime.now();
    currentMonth = DateFormat('y-MM').format(currentDate);
    monthYear = DateFormat('MMMM,y').format(currentDate);
    notifyListeners();
  }

  getHistoryVisit() async {
    var bodyHistory = BodyAttendanceReport(month: currentMonth);

    /// Notice body and attendance body are some
    var apiResponse = await Repository.historyVisitApi(bodyHistory);
    if (apiResponse.result == true) {
      isLoading = true;
      responseVisitHistory = apiResponse.data;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
