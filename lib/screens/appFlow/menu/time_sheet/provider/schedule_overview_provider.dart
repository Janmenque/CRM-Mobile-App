import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/schedule_overview_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';

class ScheduleOverProvider extends ChangeNotifier {

  ScheduleOverviewModel? scheduleOverviewResponse;
  TimesheetRelatedDataModel? timesheetRelatedResponse;

  TimesheetProject? project;
  TimesheetEmployee? employee;

  bool isLoading = false;

  String? startDate;
  String? endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;




  ScheduleOverProvider(){
    getTimesheetRelatedData();
  }



  selectedProject(TimesheetProject projectValue){
    project = projectValue;
    employee = null;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    notifyListeners();
    getScheduleOverviewData("", "", 0,  project?.id ?? 0);
    notifyListeners();
  }


  selectedEmployee(TimesheetEmployee employeeValue){
    employee = employeeValue;
    project = null;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    notifyListeners();
    getScheduleOverviewData("", "",0, employee?.id ?? 0);
    notifyListeners();
  }

  ///Schedule overview data
  getScheduleOverviewData(String startDate, String endDate, int projectId, int employeeId) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getScheduleOverviewData(
      startDate ?? "",
      endDate ?? "",
      projectId ?? 0,
      employeeId ?? 0,
    );
    if (response.httpCode == 200) {
      scheduleOverviewResponse = response.data;
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
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedStartDate!));
        }

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
        getScheduleOverviewData(startDate ?? "", endDate ?? "",0, 0 );
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedEndDate!));
        }
        notifyListeners();
      }
    });
  }


}