import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/server/respository/auth_repository/auth_repository.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class ChangePasswordProfileProvider extends ChangeNotifier {
  var currentPassTextController = TextEditingController();
  var newPasswordTextController = TextEditingController();
  var reTypePasswordTextController = TextEditingController();
  bool passwordVisible = true;

  String? currentPassError;
  String? newPasswordError;
  String? passwordConfirmationError;
  String? error;

  void resetTextField() {
    currentPassTextController.text = "";
    newPasswordTextController.text = "";
    reTypePasswordTextController.text = "";
    currentPassError = "";
    newPasswordError = "";
    passwordConfirmationError ="";
    error = "";
    notifyListeners();
  }

  passwordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void getChangePasswordProfile(context) async {
    var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyChangePasswordProfile = BodyChangePasswordProfile(
      userId: userId,
      currentPassword: currentPassTextController.text,
      password: newPasswordTextController.text,
      passwordConfirmation: reTypePasswordTextController.text,
    );
    var apiResponse =
        await AuthRepository.getChangePasswordProfile(bodyChangePasswordProfile);
    if (apiResponse.result == true) {
      Fluttertoast.showToast(
          msg: apiResponse.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      resetTextField();
      Navigator.pop(context);
    } else {
      currentPassError =
          apiResponse.error?.laravelValidationError?.currentPassword;
      newPasswordError = apiResponse.error?.laravelValidationError?.password;
      passwordConfirmationError =
          apiResponse.error?.laravelValidationError?.passwordConfirmation;
      error = apiResponse.message;
      notifyListeners();
    }
  }
}
