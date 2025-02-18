import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/support/support_ticket/support_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';

class CreateSupportTicketProvider extends ChangeNotifier {
  String? selectedPriority;
  int? selectedType;
  var subjectTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  File? attachmentPath;
  String? errorSubject;
  String? errorDescription;
  String? errorMessage;
  String? writeSubject = "";
  String? writeDescription = "";

  List<File> attachments = [];
  List<XFile> listOfFile = [];

  /// select gender
  void genderSelectedValue(String val) {
    selectedPriority = val;
    notifyListeners();
  }



  Future<void> pickAttachmentImage(BuildContext context) async {
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
              attachments.add(File(image.path));
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
              attachments.add(File(imageGallery.path));
              listOfFile.add(imageGallery);
              notifyListeners();
            }
          },
        );
      },
    );
  }
  void removeImage(int index) {
    attachments.removeAt(index);
    notifyListeners();
  }



  void genderType(genderValue) {
    if (genderValue == 'High') {
      selectedType = 14;
    } else if (genderValue == 'Medium') {
      selectedType = 15;
    } else if (genderValue == 'Low') {
      selectedType = 16;
    }
  }



  /// support create API
  void supportCreateApi(context) async {

    Map<String, MultipartFile> fileMap = {};
    for (int i = 0; i < listOfFile.length; i++) {
      var fileName = listOfFile[i].path.split('/').last;
      if (kDebugMode) {
        print(listOfFile[i]);
      }
      var mFile = await MultipartFile.fromFile(listOfFile[i].path, filename: fileName);
      fileMap["attachments[$i]"] = mFile;
    }

    var fromData = FormData.fromMap({
      "subject": subjectTextController.text,
      "description": descriptionTextController.text,
      "priority_id": selectedType ?? 14,
    });
    fromData.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));
    var apiResponse = await Repository.supportCreateApi(fromData);

    if (apiResponse.result == true) {
      Fluttertoast.showToast(
          msg: apiResponse.data?.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      notifyListeners();
      NavUtil.replaceScreen(context, const SupportScreen());
    } else {
      errorSubject = apiResponse.error?.laravelValidationError?.subject;
      errorDescription = apiResponse.error?.laravelValidationError?.description;
      errorMessage = apiResponse.message;
      notifyListeners();
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
