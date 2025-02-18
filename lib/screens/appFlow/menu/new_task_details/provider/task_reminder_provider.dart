import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_task_model/task_reminder_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/utils/res.dart';

class TaskReminderProvider extends ChangeNotifier {

  TaskReminderListModel? taskReminderListResponse;
  ClientListModel? crmClientListResponse;
  Client? client;
  bool isLoading = false;
  DateTime? selectedDateTime;
  bool isSend = false;

  final TextEditingController dateTimeController = TextEditingController();
  final descriptionController = TextEditingController();


  TaskReminderProvider(int taskId){
    getTaskReminderList(taskId);
    getCrmClientListData();
  }


  void toggleSend(bool value){
    isSend = value;
    notifyListeners();
  }


  selectClient(Client clientValue) {
    client = clientValue;
    notifyListeners();
  }


  getTaskReminderList(int taskId) async {
    isLoading = true;
    final response = await CrmTaskRepository.getTaskReminderListData(taskId);
    if(response.result == true){
      taskReminderListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///client list
  getCrmClientListData() async {
    final response = await CrmProjectRepository.getCrmClientList();
    if (response.httpCode == 200) {
      crmClientListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }



  void updateDateTime(DateTime date, TimeOfDay time, BuildContext context) {
    selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    dateTimeController.text = formattedDateTime(context);
    notifyListeners();
  }

  String formattedDateTime(BuildContext context) {
    if (selectedDateTime == null) return 'dd/mm/yyyy, --:-- --';
    final date = selectedDateTime!;
    final time = TimeOfDay(hour: date.hour, minute: date.minute);
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}, ${time.format(context)}';
  }



  ///create task reminder
  Future createTaskReminder(context, int taskId) async {
    final data = FormData.fromMap({
      "task_id"           : taskId,
      "user_id"           : client?.id ?? 0,
      "mailable_status"   : isSend,
      "notify_date_time"  : selectedDateTime,
      "description"       : descriptionController.text
    });
    final response = await CrmTaskRepository.createTaskReminder(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getTaskReminderList(taskId);
      descriptionController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }

}