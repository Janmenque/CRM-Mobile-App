import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/all_designation_wise_user/all_designation_wise_user.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/server/respository/appointment/appointment_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../data/model/home/crm_home_model.dart';
import '../../../navigation_bar/buttom_navigation_bar.dart';

class AppointmentCreateProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();


  File? attachmentPath;

  ///set all user data
  Members? allUserData;
  String? startTime;
  String? endTime;
  String? appointmentNavigation;
  String? monthYear;
  DateTime? selectedDate;

  AppointmentCreateProvider(String navigation){
    appointmentNavigation = navigation;
  }

  Future setCreateAppointment(context, id) async {
    final formData = FormData.fromMap({
      "title": titleController.text,
      "description": descriptionController.text,
      "appoinment_with": id ?? allUserData?.id,
      "date": monthYear,
      "location": locationController.text,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
              filename: attachmentPath?.path)
          : null,
      "appoinment_start_at": startTime,
      "appoinment_end_at": endTime,
    });

    ///validation condition
    if (monthYear != null && startTime != null && endTime != null) {
      final response =
          await AppointmentRepository.postCreateAppointment(formData);
      if (response['result'] == true) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
        reset();
        if(appointmentNavigation == "directory"){
          Navigator.canPop(context);
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
        }else{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                  const ButtomNavigationBar(bottomNavigationIndex: 0)),
                  (Route<dynamic> route) => true);
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
        }
      } else {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please fill the required fill');
    }
  }

  /// Select date.....
  Future selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
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
    allUserData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllDesignationWiseUser()),
    );
    notifyListeners();
  }

  Future<void> showTime(context, int start) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // Using 12-Hour format
                alwaysUse24HourFormat: true),
            // If you want 24-Hour format, just change alwaysUse24HourFormat to true
            child: child!);
      }
    );
    if (result != null) {
      ///if start value is 0 then, time will be set as start, or set as end time
      if (start == 0) {
         startTime =  "${result.hour}:${result.minute}";
         if (kDebugMode) {
           print(startTime);
         }
         notifyListeners();
      } else {
        endTime =  "${result.hour}:${result.minute}";
        if (kDebugMode) {
          print(endTime);
        }
        notifyListeners();
      }

      notifyListeners();
    }
  }

  ///Pick Attachment from Camera and Gallery
  Future<dynamic> pickAttachmentImage(BuildContext context) async {
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
            attachmentPath = File(image!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(image.path));
            }
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            attachmentPath = File(imageGallery!.path);
            notifyListeners();
            if (kDebugMode) {
              print(File(imageGallery.path));
            }
            notifyListeners();
          },
        );
      },
    );
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
