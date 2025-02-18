import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_support_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class SupportTicketDetailsProvider extends ChangeNotifier{
  ResponseSupportDetails? responseSupportDetails;

  SupportTicketDetailsProvider(int? supportId){
    supportTicketDetailsApi(supportId);
  }
  void supportTicketDetailsApi(int? noticeId) async {
    var apiResponse = await Repository.supportDetailsApi(noticeId);
    if (apiResponse.result == true) {
      responseSupportDetails = apiResponse.data;
      notifyListeners();
    } else {
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