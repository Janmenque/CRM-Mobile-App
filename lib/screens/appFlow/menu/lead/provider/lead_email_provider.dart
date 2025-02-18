import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/leads_email_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadEmailProvider extends ChangeNotifier{

  LeadEmailListModel? leadEmailListResponse;

  final toMailController = TextEditingController();
  final ccMailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  LeadEmailProvider(int leadId){
    getLeadListEmail(leadId);
  }


  getLeadListEmail(int leadId) async {
    final response = await CrmLeadsRepository.getLeadsEmailList(leadId);
    if(response.result == true){
      leadEmailListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }



  Future sendLeadMail(context, int leadId ) async {

    final data = FormData.fromMap({
      "to_email" : toMailController.text,
      "cc_email" : ccMailController.text,
      "subject" : subjectController.text,
      "message" : messageController.text
    });

    final response = await CrmLeadsRepository.sendLeadEmail(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadListEmail(leadId);
      clearTextField();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }


  clearTextField(){
    toMailController.clear();
    ccMailController.clear();
    subjectController.clear();
    messageController.clear();
  }

}