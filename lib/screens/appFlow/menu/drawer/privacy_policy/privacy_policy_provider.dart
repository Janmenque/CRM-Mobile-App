import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/response_all_contents.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/utils/app_const.dart';

class PrivacyPolicyProvider extends ChangeNotifier{
  ResponseAllContents? contentsData;
  PrivacyPolicyProvider(){
    privacyPolicyApi();
  }

  privacyPolicyApi() async{
    var apiResponse = await Repository.allContentsApi(AppConst.privacyPolicy);
    if(apiResponse.result == true){
      contentsData = apiResponse.data;
      notifyListeners();
    }else{
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}