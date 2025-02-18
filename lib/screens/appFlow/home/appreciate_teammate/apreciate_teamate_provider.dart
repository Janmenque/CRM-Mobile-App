import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_all_user.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class AppreciateTeammateProvider extends ChangeNotifier {
  ResponseAllUser? responseAllUser;
  int? designationId;
  TextEditingController searchUserData = TextEditingController();
  String? searchResult;
  Timer? timeHandle;
  int? value = 0;
  int? searchDesignationId;
  int? initDesignationId;
  ResponseDesignation? designationList;

  AppreciateTeammateProvider() {
    getDesignationList();
  }
  void getDesignationList() async {
    var apiResponse = await ProfileRepository.getDesignationList();
    if (apiResponse.result == true) {
      designationList = apiResponse.data;
      initDesignationId = designationList?.data?.designations?[0].id;
      getAllUserData(initDesignationId, "");
      notifyListeners();
    } else {
      final errorMessage = apiResponse.message;
      if (kDebugMode) {
        print(errorMessage);
      }
    }
  }

  void textChanged(String val) {
    searchResult = val;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }
    timeHandle = Timer(const Duration(seconds: 1), () {
      searchDesignationId != null
          ? getAllUserData(searchDesignationId, searchResult)
          : getAllUserData(initDesignationId, searchResult);
      notifyListeners();
    });
  }

  /// select value from list
  onSelected(bool selected, int index, int? designationId) {
    value = selected ? index : null;
    searchDesignationId = designationId;
    getAllUserData(designationId, "");
    notifyListeners();
  }

  /// get all user data from api
  void getAllUserData(int? designationId, String? search) async {
    var apiResponse = await Repository.getAllUserData(designationId, search);
    if (apiResponse.result == true) {
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
