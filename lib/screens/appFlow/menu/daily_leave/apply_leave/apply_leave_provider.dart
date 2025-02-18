import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/daily_leave_repository/daily_leave_repository.dart';

class ApplyLeaveProvider extends ChangeNotifier {
  final reasonController = TextEditingController();
  TimeOfDay? selectedTime;
  String? approxTime;
  LeaveTypeModel? leaveType;
  bool isChecked = true;

  ///leave type defined
  List<LeaveTypeModel>? leave = [
    LeaveTypeModel(title: 'Early Leave', value: 'early_leave'),
    LeaveTypeModel(title: 'Late Arrive', value: 'late_arrive'),
  ];

  Future<bool> applyLeave(context) async {
    if (leaveType != null && approxTime != null) {
      final data = {
        'approx_time': approxTime,
        'reason': reasonController.text,
        'leave_type': leaveType!.value
      };

      final response = await DailyLeaveRepository.createDailyLeaveRequest(data);
      if (response['result'] == true) {
        Fluttertoast.showToast(msg: response['message']);
        Navigator.pop(context);
      }
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Select Approximate time and Leave Type');
    }
    return false;
  }

  void setChecked(value) {
    leaveType = value;
    notifyListeners();
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((date) {
      if (date != null) {
        selectedTime = date;
        approxTime = selectedTime!.format(context);
        if (kDebugMode) {
          print('Time ${selectedTime!.format(context)}');
        }
        notifyListeners();
      }
    });
  }
}

class LeaveTypeModel {
  String? title;
  String? value;

  LeaveTypeModel({this.title, this.value});
}
