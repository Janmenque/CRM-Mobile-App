import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/custom_widgets/custom_dialog.dart';
import 'package:hrm_app/data/model/client_expense/client_expense_category_list_model.dart';
import 'package:hrm_app/data/model/client_expense/client_expense_list-model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:image_picker/image_picker.dart';

  class ClientExpenseProvider extends ChangeNotifier{

  ClientExpenseListModel? clientExpenseListResponse;
  ClientExpenseCategoryList? clientExpenseCategoryListResponse;
  ClientExpenseCategory? clientExpenseCategory;

  final amountController = TextEditingController();
  final referenceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;

  File? expenseAttachment;

  String? startDate;
  DateTime? selectedStartDate;


  ClientExpenseProvider(int clientId){
    getClientExpenseList(clientId);
    getClientExpenseCategoryList();
  }



  selectClientExpenseCategory(ClientExpenseCategory clientExpenseCategoryValue){
    clientExpenseCategory = clientExpenseCategoryValue;
    notifyListeners();
  }


  getClientExpenseList(int clientId)async{
    isLoading = true;
    final response = await CrmClientRepository.getClientExpenseListData(clientId);
    if(response.result == true){
      clientExpenseListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }



  getClientExpenseCategoryList()async{
    final response = await CrmClientRepository.getClientExpenseCategoryListData();
    if(response.result == true){
      clientExpenseCategoryListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }



  ///create client expense
  Future clientCreateExpense(context, int clientId) async {
    var fileName = expenseAttachment!.path.split('/').last;
    final data = FormData.fromMap({
      "expense_category_id" : clientExpenseCategory?.id ?? 0,
      "remarks"             : descriptionController.text,
      "amount"              : amountController.text,
      "attachment_file"     : await MultipartFile.fromFile(expenseAttachment!.path, filename: fileName),
      "client_id"           : clientId,
      "date"                : startDate,
    });

    final response = await CrmClientRepository.createClientExpense(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response.message}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientExpenseList(clientId);
      amountController.clear();
      descriptionController.clear();
      descriptionController.clear();
      startDate = "Start Date";
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




  // Split the date and time
  DateTime parseCustomDate(String date) {
    try {
      List<String> parts = date.split(' ');
      String datePart = parts[0];
      String timePart = parts[1];
      List<String> dateComponents = datePart.split('-');
      String formattedDate = "${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}T$timePart";
      return DateTime.parse(formattedDate);
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing date: $e");
      }
      return DateTime.now();
    }
  }


  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }



  ///date selection method
  Future selectStartDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedStartDate = date;
        startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
        notifyListeners();
      }
    });
  }



  // Utility function to convert hex string to Color
  Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse("0x$hexColor"));
  }


  ///profile Image picker
  Future<dynamic> pickExpenseAttachmentFile(BuildContext context) async {
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
            expenseAttachment = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            expenseAttachment = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
    notifyListeners();
  }

}