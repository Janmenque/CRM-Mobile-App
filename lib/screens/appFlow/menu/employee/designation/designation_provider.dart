import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/designation_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_repository/employee_repositoy.dart';

class DesignationListProvider extends ChangeNotifier {
  DesignationListModel? designationListModel;
  String search = "";
  Timer? timeHandle;

  DesignationListProvider() {
    getDesignationListData(search);
  }

  void getSearchValue(String? searchCode) {
    search = searchCode ?? "";
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      getDesignationListData(search);
      notifyListeners();
    });
  }

  ///get employee list data
  getDesignationListData(String? search) async {
    final response =
        await CrmEmployeeRepository.getDesignationList(reposearch: search);
    if (response.httpCode == 200) {
      designationListModel = response.data;
    }
    notifyListeners();
  }

  deleteDesignation(id) async{
    final response = await CrmEmployeeRepository.deleteDesignation(id);
    if(response['result'] == true){
      Fluttertoast.showToast(msg: response['message']);
      await getDesignationListData(search);
    }
  }
}
