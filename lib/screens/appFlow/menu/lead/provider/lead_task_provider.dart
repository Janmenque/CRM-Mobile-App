import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/lead_task_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadTaskProvider extends ChangeNotifier{

  LeadTaskListModel? leadTaskListResponse;

  final taskSubjectController = TextEditingController();
  final taskMessageController = TextEditingController();

  final List<String> taskStatusList = ["Not Started", "On Hold", "In Progress", "Completed", "Cancelled"];
  String? taskStatus;


  LeadTaskProvider(int leadId){
    getLeadTaskListData(leadId);
  }


  selectTaskStatus(String? statusValue){
    taskStatus = statusValue;
    notifyListeners();
  }

  getLeadTaskListData(int leadId) async {
    final response = await CrmLeadsRepository.getLeadTaskList(leadId);
    if(response.result == true){
      leadTaskListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

  Future createTask(context, int leadId) async {
    final data = FormData.fromMap({
      "subject" : taskSubjectController.text,
      "message" : taskMessageController.text,
      "status"  : taskStatus
    });
    final response = await CrmLeadsRepository.createLeadTask(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadTaskListData(leadId);
      taskSubjectController.clear();
      taskMessageController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }
  
}