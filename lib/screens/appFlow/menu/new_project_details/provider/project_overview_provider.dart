import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/project_details_overview_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';

class ProjectOverViewProvider extends ChangeNotifier{

  ProjectOverviewDetailsModel? projectOverviewDetailsResponse;
  bool isLoading = false;


  ProjectOverViewProvider(int projectId){
    getProjectDetailsOverview(projectId);
  }


  getProjectDetailsOverview(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getCrmProjectOverviewData(projectId);
    if(response.result == true){
      projectOverviewDetailsResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }




  getProjectStatus(int? id, context) async {
    final response = await CrmProjectRepository.getProjectStatusCHandelData(id);
    if (response.httpCode == 200) {
      Fluttertoast.showToast(
          msg: "Project Status Updated successfully done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      await getProjectDetailsOverview(id ?? 0);
      Navigator.pop(context);
    }
    notifyListeners();
  }



}