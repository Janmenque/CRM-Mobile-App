import 'package:flutter/foundation.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/screens/auth/login/login_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

import '../../../main.dart';
import '../../domain_selection/domain_selection_screen.dart';

class SplashProvider extends ChangeNotifier{
  SplashProvider(context){
    initFunction(context);
  }

  initFunction(context){
    Future.delayed(const Duration(seconds: 2), () async {
      var token = await SPUtill.getValue(SPUtill.keyAuthToken);
      var userId = await SPUtill.getIntValue(SPUtill.keyUserId);
      var baseUrl = await SPUtill.getValue(SPUtill.companyUrl);
      global.set(SPUtill.companyUrl, baseUrl);
      if (kDebugMode) {
        /// development purpose only
        print("Bearer token: $token");
        print("User Id: $userId");
      }
      if (token != null) {
        NavUtil.replaceScreen(context, const ButtomNavigationBar());
      } else {
        NavUtil.replaceScreen(context, const LoginScreen());
      }
      notifyListeners();
    });
  }
}