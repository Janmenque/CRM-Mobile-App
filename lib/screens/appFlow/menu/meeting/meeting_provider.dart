import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_meeting_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:intl/intl.dart';
import '../../../../utils/month_picker_dialog/month_picker_dialog.dart';

class MeetingProvider extends ChangeNotifier{
  ResponseMeetingList? responseMeetingList;
  String? monthYear;
  String? formData;
  DateTime? selectedDate;
  bool isLoading = false;
  MeetingProvider(){
    getDate();
    getMeetingList();
  }

  Future getMeetingList() async {
    final data = {
      'month' : formData
    };
    final response = await Repository.postMeetingList(data);
    if(response.result == true){
      responseMeetingList = response.data;
      notifyListeners();
      isLoading = true;
    }else{
      Fluttertoast.showToast(msg: "Something went wrong");
    }

  }


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
        getMeetingList();
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }
}