import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/client_project_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_task_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/new_client_tasklist_model.dart';
import 'package:hrm_app/data/model/home/crm_home_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/utils/res.dart';

class ClientTaskProvider extends ChangeNotifier{


  NewClientTaskListModel? clientTaskListResponse;
  ClientProjectListModel? clientProjectListResponse;


  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  bool isLoading = false;

  Members? allUserData;

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  List<String> priorityList = ["Urgent", "High", "Medium"];
  String? priority;

  ClientProject? clientProject;


  ClientTaskProvider(int clientId){
    getClientTaskList(clientId);
    getClientProjectList(clientId);
  }

  selectPriority(String priorityValue) {
    priority = priorityValue;
    notifyListeners();
  }

  selectProject(ClientProject clientProjectValue) {
    clientProject = clientProjectValue;
    notifyListeners();
  }

  getClientTaskList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientTaskListData(clientId);
    if(response.httpCode == 200){
      clientTaskListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }


  getClientProjectList(int clientId) async {
    final response = await CrmClientRepository.getClientProjectListData(clientId);
    if(response.result == true){
      clientProjectListResponse = response.data;
    }
    notifyListeners();
  }


  ///create client task
  Future createClientTask(context, int clientId) async {
    final data = FormData.fromMap({
      "client"      : clientId,
      "project"     : clientProject?.id,
      "name"        : taskNameController.text,
      "priority"    : priority == "Urgent" ? 31 : priority == "High" ? 30 : 29,
      "description" : taskDescriptionController.text,
      "start_date"  : startDate,
      "end_date"    : endDate,
      "members"     : userIds.join(',')
    });

    final response = await CrmClientRepository.createClientTask(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientTaskList(clientId);
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




  // Split start date and time
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


}