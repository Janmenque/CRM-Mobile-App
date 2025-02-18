import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_dashboard_model.dart';
import '../../../../../live_traking/location_provider.dart';

class CrmProjectProvider extends ChangeNotifier {
  ProjectDashboardModel? crmProjectDashboardResponse;
  bool? isAdmin;

  CrmProjectProvider(BuildContext context, LocationProvider locationProvider) {
    getCrmProjectDashboardData();
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;
      notifyListeners();
    }
  }

  ///get project dashboard data
  getCrmProjectDashboardData() async {
    final response = await CrmProjectRepository.getCrmProjectHomeData();
    if (response.httpCode == 200) {
      crmProjectDashboardResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}
