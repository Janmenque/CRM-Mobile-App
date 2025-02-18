import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_project/project_activity_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';

class ProjectActivityProvider extends ChangeNotifier {

  ProjectActivityListModel? projectActivityListResponse;

  bool isLoading = false;

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;


  ProjectActivityProvider(int projectId){
    getProjectActivityList(projectId);
  }

  getProjectActivityList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getProjectActivityList(projectId);
    if(response.result == true) {
      projectActivityListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }





}