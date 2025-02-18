import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_task_model/task_timer_list_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/utils/res.dart';

class TaskTimerProvider extends ChangeNotifier {

  TaskTimerListModel? taskTimerListResponse;
  bool isLoading = false;

  EmployeeListModel? crmEmployeeListResponse;
  List<Employee> selectedEmployeeList = [];

  DateTime? selectedStartTime;
  DateTime? selectedEndTime;

  final TextEditingController startDateTimeController = TextEditingController();
  final TextEditingController endDateTimeController = TextEditingController();

  final descriptionController = TextEditingController();

  TaskTimerProvider(int taskId){
    getTaskTimerList(taskId);
    getEmployeeListData();
  }



  void toggleEmployee(Employee employee) {
    if (selectedEmployeeList.any((element) => element.id == employee.id)) {
      selectedEmployeeList.removeWhere((element) => element.id == employee.id);
    } else {
      selectedEmployeeList.add(employee);
    }
    notifyListeners();
  }


/// task timer list
  getTaskTimerList(int taskId) async {
    isLoading = true;
    final response = await CrmTaskRepository.getTaskTimerListData(taskId);
    if(response.result == true){
      taskTimerListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///get employee list data
  getEmployeeListData() async {
    final response = await CrmTaskRepository.getEmployeeList();
    if (response.httpCode == 200) {
      crmEmployeeListResponse = response.data;
    }
    notifyListeners();
  }




  ///create task timer
  Future createTaskTimer(context, int taskId) async {
    final data = FormData.fromMap({
      "user_ids[]"      : selectedEmployeeList.isNotEmpty ? selectedEmployeeList.map((employee) => employee.id).toList() : null,
      "start_time"    : selectedStartTime,
      "end_time"      : selectedEndTime,
      "description"   : descriptionController.text,
      "task_id"       : taskId
    });
    final response = await CrmTaskRepository.createTaskTimer(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getTaskTimerList(taskId);
      descriptionController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }




  ///update Start Date Time

  void updateStartDateTime(DateTime date, TimeOfDay time, BuildContext context) {
    selectedStartTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    startDateTimeController.text = formattedStartDateTime(context);
    notifyListeners();
  }

  ///format Start Date Time
  String formattedStartDateTime(BuildContext context) {
    if (selectedStartTime == null) return 'dd/mm/yyyy, --:-- --';
    final date = selectedStartTime!;
    final time = TimeOfDay(hour: date.hour, minute: date.minute);
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}, ${time.format(context)}';
  }


  ///update end Date Time
  void updateEndDateTime(DateTime date, TimeOfDay time, BuildContext context) {
    selectedEndTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    endDateTimeController.text = formattedEndDateTime(context);
    notifyListeners();
  }

  ///format end Date Time
  String formattedEndDateTime(BuildContext context) {
    if (selectedEndTime == null) return 'dd/mm/yyyy, --:-- --';
    final date = selectedEndTime!;
    final time = TimeOfDay(hour: date.hour, minute: date.minute);
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}, ${time.format(context)}';
  }


}