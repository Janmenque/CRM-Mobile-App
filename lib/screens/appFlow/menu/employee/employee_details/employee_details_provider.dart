import 'package:flutter/cupertino.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class EmployeeDetailsProvider extends ChangeNotifier {
  bool? isAdmin;

  EmployeeDetailsProvider() {
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;
      notifyListeners();
    }
  }
}
