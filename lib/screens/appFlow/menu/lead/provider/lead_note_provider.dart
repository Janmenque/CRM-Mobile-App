import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/lead_note_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadNoteProvider extends ChangeNotifier{

  LeadNoteListModel? leadNoteListResponse;

  final noteSubjectController = TextEditingController();
  final noteMessageController = TextEditingController();


  LeadNoteProvider(int leadId){
    getLeadNoteList(leadId);
  }


  getLeadNoteList(int leadId) async {
    final response = await CrmLeadsRepository.getLeadsNoteList(leadId);
    if(response.result == true){
      leadNoteListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }




  Future createNote(context, int leadId) async {
    final data = FormData.fromMap({
      "subject" : noteSubjectController.text,
      "body"    : noteMessageController.text,
    });
    final response = await CrmLeadsRepository.createLeadNote(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadNoteList(leadId);
      noteMessageController.clear();
      noteSubjectController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }


}