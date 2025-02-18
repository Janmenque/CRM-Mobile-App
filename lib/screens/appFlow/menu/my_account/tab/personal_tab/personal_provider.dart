import 'package:flutter/material.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class PersonalProvider extends ChangeNotifier {
  String? profileImage;

  PersonalProvider() {
    getProfileData();
  }

  void getProfileData() async {
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }
}
