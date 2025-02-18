import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/crm_appointment/appointment_user_list_model.dart';
import 'package:hrm_app/data/server/respository/appointment/crm_appointment_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_appoinment/provider/appointment_list_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddAppointmentProvider extends ChangeNotifier {

  AppointmentUserListModel? appointmentListResponse;
  AppointmentUser? appointmentUser;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();


  File? imageFile;

  String? date;
  DateTime? selectedDate;


  TimeOfDay? startTime;
  TimeOfDay? endTime;



  AddAppointmentProvider(){
    getAppointmentUserList();
  }




  void selectStartTime(TimeOfDay time) {
    startTime = time;
    notifyListeners();
  }

  void selectEndTime(TimeOfDay time) {
    endTime = time;
    notifyListeners();
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "00:00:00";
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return "$hours:$minutes:00";
  }


  String? get formattedStartDateTime {
    if (selectedDate != null && startTime != null) {
      final dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        startTime!.hour,
        startTime!.minute,
      );
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
    return null;
  }


  String? get formattedEndDateTime {
    if (selectedDate != null && endTime != null) {
      final dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        endTime!.hour,
        endTime!.minute,
      );
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
    return null;
  }



  Future selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      date = DateFormat('yyyy-MM-dd').format(selectedDate!);
      notifyListeners();
    }
  }




  getAppointmentUserList()async{
    final response = await CrmAppointmentRepository.getCrmAppointmentUserListData();
    if(response.result == true){
      appointmentListResponse = response.data;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  selectAppointmentUser(AppointmentUser value){
    appointmentUser = value;
    notifyListeners();
  }


  Future createAppointment(context)async{
    var attachmentFile = imageFile!.path.split('/').last;
    String? appointmentStart = formattedStartDateTime;
    String? appointmentEnd = formattedEndDateTime;
    if(appointmentStart != null && appointmentEnd != null){
      final data = FormData.fromMap({
        "title" : titleController.text,
        "description" : descriptionController.text,
        "appoinment_with" : appointmentUser?.id,
        "date" : date,
        "location" : locationController.text,
        "attachment_file" :  await MultipartFile.fromFile(imageFile!.path, filename: attachmentFile),
        "appoinment_start_at" : appointmentStart,
        "appoinment_end_at" : appointmentEnd
      });
      final response = await CrmAppointmentRepository.postCreateAppointment(data);
      if(response.httpCode == 200){
        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
        Provider.of<CrmAppointmentListProvider>(context, listen: false).getAppointmentList();
        Navigator.pop(context);
        notifyListeners();
      } else if(response.httpCode == 422){
        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      } else if(response.httpCode == 400){
        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      }
      else {
        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
      }
    }
  }


  ///coverImage picker
  Future<dynamic> pickAttachmentFile(BuildContext context) async {
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
            imageFile = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            imageFile = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }


}