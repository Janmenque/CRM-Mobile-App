import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_repository/employee_repositoy.dart';

class EmployeeListProvider extends ChangeNotifier {
  EmployeeListModel? crmEmployeeListResponse;
  String search = "";
  Timer? timeHandle;

  EmployeeListProvider() {
    getCrmEmployeeListData(search);
  }

  void getSearchValue(String? searchCode) {
    search = searchCode ?? "";
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      getCrmEmployeeListData(search);
      notifyListeners();
    });
  }

  ///get employee list data
  getCrmEmployeeListData(String? search) async {
    final response =
        await CrmEmployeeRepository.getCrmEployeeList(reposearch: search);
    if (response.httpCode == 200) {
      crmEmployeeListResponse = response.data;
    }
    notifyListeners();
  }
}
