import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_clear_notification.dart';
import 'package:hrm_app/data/model/response_notice_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class NoticeProvider extends ChangeNotifier {
  ResponseNoticeList? responseNoticeList;
  ResponseClearNotification? responseClearNotice;
  DateTime? selectedDate;
  String? currentMonth;
  String? monthYear;
  bool isLoading = false;
  bool? hrOrAdmin;

  NoticeProvider() {
    getHrOrAdmin();
    getDate();
    noticeList();
  }

  Future getHrOrAdmin() async {
    bool? isHr = await SPUtill.getBoolValue(SPUtill.keyIsHr);
    bool? isAdmin = await SPUtill.getBoolValue(SPUtill.keyIsAdmin);
    if (isHr == true || isAdmin == true) {
      hrOrAdmin = true;
      notifyListeners();
    } else {
      hrOrAdmin = false;
      notifyListeners();
    }
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
        noticeList();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  void clearNoticeApi() async {
    var apiResponse = await Repository.clearNoticeApi();
    if (apiResponse.result == true) {
      responseClearNotice = apiResponse.data;
      isLoading = true;
      noticeList();
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

  void noticeList() async {
    var bodyNoticeList = BodyAttendanceReport(month: currentMonth);

    /// Notice body and attendance body are some
    var apiResponse = await Repository.noticeListApi(bodyNoticeList);
    if (apiResponse.result == true) {
      responseNoticeList = apiResponse.data;
      isLoading = true;
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
