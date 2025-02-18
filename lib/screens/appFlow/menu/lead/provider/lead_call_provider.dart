import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_leads/leads_call_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_leads_repositoy/crm_leads_repository.dart';
import 'package:hrm_app/utils/res.dart';

class LeadCallProvider extends ChangeNotifier {

  LeadCallListModel? leadCallListResponse;
  
  String? monthYear;
  DateTime? selectedDate;

  final numberController = TextEditingController();
  final durationController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final List<String> callTypeList = ["Incoming", "Outgoing"];
  String? callType;

  LeadCallProvider(int leadId){
    getLeadCallList(leadId);
  }


  selectCallType(String callTypeValue){
    callType = callTypeValue;
    notifyListeners();
  }

  getLeadCallList(int leadId) async {
    final response = await CrmLeadsRepository.getLeadsCallList(leadId);
    if(response.result == true){
      leadCallListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
  

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
        monthYear = DateFormat('dd-MM-yyyy').format(selectedDate!);
        if (kDebugMode) {
          print(DateFormat('dd-MM-yyyy').format(selectedDate!));
        }
        notifyListeners();
      }
    });
  }


  Future createCall(context, int leadId) async {
    final data = FormData.fromMap({
      "call_date" : monthYear,
      "call_type" : callType,
      "subject"   : subjectController.text,
      "body"      : messageController.text,
      "number"    : numberController.text,
      "duration"  : durationController.text
    });
    final response = await CrmLeadsRepository.createLeadCall(data, leadId);
    if(response["success"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getLeadCallList(leadId);
      clearTextField();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }


  clearTextField(){
    monthYear = "Select Date";
    numberController.clear();
    durationController.clear();
    subjectController.clear();
    messageController.clear();
  }

  
}