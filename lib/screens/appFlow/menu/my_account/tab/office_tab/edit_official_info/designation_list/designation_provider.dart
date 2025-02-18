import 'package:flutter/foundation.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';

class DesignationProvider extends ChangeNotifier {
  ResponseDesignation? designationList;

  DesignationProvider() {
    getDesignationList();
  }

  void getDesignationList() async {
    var apiResponse = await ProfileRepository.getDesignationList();
    if (apiResponse.result == true) {
      designationList = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }
}
