import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/project_nole_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';

  class ProjectNoteProvider extends ChangeNotifier{

  ProjectNoteListModel? projectNoteListResponse;
  List<ProjectNote> projectNoteList = [];
  final noteController = TextEditingController();
  bool isLoading = false;

  ProjectNoteProvider(int projectId){
    getProjectNoteList(projectId);
  }




  // Method to reorder the notes
  void reorderNotes(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1; // Adjust index if moved down
    final item = projectNoteList.removeAt(oldIndex);
    projectNoteList.insert(newIndex, item);
    notifyListeners();
  }


  ///get note list
  getProjectNoteList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getProjectNoteListData(projectId);
    if(response.result == true){
      isLoading = false;
      projectNoteListResponse = response.data;
      projectNoteList = projectNoteListResponse?.data?.data ?? [];
      isLoading = false;
      notifyListeners();
    } else {
      projectNoteList = [];
    }
    notifyListeners();
  }



  ///create note
  Future createProjectNote(context, int projectId) async {
    final data = FormData.fromMap({
      "project_id" : projectId,
      "description" : noteController.text
    });
    final response = await CrmProjectRepository.createProjectNote(data);
    if(response.result == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectNoteList(projectId);
      noteController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  ///delete note
  Future removeProjectNote(context, int projectId, int noteId) async {
    final response = await CrmProjectRepository.removeProjectNote(noteId);
    if(response.result == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      getProjectNoteList(projectId);
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }
}