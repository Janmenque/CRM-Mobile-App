import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_dashboard/client_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import '../../../../../utils/nav_utail.dart';

class CrmClientDetailsProvider extends ChangeNotifier {
  bool? isAdmin;

  ClientDetailsModel? crmClientDetailsResponse;

  CrmClientDetailsProvider(int id) {
    getCrmClientDetails(id);
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;

      notifyListeners();
    }
  }

  getCrmClientDetails(int? id) async {
    final response = await CrmClientRepository.getCrmClientDetailLstData(id);
    if (response.httpCode == 200) {
      crmClientDetailsResponse = response.data;
      notifyListeners();
    }
  }

  Future crmClientDelete(id, context) async {
    final response = await CrmClientRepository.clientDelete(id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Client Deleted Successfully");
      NavUtil.replaceScreen(context, const ClientDashboard());
      notifyListeners();
    }
  }
}
