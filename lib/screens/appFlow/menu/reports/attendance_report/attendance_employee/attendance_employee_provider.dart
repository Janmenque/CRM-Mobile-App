import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_user_search.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class AttendanceEmployeeProvider extends ChangeNotifier {
  TextEditingController searchUserData = TextEditingController();
  ResponseUserSearch? responseAllUser;
  String? searchResult;
  Timer? timeHandle;
  bool isLoading = false;

  AttendanceEmployeeProvider() {
    getAllUserData("");
  }

  void textChanged(String val) {
    searchResult = val;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    timeHandle = Timer(const Duration(seconds: 1), () {
      getAllUserData(searchResult);
      notifyListeners();
    });
  }

  /// get all Employee data from api
  void getAllUserData(String? search) async {
    var apiResponse = await Repository.getAllEmployee(search);
    if (apiResponse.result == true) {
      isLoading = true;
      responseAllUser = apiResponse.data;
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }
}
