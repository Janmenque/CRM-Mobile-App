import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/new_project_task_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_task_list_model.dart';
import 'package:hrm_app/data/model/home/crm_home_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ProjectTaskProvider extends ChangeNotifier{

  NewProjectTaskListModel? projectTaskListResponse;
  ClientListModel? crmClientListResponse;

  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  Members? allUserData;

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();

  Client? client;

  bool isLoading = false;

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  List<String> priorityList = ["Urgent", "High", "Medium"];
  String? priority;


  ProjectTaskProvider(int projectId){
    getProjectTaskList(projectId);
    getCrmClientListData();
  }


  selectPriority(String priorityValue) {
    priority = priorityValue;
    notifyListeners();
  }


  selectClient(Client clientValue) {
    client = clientValue;
    notifyListeners();
  }


  ///project task list
  getProjectTaskList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getCrmProjectTaskList(projectId);
    if(response.httpCode == 200){
      isLoading = false;
      projectTaskListResponse = response.data;
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



  ///create project task
  Future createProjectTask(context, int projectId) async {
    final data = FormData.fromMap({
      "client"      : client?.id ?? 0,
      "project"     : projectId,
      "name"        : taskNameController.text,
      "priority"    : priority == "Urgent" ? 31 : priority == "High" ? 30 : 29,
      "description" : taskDescriptionController.text,
      "start_date"  : startDate,
      "end_date"    : endDate,
      "members"     : userIds.join(',')
    });

    final response = await CrmProjectRepository.createProjectTask(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message , backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectTaskList(projectId);
      taskNameController.clear();
      taskDescriptionController.clear();
      userIds = [];
      startDate = "Start Date";
      endDate = "End Date";
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  ///Start date selection method
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
        startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
        notifyListeners();
      }
    });
  }

  ///End date selection method
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
        endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
        notifyListeners();
      }
    });
  }


  /// Split start date and time
  DateTime parseCustomStartDate(String date) {
    try {
      List<String> parts = date.split(' ');
      String datePart = parts[0];
      String timePart = parts[1];
      List<String> dateComponents = datePart.split('-');
      String formattedDate = "${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}T$timePart";
      return DateTime.parse(formattedDate);
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing date: $e");
      }
      return DateTime.now();
    }
  }


  String formatStartDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatStartTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }



  DateTime parseCustomEndDate(String date) {
    try {
      List<String> parts = date.split(' ');
      String datePart = parts[0];
      String timePart = parts[1];
      List<String> dateComponents = datePart.split('-');
      String formattedDate = "${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}T$timePart";
      return DateTime.parse(formattedDate);
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing date: $e");
      }
      return DateTime.now();
    }
  }


  String formatEndDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatEndTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }



  void clearList(){
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
  }





  ///user
  void getAllUserData(BuildContext context,{clearCache = true}) async {

    if(clearCache){
      clearList();
    }
    selectedItem = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MultiSelectEmployee()));
    for (var element in selectedItem) {
      if(!userIds.contains(element.id)){
        userIds.add(element.id!);
        userNames.add(element.name!);
      }
    }
    notifyListeners();
  }

}