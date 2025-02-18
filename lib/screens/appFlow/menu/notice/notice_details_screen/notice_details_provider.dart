import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_notice_details.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class NoticeDetailsProvider extends ChangeNotifier{
  ResponseNoticeDetails? noticeDetails;

  NoticeDetailsProvider(int? noticeId){
    noticeDetailsApi(noticeId);
  }
  void noticeDetailsApi(int? noticeId) async {
    var apiResponse = await Repository.noticeDetailsApi(noticeId);
    if (apiResponse.result == true) {
      noticeDetails = apiResponse.data;
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