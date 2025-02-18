import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_meeting_list.dart';
import 'package:hrm_app/data/server/respository/appointment/appointment_repository.dart';
import 'package:intl/intl.dart';

import '../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class AppointmentProvider extends ChangeNotifier {
  ResponseMeetingList? appointmentListModel;
  String? monthYear;
  String? formData;
  DateTime? selectedDate;
  bool isLoading = false;

  AppointmentProvider() {
    getDate();
    getAppointmentList();
  }

  Future getAppointmentList() async {
    final data = {
      'month' : formData
    };
    final response = await AppointmentRepository.postAppointmentList(data);
    if(response.result == true){
      appointmentListModel = response.data;
      isLoading = true;
      notifyListeners();
    }else{
      Fluttertoast.showToast(msg: "Something went wrong");
    }

  }

  ///for Expense list page
  getDate() {
    DateTime currentDate = DateTime.now();
    monthYear = DateFormat('MMMM,y').format(currentDate);
    formData = DateFormat('y-MM').format(currentDate);
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
        monthYear = DateFormat('MMMM,y').format(selectedDate!);
        formData = DateFormat('y-MM').format(selectedDate!);
        getAppointmentList();
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}
