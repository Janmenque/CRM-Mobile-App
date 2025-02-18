import 'dart:collection';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/multi_select_department.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateNoticeReportProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  var subjectTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  String? noticeDate;
  File? attachmentPath;

  List<File> attachments = [];
  List<XFile> listOfFile = [];

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Department> selectedItem = HashSet();



  /// get data from all team mate screen
  /// AppreciateTeammate screen
  void getAllUserData(BuildContext context) async {
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
    selectedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MultiSelectDepartment()),
    );
    for (var element in selectedItem) {
      userIds.add(element.id!);
      userNames.add(element.title!);
    }
    notifyListeners();
  }

  /// select date ......
  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      noticeDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      if (kDebugMode) {
        print(noticeDate);
      }
      notifyListeners();
    }
  }


  ///Pick Attachment from Camera and Gallery

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

  Future createNoticeApi(context) async {

    Map<String, MultipartFile> fileMap = {};
    for (int i = 0; i < listOfFile.length; i++) {
      var fileName = listOfFile[i].path.split('/').last;
      if (kDebugMode) {
        print(listOfFile[i]);
      }
      var mFile = await MultipartFile.fromFile(listOfFile[i].path, filename: fileName);
      fileMap["attachments[$i]"] = mFile;
    }

    final formDate = FormData.fromMap({
      "subject": subjectTextController.text,
      "date": noticeDate,
      "department_id": userIds.join(','),
      "description": descriptionTextController.text,
    });
    formDate.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));
    var apiResponse = await Repository.createNoteApi(formDate);
    if (apiResponse.result == true) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT, msg: apiResponse.message.toString());
    } else {
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_SHORT, msg: apiResponse.message.toString());
    }
  }
}

