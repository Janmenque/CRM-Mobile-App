import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_support_ticket_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class SupportTicketProvider extends ChangeNotifier {
  ResponseSupportTicketList? responseSupportTicketList;
  DateTime? selectedDate;
  String? currentMonth;
  String? monthYear;
  int? value = 0;
  String? buttonStatus;
  bool isLoading = false;

  SupportTicketProvider() {
    getDate();
    supportTicketApi();
  }
  onSelected(bool selected, int index, int? designationId) {
    value = selected ? index : null;
    if (value == 0) {
      buttonStatus = "12";
    } else if (value == 1) {
      buttonStatus = "13";
    } else if (value == 2) {
      buttonStatus = "";
    } else {
      buttonStatus = "";
    }
    supportTicketApi();
    notifyListeners();
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
        supportTicketApi();
        if (kDebugMode) {
          print(DateFormat('y-MM').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  void supportTicketApi() async {
    var bodySupportTicket =
        BodySupportTicket(type: buttonStatus, month: currentMonth);

    var apiResponse = await Repository.supportTicketListApi(bodySupportTicket);
    if (apiResponse.result == true) {
      responseSupportTicketList = apiResponse.data;
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
