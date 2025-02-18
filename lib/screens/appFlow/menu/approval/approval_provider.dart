import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_approval_list.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class ApprovalProvider extends ChangeNotifier{

  ResponseApprovalList? approvalList;
  bool isLoading = false;

  ApprovalProvider(){
    getApprovalList();
  }

  getApprovalList() async {
    var apiResponse = await Repository.getApprovalListApi();
    if (apiResponse.result == true) {
      approvalList = apiResponse.data;
       isLoading = true;
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