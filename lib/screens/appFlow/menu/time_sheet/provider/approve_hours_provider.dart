import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/approve_hours_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';

class ApproveHoursProvider extends ChangeNotifier {

  ApproveHourListModel? approveHourListResponse;
  TimesheetRelatedDataModel? timesheetRelatedResponse;

  TimesheetProject? project;
  TimesheetEmployee? employee;

  bool isLoading = false;

  String? startDate;
  String? endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;




  ApproveHoursProvider(){
    getTimesheetRelatedData();

  }



  selectedProject(TimesheetProject projectValue){
    project = projectValue;
    employee = null;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    notifyListeners();
    getApproveHourData("", "",project?.id ?? 0,0);
    notifyListeners();
  }


  selectedEmployee(TimesheetEmployee employeeValue){
    employee = employeeValue;
    project = null;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    notifyListeners();
    getApproveHourData("", "",0, employee?.id ?? 0);
    notifyListeners();
  }

  ///ApproveHour list data
  getApproveHourData(String startDate, String endDate, int projectId, int employeeId) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getApproveHoursData(startDate, endDate, projectId, employeeId,);
    if (response.httpCode == 200) {
      approveHourListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
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
        getApproveHourData(startDate ?? "", endDate ?? "",0, 0 );
        notifyListeners();
      }
    });
  }


}