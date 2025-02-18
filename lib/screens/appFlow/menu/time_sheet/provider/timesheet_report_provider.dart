import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/time_sheet_report_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';

class TimesheetReportProvider extends ChangeNotifier {

  TimesheetReportListModel?   timesheetReportListResponse;
  TimesheetRelatedDataModel?  timesheetRelatedResponse;
  TimesheetTaskListModel?     timesheetTaskListResponse;
  ClientListModel?            crmClientListResponse;

  bool isLoading = false;

  TimesheetEmployee? employee;
  TimesheetProject? project;
  TimesheetTask? task;
  Client? client;

  String?   startDate;
  String?   endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  TimesheetReportProvider(){
    getTimesheetRelatedData();
    getCrmClientListData();
  }


  ///select project
  selectedProject(TimesheetProject projectValue){
    project = projectValue;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    employee = null;
    client = null;
    notifyListeners();
    getTimesheetTaskData(project?.id ?? 0);
    getTimesheetReportData("", "", project?.id ?? 0, task?.id ?? 0, 0, 0);
    notifyListeners();
  }



  ///select employee
  selectedEmployee(TimesheetEmployee employeeValue){
    employee = employeeValue;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    project = null;
    task = null;
    client = null;
    notifyListeners();
    getTimesheetReportData("", "", 0, 0, employee?.id ?? 0, 0);
    notifyListeners();
  }



  ///select task
  selectedTask(TimesheetTask taskValue){
    task = taskValue;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    employee = null;
    client = null;
    notifyListeners();
    getTimesheetReportData("", "", project?.id ?? 0, task?.id ?? 0, 0, 0);
    notifyListeners();
  }



  ///select client
  selectedClient(Client clientValue){
    client = clientValue;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    project = null;
    employee = null;
    task = null;
    notifyListeners();
    getTimesheetReportData("", "", 0, 0, 0, client?.id ?? 0);
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



  /// get client list data
  getCrmClientListData() async {
    final response = await CrmTimesheetRepository.getCrmClientList();
    if (response.httpCode == 200) {
      crmClientListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }



  ///get timesheet Report data
  getTimesheetReportData(String startDate, String endDate, int projectId, int taskId, int employeeId, int clientId) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getTimesheetReportData(startDate, endDate, projectId, taskId, employeeId, clientId);
    isLoading = false;
    if (response.httpCode == 200) {
      timesheetReportListResponse = response.data;
    }
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
        getTimesheetReportData(startDate ?? "", endDate ?? "", 0, 0, 0, 0);
        notifyListeners();
      }
    });
  }

}