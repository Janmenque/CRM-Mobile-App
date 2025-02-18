import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_project/project_file_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:image_picker/image_picker.dart';

class ProjectFileProvider extends ChangeNotifier{

  ProjectFileListModel? projectFileListResponse;
  bool isLoading = false;

  final subjectController = TextEditingController();

  File? attachImageFile;


  ProjectFileProvider(int projectId){
    getProjectFileList(projectId);
  }


  ///project task list
  getProjectFileList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getCrmProjectFileList(projectId);
    if(response.result == true){
      projectFileListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }


  ///create project file
  Future createProjectFile(context, int projectId) async {
    var fileName = attachImageFile!.path.split('/').last;
    final data = FormData.fromMap({
      "project_id"   : projectId,
      "subject"     : subjectController.text,
      "attach_file" : await MultipartFile.fromFile(attachImageFile!.path, filename: fileName)
    });
    final response = await CrmProjectRepository.createProjectFile(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectFileList(projectId);
      subjectController.clear();
      attachImageFile = null;
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg:  response.message, backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  /// Image picker
  Future<dynamic> pickProfileImageFile(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachImageFile = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachImageFile = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }
}