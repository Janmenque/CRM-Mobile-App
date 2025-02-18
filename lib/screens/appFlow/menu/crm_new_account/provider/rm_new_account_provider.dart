import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_new_account/model/crm_new_account_dashboard_model.dart';
import '../../../../../live_traking/location_provider.dart';
import '../repository/crm_new_account_repository.dart';

class CrmNewAccountProvider extends ChangeNotifier{


CrmNewAccountDashboardModel? crmNewAccountDashboardResponse;

 CrmNewAccountProvider(BuildContext context, LocationProvider locationProvider) {
   
    getCrmNewAccontDashboardData();
  }

  ///get client dashboard data
  getCrmNewAccontDashboardData() async {
    final response = await CrmNewAccountRepository.getCrmNewAccountDashboardData();
    if (response.httpCode == 200) {
    crmNewAccountDashboardResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}