import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/resource_plan_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AllocateResourceProvider extends ChangeNotifier {

  TimesheetRelatedDataModel? timesheetRelatedResponse;
  TimesheetTaskListModel?    timesheetTaskListResponse;
  final commentController = TextEditingController();

  bool isLoading = false;

  List<TimesheetEmployee> selectedEmployeeList = [];
  TimesheetProject? project;
  TimesheetTask? task;

  String?   startDate;
  String?   endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;


  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Duration? duration;

  int? get durationInMinutes => duration?.inMinutes;

  String get formattedDuration => duration != null
      ? "${duration!.inHours.toString().padLeft(2, '0')}:${(duration!.inMinutes % 60).toString().padLeft(2, '0')}"
      : "Duration";



  AllocateResourceProvider(){
    getTimesheetRelatedData();
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



  ///create Allocate Resource
  Future createAllocateResource(context) async {
    final data = FormData.fromMap({
      "employee_id[]" : selectedEmployeeList.isNotEmpty ? selectedEmployeeList.map((employee) => employee.id).toList() : null,
      "project_id"    : project?.id ?? 0,
      "task_id"       : task?.id ?? 0,
      "start_date"    : startDate,
      "end_date"      : endDate,
      "start_time"    : startTime?.format(context),
      "end_time"      : endTime?.format(context),
      "total_time"    : durationInMinutes?.toInt(),
      "comments"      : commentController.text
    });
    final response = await CrmTimesheetRepository.createResourcePlan(data);
    if(response.httpCode == 200){
      Navigator.pop(context);
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      notifyListeners();
      Provider.of<ResourcePlanProvider>(context, listen: false).getTimesheetResourcePlan();
      notifyListeners();
      commentController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  ///select project
  selectedProject(TimesheetProject projectValue){
    project = projectValue;
    getTimesheetTaskData(project?.id ?? 0);
    notifyListeners();
  }



  ///select employee
  void toggleEmployee(TimesheetEmployee employee) {
    if (selectedEmployeeList.any((element) => element.id == employee.id)) {
      selectedEmployeeList.removeWhere((element) => element.id == employee.id);
    } else {
      selectedEmployeeList.add(employee);
    }
    notifyListeners();
  }



  ///select task
  selectedTask(TimesheetTask taskValue){
    task = taskValue;
    notifyListeners();
  }



  /// selected start date method
  Future selectStartDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedStartDate = date;
        notifyListeners();
        startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
        notifyListeners();
      }
    });
  }


  /// selected end date method
  Future selectEndDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedEndDate = date;
        notifyListeners();
        endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
        notifyListeners();
      }
    });
  }


  ///select Start Time
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



  ///select End Time
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



  ///Calculate Time
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




}