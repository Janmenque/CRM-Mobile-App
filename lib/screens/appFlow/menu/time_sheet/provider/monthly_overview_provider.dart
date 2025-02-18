import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/monthly_overview_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';
import 'package:hrm_app/utils/month_picker_dialog/month_picker_dialog.dart';

class MonthlyOverviewProvider with ChangeNotifier {
  MonthlyOverviewModel? monthlyOverviewResponse;
  TimesheetRelatedDataModel? timesheetRelatedResponse;
  List<TimesheetEmployee> selectedEmployeeList = [];
  String? selectedMonth;
  bool isLoading = false;

  MonthlyOverviewProvider(){
    getTimesheetRelatedData();
  }



  void setSelectedMonth(String month) {
    selectedMonth = month;
    notifyListeners();
    getMonthlyOverviewListData(selectedMonth ?? "", []);
    selectedEmployeeList = [];
    notifyListeners();
  }


  Future<void> pickMonth(BuildContext context) async {
    DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale("en"),
    );

    if (pickedDate != null) {
      String formattedMonth = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}";
      setSelectedMonth(formattedMonth);
    }
  }




  void toggleEmployee(TimesheetEmployee employee) {
    if (selectedEmployeeList.any((element) => element.id == employee.id)) {
      selectedEmployeeList.removeWhere((element) => element.id == employee.id);
    } else {
      selectedEmployeeList.add(employee);
    }
    getMonthlyOverviewListData("", selectedEmployeeList);
    selectedMonth = "Select Month";
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



  ///Monthly list
  getMonthlyOverviewListData(String month, List<TimesheetEmployee>employeeList) async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getMonthlyOverview(month, employeeList);
    isLoading = false;
    if(response.httpCode == 200) {
      monthlyOverviewResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
