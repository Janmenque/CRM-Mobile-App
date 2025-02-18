import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/lead_tag_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadTagProvider extends ChangeNotifier{

  LeadTagListModel? leadTagListResponse;

  bool isLoading = false;

  final tagNameController = TextEditingController();

  LeadTagProvider(int leadId){
    getLeadTagListData(leadId);
  }

  getLeadTagListData(int leadId) async {
    isLoading = true;
    final response = await CrmLeadsRepository.getLeadsTagList(leadId);
    if(response.result == true){
      isLoading = false;
      leadTagListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

  Future createTag(context, int leadId) async {
    final data = FormData.fromMap({
      "name" : tagNameController.text,
    });
    final response = await CrmLeadsRepository.createLeadTag(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadTagListData(leadId);
      tagNameController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }

}