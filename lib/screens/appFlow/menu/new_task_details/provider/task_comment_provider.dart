import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_task_model/task_comment_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:image_picker/image_picker.dart';

class TaskCommentProvider extends ChangeNotifier {

  TaskCommentListModel? taskCommentListResponse;
  final commentController = TextEditingController();

  bool isLoading = false;

  File? attachImageFile;

  TaskCommentProvider(int taskId){
    getTaskCommentList(taskId);
  }



  ///task comment list
  getTaskCommentList(int taskId) async {
    isLoading = true;
    final response = await CrmTaskRepository.getTaskCommentListData(taskId);
    if(response.result == true){
      taskCommentListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///create task comment
  Future createTaskComment(context, int taskId) async {
    var fileName = attachImageFile!.path.split('/').last;
    final data = FormData.fromMap({
      "task_id"     : taskId,
      "comment"     : commentController.text,
      "attachment" : await MultipartFile.fromFile(attachImageFile!.path, filename: fileName)
    });
    final response = await CrmTaskRepository.createTaskComment(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getTaskCommentList(taskId);
      commentController.clear();
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