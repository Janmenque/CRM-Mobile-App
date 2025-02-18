import 'package:flutter/material.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class FinancialProvider extends ChangeNotifier {
  String? profileImage;

  FinancialProvider() {
    getProfileData();
  }

  void getProfileData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }
}
