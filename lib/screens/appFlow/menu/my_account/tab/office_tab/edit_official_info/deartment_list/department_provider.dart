import 'package:flutter/foundation.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';

class DepartmentProvider extends ChangeNotifier {
  ResponseDepartment? departmentList;

  DepartmentProvider() {
    getDepartmentList();
  }

  void getDepartmentList() async {
    var apiResponse = await ProfileRepository.getDepartmentList();
    if (apiResponse.result == true) {
      departmentList = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }
}
