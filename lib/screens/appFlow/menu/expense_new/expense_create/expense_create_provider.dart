import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../custom_widgets/custom_dialog.dart';
import '../../../../../data/server/respository/expense_repository.dart';

class ExpenseCreateProvider extends ChangeNotifier {
  TextEditingController addRemarksController = TextEditingController();
  DateTime? selectedDate;
  String? monthYear;
  bool isLoading = false;
  DateTime? expenseDate;

  ///create expense variable
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController referenceController= TextEditingController();
  File? attachmentPath;
  int? serverCategoryId;

  ExpenseCreateProvider(int? categoryId) {
    serverCategoryId = categoryId;
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

  /// Create expense:-----------------
  Future createExpanse(context) async {
    if(expenseDate?.toLocal().toString().split(" ")[0] == null){
      Fluttertoast.showToast(msg: "Please Select Expense Date");
    }if( attachmentPath?.path == null){
      Fluttertoast.showToast(msg: "You must upload file");
    }else{
      var fromData = FormData.fromMap({
        "category": serverCategoryId,
        "date": expenseDate?.toLocal().toString().split(" ")[0] ?? "",
        "amount": amountController.text,
        "description":descriptionController.text,
        "reference": referenceController.text,
        "attachment": attachmentPath?.path != null
            ? await MultipartFile.fromFile(attachmentPath!.path,
            filename: attachmentPath?.path)
            : null,
      });
      final response = await ExpenseRepository.postExpenseAdd(fromData);
      if (response['result'] == true) {
        Fluttertoast.showToast(msg: response['message']);
        attachmentPath = null;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        notifyListeners();
      }
      descriptionController.clear();
      amountController.clear();
    }

  }

  /// Select date data of joining function.....
  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: expenseDate != null
            ? expenseDate!.toLocal()
            : DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      expenseDate = selectedDate!.toLocal();
      notifyListeners();
    }
  }
}
