import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/lead_reminder_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadReminderProvider extends ChangeNotifier{

  LeadReminderListModel? leadReminderListResponse;

  final reminderSubjectController = TextEditingController();
  final reminderMessageController = TextEditingController();

  final List<String> reminderStatusList = ["Not Started", "On Hold", "In Progress", "Completed", "Cancelled"];
  String? reminderStatus;

  LeadReminderProvider(int leadId){
    getLeadReminderListData(leadId);
  }

  selectReminderStatus(String? statusValue){
    reminderStatus = statusValue;
    notifyListeners();
  }

  getLeadReminderListData(int leadId) async {
    final response = await CrmLeadsRepository.getLeadsReminderList(leadId);
    if(response.result == true){
      leadReminderListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }


  Future createReminder(context, int leadId) async {
    final data = FormData.fromMap({
      "subject" : reminderSubjectController.text,
      "message" : reminderMessageController.text,
      "status"  : reminderStatus
    });
    final response = await CrmLeadsRepository.createLeadReminder(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadReminderListData(leadId);
      reminderSubjectController.clear();
      reminderMessageController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }


}