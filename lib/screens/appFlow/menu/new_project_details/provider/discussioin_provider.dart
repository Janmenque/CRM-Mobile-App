import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/project_discussion_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ProjectDiscussionProvider extends ChangeNotifier{

  ProjectDiscussionListModel? projectDiscussionListResponse;

  bool isLoading = false;

  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();



  ProjectDiscussionProvider(int projectId){
    getProjectDiscussionList(projectId);
  }




  getProjectDiscussionList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.projectDiscussionListModel(projectId);
    if(response.result == true){
      projectDiscussionListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }




  ///create project discussion
  Future createProjectDiscussion(context, int projectId) async {

    final data = FormData.fromMap({
      "project_id"  : projectId ?? 0,
      "subject"     : subjectController.text,
      "description" : descriptionController.text,
    });

    final response = await CrmProjectRepository.createProjectDiscussion(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message , backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectDiscussionList(projectId);
      subjectController.clear();
      descriptionController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



}