import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_task_model/task_check_staff_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_checklist_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_template_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/utils/res.dart';

class TaskCheckListProvider extends ChangeNotifier {

  TaskCheckListModel? taskCheckListResponse;

  bool isLoading = false;

  TaskCheckStaffListModel? taskCheckStaffListResponse;
  TaskCheckStaff? taskCheckStaff;

  List<String> checklistOptionList  = ["Template", "New"];
  String checkListOption = "New";

  TaskTemplateListModel? taskTemplateListResponse;
  TaskTemplate? taskTemplate;

  final descriptionController = TextEditingController();



  TaskCheckListProvider(int taskId){
    getTaskCheckList(taskId);
    getTaskCheckStaffListData(taskId);
    getTaskTemplateListData();

  }


  /// select check list option
  selectCheckListOption(String checkListOptionValue){
    checkListOption = checkListOptionValue;
    if(checkListOption == "New"){
      taskTemplate = null;
    }
    notifyListeners();
  }


  ///select staff
  selectStaff(TaskCheckStaff staffValue) {
    taskCheckStaff = staffValue;
    notifyListeners();
  }


  ///select template
  selectTaskTemplate(TaskTemplate taskTemplateValue) {
    taskTemplate = taskTemplateValue;
    notifyListeners();
  }




  ///task checklist list
  getTaskCheckList(int taskId) async {
    isLoading = true;
    final response = await CrmTaskRepository.getTaskCheckListData(taskId);
    if(response.result == true){
      taskCheckListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///get staff list data
  getTaskCheckStaffListData(int taskId) async {
    final response = await CrmTaskRepository.getTaskCheckStaffList(taskId);
    if (response.httpCode == 200) {
      taskCheckStaffListResponse = response.data;
    }
    notifyListeners();
  }



  ///get template list data
  getTaskTemplateListData() async {
    final response = await CrmTaskRepository.getTaskTemplateList();
    if (response.httpCode == 200) {
      taskTemplateListResponse = response.data;
    }
    notifyListeners();
  }



  ///create task comment
  Future createTaskCheckList(context, int taskId) async {
    final data = FormData.fromMap({
      "task_id"        : taskId,
      "assign_staff"   : taskCheckStaff?.id,
      "description"    : descriptionController.text == "" ? "" : descriptionController.text,
      "select_option"  : checkListOption,
      "checklist_id"   : taskTemplate?.id
    });
    final response = await CrmTaskRepository.createTaskCheckList(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getTaskCheckList(taskId);
      taskCheckStaff = null;
      taskTemplate = null;
      descriptionController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



}