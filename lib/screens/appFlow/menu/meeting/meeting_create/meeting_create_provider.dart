import 'dart:collection';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/meeting_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../data/model/home/crm_home_model.dart';

class MeetingCreateProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  File? attachmentPath;

  ///set all user data
  Members? allUserData;

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();

  ///time picker
  String? startTime;
  String? endTime;

  ///date picker
  String? monthYear;
  DateTime? selectedDate;

  String selectedLocation = "";

  List<File> attachments = [];
  List<XFile> listOfFile = [];

  void setSelectedLocation(String location) {
    selectedLocation = location;
    notifyListeners();
  }




  Future postCreateMeeting(context) async {
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
      "title": titleController.text,
      "description": descriptionController.text,
      "participants": userIds.join(','),
      "date": monthYear,
      "location": selectedLocation,
      "start_at": startTime,
      "end_at": endTime,
    });
    formData.files.addAll(fileMap.entries.map((e) => MapEntry(e.key, e.value)));
    ///validation condition
    if (monthYear != null && startTime != null && endTime != null) {
      final response = await Repository.postCreateMeeting(formData);
      if (response['result'] == true) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
        reset();
        NavUtil.replaceScreen(context, const MeetingScreen());
      } else {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
      }
    } else {
      Fluttertoast.showToast(msg: tr("please_fill_the_required_fill"));
    }
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        monthYear = DateFormat('y-MM-dd').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('y-M').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }

  /// get data from all team mate screen
  /// AppreciateTeammate screen
  void getAllUserData(BuildContext context) async {
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
    selectedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MultiSelectEmployee()),
    );
    for (var element in selectedItem) {
      userIds.add(element.id!);
      userNames.add(element.name!);
    }
    notifyListeners();
  }

  Future<void> showTime(context, int start) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (result != null) {
      ///if start value is 0 then, time will be set as start, or set as end time
      if (start == 0) {
        startTime = result.format(context);
      } else {
        endTime = result.format(context);
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

  reset() {
    titleController.clear();
    descriptionController.clear();
    allUserData = null;
    monthYear = null;
    locationController.clear();
    attachmentPath = null;
    startTime = null;
    endTime = null;
  }
}
