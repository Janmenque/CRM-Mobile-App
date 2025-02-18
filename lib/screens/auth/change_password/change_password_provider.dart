import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/server/respository/auth_repository/auth_repository.dart';
import 'package:hrm_app/screens/auth/splash_screen/splash_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';

class ChangePasswordProvider extends ChangeNotifier {
  var enterCodeTextController = TextEditingController();
  var newPasswordTextController = TextEditingController();
  var confirmPassword = TextEditingController();
  String? errorEmail;
  String? errorCode;
  String? errorPassword;
  String? errorPasswordConfirmation;
  String? errorMessage;

  void resetTextField() {
    enterCodeTextController.text = "";
    newPasswordTextController.text = "";
    confirmPassword.text = "";
    errorEmail = "";
    errorCode = "";
    errorPassword = "";
    errorPasswordConfirmation = "";
    errorMessage = "";
    notifyListeners();
  }

  void getNewPassword(context, String email) async {
    var bodyResetPassword = BodyChangePassword(
        email: email.toString(),
        code: enterCodeTextController.text,
        password: newPasswordTextController.text,
        passwordConfirmation: confirmPassword.text);
    var apiResponse = await AuthRepository.getChangePassword(bodyResetPassword);
    notifyListeners();
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
      NavUtil.pushAndRemoveUntil(context, const SplashScreen());
      notifyListeners();
    } else {
      errorEmail = apiResponse.error?.laravelValidationError?.email;
      errorCode = apiResponse.error?.laravelValidationError?.code;
      errorPassword = apiResponse.error?.laravelValidationError?.password;
      errorPasswordConfirmation =
          apiResponse.error?.laravelValidationError?.passwordConfirmation;
      errorMessage = apiResponse.message;
    }
  }
}
