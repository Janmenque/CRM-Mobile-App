
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_appointment/crm_appointment_list_model.dart';
import 'package:hrm_app/data/server/respository/appointment/crm_appointment_repository.dart';
import 'package:hrm_app/utils/res.dart';

class CrmAppointmentListProvider extends ChangeNotifier{

  CrmAppointmentListModel? crmAppointmentListResponse;

  List<String> statusList = ["stat", "end", "agree", "disagree", "present", "absent"];
  String? status;

  CrmAppointmentListProvider(){
    getAppointmentList();
  }


  getAppointmentList() async {
    final response = await CrmAppointmentRepository.getCrmAppointmentListData();
    if(response.result == true){
      crmAppointmentListResponse = response.data;
    }
    notifyListeners();
  }


  selectStatus(String statusValue){
    status = statusValue;
    notifyListeners();
  }


  Future updateAppointmentStatusMethod(context, int appointmentId) async {
    final data = FormData.fromMap({
      "appoinment_id" : appointmentId,
      "status" : status,
    });
    final response = await CrmAppointmentRepository.updateAppointmentStatus(data, appointmentId);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getAppointmentList();
      notifyListeners();
    } else if(response["result"] == false){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getAppointmentList();
      notifyListeners();
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }

}