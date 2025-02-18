import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_all_user.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/directory/directory_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';

import '../../../../data/model/reponse_phonebook_details.dart';

class PhonebookProvider extends ChangeNotifier {
  ResponseAllUser? responseAllUser;
  int? initDesignationId;
  TextEditingController searchUserData = TextEditingController();
  String? searchResult;
  Timer? timeHandle;
  int? value = 0;
  int? searchDesignationId;
  ResponseDesignation? designationList;
  PhonebookDetailsModel? phonebookDetails;

  PhonebookProvider() {
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

  onSelected(bool selected, int index, int? designationId) {
    value = selected ? index : null;
    searchDesignationId = designationId;
    getAllUserData(designationId, "");
    notifyListeners();
  }

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

  Future getPhonebookDetails(id,phonebookDetails,context) async {
    final response = await Repository.getPhonebookDetails(id);
    if (response.result == true) {
      phonebookDetails = response.data;
      NavUtil.navigateScreen(
          context,
          DirectoryScreen(phonebookDetails: phonebookDetails)
      );
      notifyListeners();
    }

  }

}
