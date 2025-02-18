import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/main.dart';
import 'package:hrm_app/utils/app_const.dart';
import '../../utils/nav_utail.dart';
import '../../utils/shared_preferences.dart';
import '../auth/login/login_screen.dart';

class DomainProvider extends ChangeNotifier{

  final TextEditingController domainUrl = TextEditingController();

  void addDomain (context){
      AppConst.baseUrlApi = "${domainUrl.text}/api/V11";
      notifyListeners();
      SPUtill.setValue(SPUtill.companyUrl, "${domainUrl.text}/api/V11");
      global.set(SPUtill.companyUrl, "${domainUrl.text}/api/V11");
      if (kDebugMode) {
        print({AppConst.baseUrlApi});
      }
      domainUrl.text.isNotEmpty ?
      NavUtil.replaceScreen(context, const LoginScreen()) :
      Fluttertoast.showToast(msg: "Domain field should be selected");
      notifyListeners();
      domainUrl.clear();
      notifyListeners();
  }
}