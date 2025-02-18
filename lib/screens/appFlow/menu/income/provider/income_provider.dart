import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/screens/appFlow/menu/income/model/income_dashboad_model.dart';
import 'package:hrm_app/screens/appFlow/menu/income/repository/income_repository.dart';
import '../../../../../live_traking/location_provider.dart';

class CrmIncomeProvider extends ChangeNotifier{

IncomeDashboardModel? crmIncomeDashboardResponse;

 CrmIncomeProvider(BuildContext context, LocationProvider locationProvider) {
   
    getCrmIncomeDashboardData();
  }

  ///get Income dashboard data
  getCrmIncomeDashboardData() async {
    final response = await CrmIncomeRepository.getCrmIncomeDashboardData();
    if (response.httpCode == 200) {
    crmIncomeDashboardResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}