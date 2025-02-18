import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_leads/leads_profile_view_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';

class LeadsProfileViewProvider extends ChangeNotifier{

  LeadsProfileViewModel? leadsProfileViewResponse;
  bool isLoading = false;

  LeadsProfileViewProvider(int leadId){
    getLeadsProfileView(leadId);
  }

  getLeadsProfileView(int leadId) async {
    isLoading = true;
    final response = await CrmLeadsRepository.getLeadsProfileView(leadId);
    if(response.result == true){
      leadsProfileViewResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}