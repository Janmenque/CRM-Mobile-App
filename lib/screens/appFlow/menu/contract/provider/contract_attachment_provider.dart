import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_contract/contract_attachment_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';
import 'package:image_picker/image_picker.dart';

class ContractAttachmentProvider extends ChangeNotifier{

  ContractAttachmentListModel? contractAttachmentListResponse;

  final titleController = TextEditingController();

  File? contractAttachmentImagePath;

  ContractAttachmentProvider(int contractId){
    getContractAttachmentList(contractId);
  }


  ///contract attachment list
  getContractAttachmentList(int contractId)async{
    final response = await CrmContractRepository.getContractAttachmentListData(contractId);
    if(response.result == true){
      contractAttachmentListResponse = response.data;
      notifyListeners();
    } else{
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }



///add contract attachment
  Future addContractAttachment(context, int contractId) async {
    var fileName = contractAttachmentImagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "title": titleController.text,
      "contract_id": contractId,
      "attachment_file": await MultipartFile.fromFile(contractAttachmentImagePath!.path, filename: fileName),
    });
    final response = await CrmContractRepository.postAddAttachment(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Navigator.of(context).pop();
      getContractAttachmentList(contractId);
      titleController.clear();
      contractAttachmentImagePath = null;
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }
    notifyListeners();
  }





 ///image picker
  Future<dynamic> pickContractAttachmentImage(BuildContext context) async {
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
            contractAttachmentImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            contractAttachmentImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

}