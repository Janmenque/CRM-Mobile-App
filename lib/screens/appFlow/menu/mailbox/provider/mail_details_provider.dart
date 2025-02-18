import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/mailbox/mail_details_model.dart';
import 'package:hrm_app/data/server/respository/crm_mailbox_repository/crm_mailbox_repository.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';

class MailDetailsProvider extends ChangeNotifier{

  MailDetailsModel? mailDetailsResponse;

  final messageController = TextEditingController();

  List<File> replyAttachmentImages = [];
  List<XFile> listOfFile = [];
  List<MultipartFile> replyAttachmentImageFiles = [];

  MailDetailsProvider(int mailBoxId){
    getMailDetails(mailBoxId);
  }


  Future<void> pickComposeAttachment(BuildContext context) async {
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
            if (image != null) {
              replyAttachmentImages.add(File(image.path));
              listOfFile.add(image);
              notifyListeners();
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            if (imageGallery != null) {
              replyAttachmentImages.add(File(imageGallery.path));
              listOfFile.add(imageGallery);
              notifyListeners();
            }
          },
        );
      },
    );
  }

  void removeImage(int index) {
    replyAttachmentImages.removeAt(index);
    notifyListeners();
  }


  getMailDetails(int mailBoxId) async {
    final response = await CrmMailboxRepository.getMailDetailsData(mailBoxId);
    if(response.result == true){
      mailDetailsResponse = response.data;
    }
    notifyListeners();
  }



  Future postMailReply(context, int mailBoxId) async {
    Map<String, MultipartFile> fileMap = {};
    for (int i = 0; i < listOfFile.length; i++) {
      var fileName = listOfFile[i].path.split('/').last;
      if (kDebugMode) {
        print(listOfFile[i]);
      }
      var mFile = await MultipartFile.fromFile(listOfFile[i].path, filename: fileName);
      fileMap["attachments[$i]"] = mFile;
    }

    final formData = FormData.fromMap({
      "mail_box_id" : mailBoxId,
      "message" : messageController.text,
    });
    formData.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));

    final response = await CrmMailboxRepository.postMailReply(formData);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }
    notifyListeners();

  }

}