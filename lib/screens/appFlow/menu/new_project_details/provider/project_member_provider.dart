import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_project/project_member_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';

class ProjectMemberProvider extends ChangeNotifier {

  ProjectMemberListModel? projectMemberListResponse;

  bool isLoading = false;

  ProjectMemberProvider(int projectId){
    getProjectMemberList(projectId);
  }


  getProjectMemberList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getProjectMemberList(projectId);
    if(response.result == true){
      projectMemberListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}