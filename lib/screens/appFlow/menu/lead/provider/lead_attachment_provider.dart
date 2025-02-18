import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_leads/leads_attachment_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:image_picker/image_picker.dart';

class LeadAttachmentProvider extends ChangeNotifier{

  LeadsAttachmentListModel? leadsAttachmentListResponse;
  final softwareSolutionController = TextEditingController();

  File? leadAttachmentImagePath;

  LeadAttachmentProvider(int leadId){
    getLeadAttachmentList(leadId);
  }


  getLeadAttachmentList(int leadId) async {
    final response = await CrmLeadsRepository.getLeadsAttachmentList(leadId);
    if(response.result == true){
      leadsAttachmentListResponse = response.data;
    }
    notifyListeners();
  }



  Future addAttachment(context, int leadId) async {
    var fileName = leadAttachmentImagePath!.path.split('/').last;
    final data = FormData.fromMap({
      "title": softwareSolutionController.text,
      "file": await MultipartFile.fromFile(leadAttachmentImagePath!.path, filename: fileName),
    });
    final response = await CrmLeadsRepository.postLeadAttachment( data, leadId);
    if (response['success'] == true) {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadAttachmentList(leadId);
      softwareSolutionController.clear();
      leadAttachmentImagePath = null;
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  Future<dynamic> pickLeadAttachmentImage(BuildContext context) async {
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
            leadAttachmentImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            leadAttachmentImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

}