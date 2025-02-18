import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';

  class CrmTaskProvider extends ChangeNotifier {
  TaskDashboardModel? crmTaskDashboardResponse;
  bool? isAdmian;

  CrmTaskProvider({int? taskId}) {
    getCrmTaskDashboardData();
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmian = apiResponse.data?.data?.isAdmin;

      notifyListeners();
    }
  }

  ///get client dashboard data
  getCrmTaskDashboardData() async {
    final response = await CrmTaskRepository.getCrmTaskHomeData();
    if (response.httpCode == 200) {
      crmTaskDashboardResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}
