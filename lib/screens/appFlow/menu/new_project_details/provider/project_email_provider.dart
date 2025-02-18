import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/project_email_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';

  class ProjectEmailProvider extends ChangeNotifier{

  ProjectEmailListModel? projectEmailListResponse;

  final toMailController = TextEditingController();
  final ccMailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  bool isLoading = false;

  ProjectEmailProvider(int projectId){
    getProjectMailList(projectId);
  }



  ///project milestone list
  getProjectMailList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getProjectEmailList(projectId);
    if(response.result == true){
      projectEmailListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///create project mail
  Future createProjectMail(context, int projectId) async {
    final data = FormData.fromMap({
      "project_id"  : projectId ?? 0,
      "subject"     : subjectController.text,
      "to_email"    : toMailController.text,
      "cc_email"    : ccMailController.text,
      "message"     : messageController.text,
    });

    final response = await CrmProjectRepository.createProjectEmail(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message , backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectMailList(projectId);
      subjectController.clear();
      toMailController.clear();
      ccMailController.clear();
      messageController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }

}