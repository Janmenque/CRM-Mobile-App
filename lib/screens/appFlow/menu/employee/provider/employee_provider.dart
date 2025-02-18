import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/data/model/employee_model/employee_dashboard_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_repository/employee_repositoy.dart';

class CrmEmployeeProvider extends ChangeNotifier {
  EmployeeDashboardModel? crmEmployeeeDashboardResponse;

  EmployeeListModel? crmEmployeeListResponse;
  Timer? timeHandle;
  String search = "";
  bool? isAdmin;

  CrmEmployeeProvider(
    BuildContext context,
  ) {
    getCrmEmployeeDashboardData();
    getCrmEmployeeListData(search);
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;
      notifyListeners();
    }
  }

  ///get employee dashboard data
  getCrmEmployeeDashboardData() async {
    final response = await CrmEmployeeRepository.getCrmEployeeHomeData();
    if (response.httpCode == 200) {
      crmEmployeeeDashboardResponse = response.data;
    }
    notifyListeners();
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
  }
}
