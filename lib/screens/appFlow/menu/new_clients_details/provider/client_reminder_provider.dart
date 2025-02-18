
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_client_model/client_reminder_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ClientReminderProvider extends ChangeNotifier{

  ClientReminderListModel? clientReminderListResponse;

  final descriptionController = TextEditingController();

  bool isLoading = false;

  String? monthYear;
  DateTime? selectedDate;

  ClientReminderProvider(int clientId){
    getClientReminderList(clientId);
  }


  ///date selection method
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
        monthYear = DateFormat('yyyy-MM-dd').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('yyyy-MM-dd').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }


  ///reminder list
  getClientReminderList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientReminderListData(clientId);
    if(response.result == true){
      isLoading = false;
      clientReminderListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///create client reminder
  Future createClientReminder(context, int clientId) async {
    final data = FormData.fromMap({
      "client_id" : clientId,
      "date"      : monthYear,
      "description"   : descriptionController.text,
    });
    final response = await CrmClientRepository.createClientReminder(data);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientReminderList(clientId);
      descriptionController.clear();
      monthYear = "Select Date";
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }

}

