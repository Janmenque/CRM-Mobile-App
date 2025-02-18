import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/hourly_statistics_list_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';

class HourlyStatisticsProvider extends ChangeNotifier {

  HourlyStaticsListModel? hourlyStaticsListResponse;
  TimesheetRelatedDataModel? timesheetRelatedResponse;

  bool isLoading = false;

  TimesheetEmployee? employee;

  String? startDate;
  String? endDate;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;



  HourlyStatisticsProvider(){
    getTimesheetRelatedData();
  }



  selectedEmployee(TimesheetEmployee employeeValue){
    employee = employeeValue;
    startDate = "Select Start Date";
    endDate = "Select End Date";
    notifyListeners();
    getHourlyStatics("", "", employee?.id ?? 0);
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



  ///Hourly Statics list data
  getHourlyStatics(String startDate, String endDate, int employeeId) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getHourlyStaticsData(startDate, endDate, employeeId);
    if (response.httpCode == 200) {
      hourlyStaticsListResponse = response.data;
      isLoading = false;
      notifyListeners();
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
        employee = null;
        getHourlyStatics(startDate ?? "", endDate ?? "", 0 );
        notifyListeners();
      }
    });
  }


}