import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_client_model/client_file_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:image_picker/image_picker.dart';

class ClientFileProvider extends ChangeNotifier{

  ClientFileListModel? clientFileListResponse;

  bool isLoading = false;

  final subjectController = TextEditingController();

  File? attachImageFile;

  ClientFileProvider(int clientId){
    getClientFileList(clientId);
  }



  getClientFileList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientFileListData(clientId);
    if(response.result == true){
      clientFileListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }



  ///create client file
  Future createClientFile(context, int clientId) async {
    var fileName = attachImageFile!.path.split('/').last;
    final data = FormData.fromMap({
      "client_id"   : clientId,
      "subject"     : subjectController.text,
      "attach_file" : await MultipartFile.fromFile(attachImageFile!.path, filename: fileName)
    });
    final response = await CrmClientRepository.createClientFile(data);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']} created successfully', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientFileList(clientId);
      subjectController.clear();
      attachImageFile = null;
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }




  ///profile Image picker
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