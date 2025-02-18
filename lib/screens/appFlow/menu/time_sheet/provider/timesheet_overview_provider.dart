import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';
import 'package:hrm_app/utils/res.dart';

class TimeSheetOverviewProvider extends ChangeNotifier {

  TimesheetListModel? timesheetListResponse;
  TimesheetRelatedDataModel? timesheetRelatedResponse;
  TimesheetTaskListModel? timesheetTaskListResponse;

  TimesheetProject? project;
  TimesheetEmployee? employee;
  TimesheetEmployee? employeeForSearch;
  TimesheetTask? task;

  bool isLoading = false;

  final noteController = TextEditingController();

  String? dateForCreateTimeSheet;
  DateTime? selectedDateForCreate;

  String? dateForSearchTimeSheet;
  DateTime? selectedDateForSearch;

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Duration? duration;

  // TimeOfDay? get startTime => startTime;
  // TimeOfDay? get endTime => endTime;
  int? get durationInMinutes => duration?.inMinutes;

  String get formattedDuration => duration != null
      ? "${duration!.inHours.toString().padLeft(2, '0')}:${(duration!.inMinutes % 60).toString().padLeft(2, '0')}"
      : "Duration";

  void selectStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      startTime = pickedTime;
      calculateDuration();
      notifyListeners();
    }
  }

  void selectEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      endTime = pickedTime;
      calculateDuration();
      notifyListeners();
    }
  }

  void calculateDuration() {
    if (startTime != null && endTime != null) {
      final startDateTime = DateTime(0, 0, 0, startTime!.hour, startTime!.minute);
      final endDateTime = DateTime(0, 0, 0, endTime!.hour, endTime!.minute);

      if (endDateTime.isAfter(startDateTime)) {
        duration = endDateTime.difference(startDateTime);
      } else {
        duration = null;
      }
    }
  }


  TimeSheetOverviewProvider(){
    getTimesheetRelatedData();
  }


  selectedProject(TimesheetProject projectValue){
    project = projectValue;
    task = null;
    notifyListeners();
    getTimesheetTaskData(project?.id ?? 0);
    notifyListeners();
  }


  selectedEmployee(TimesheetEmployee employeeValue){
    employee = employeeValue;
    notifyListeners();
  }


  selectedEmployeeForSearch(TimesheetEmployee searchEmployeeValue){
    employeeForSearch = searchEmployeeValue;
    getTimesheetListData(employeeForSearch?.id ?? 0, "");
    dateForSearchTimeSheet = "select date";
    notifyListeners();
  }


  selectedTask(TimesheetTask taskValue){
    task = taskValue;
    notifyListeners();
  }


  ///get timesheet related data
  getTimesheetRelatedData() async {
    final response = await CrmTimesheetRepository.getTimesheetRelatedData();
    if (response.httpCode == 200) {
      timesheetRelatedResponse = response.data;
    }
    notifyListeners();
  }


  ///get timesheet task data
  getTimesheetTaskData(int projectId) async {
    final response = await CrmTimesheetRepository.getTimesheetTaskData(projectId);
    if (response.httpCode == 200) {
      timesheetTaskListResponse = response.data;
    }
    notifyListeners();
  }



  ///timesheet list
  getTimesheetListData(int? employeeId, String? date) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getTimesheetList(employeeId, date);
    isLoading = false;
    if(response.httpCode == 200) {
      timesheetListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }


  /// selected date method for create timesheet
  Future selectDateForCreate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDateForCreate = date;
        notifyListeners();
        dateForCreateTimeSheet = DateFormat('yyyy-MM-dd').format(selectedDateForCreate!);
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedDateForCreate!));
        }
        notifyListeners();
      }
    });
  }




  ///create timeSheet
  Future createTimeSheet(context) async {
    final data = FormData.fromMap({
      "date"          : dateForCreateTimeSheet,
      "employee_id"   : employee?.id ?? 0,
      "project_id"    : project?.id ?? 0,
      "task_id"       : task?.id ?? 0,
      "start_time"    : startTime?.format(context),
      "end_time"      : endTime?.format(context),
      "duration"      : durationInMinutes,
      "note"          : noteController.text
    });
    final response = await CrmTimesheetRepository.createTimeSheet(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getTimesheetListData(0, "");
      notifyListeners();
      noteController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }




  /// selected date method for search
  Future selectDateForSearch(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDateForSearch = date;
        dateForSearchTimeSheet = DateFormat('yyyy-MM-dd').format(selectedDateForSearch!);
        getTimesheetListData(0, dateForSearchTimeSheet ?? "");
        employeeForSearch = null;
        notifyListeners();
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedDateForSearch!));
        }
        notifyListeners();
      }
    });
  }






}