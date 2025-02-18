import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/data/model/response_financial.dart';
import 'package:hrm_app/data/server/respository/profile_repository/profile_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/my_account.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

class EditFinancialTabProvider extends ChangeNotifier {
  var tinTextController = TextEditingController();
  var bankNameTextController = TextEditingController();
  var bankAccountNoTextController = TextEditingController();

  EditFinancialTabProvider(ResponseFinancial? financialInfo) {
    setData(financialInfo);
  }

  void setData(ResponseFinancial? financialInfo) {
    tinTextController.text = financialInfo?.data?.tin ?? "";
    bankNameTextController.text = financialInfo?.data?.bankName ?? "";
    bankAccountNoTextController.text = financialInfo?.data?.bankAccount ?? "";
  }

  void updateFinancialInfo(context) async {
    int? userId = await SPUtill.getIntValue(SPUtill.keyUserId);
    var bodyEditFinancial = BodyEditFinancialInfo(
        userId: userId,
        tin: tinTextController.text,
        bankName: bankNameTextController.text,
        bankAccount: bankAccountNoTextController.text);

    var apiResponse =
        await ProfileRepository.updateEditFinancialInfo(bodyEditFinancial);
    if (apiResponse.data?.result == true) {
      if (kDebugMode) {
        print(apiResponse.data?.message);
      }
      NavUtil.replaceScreen(context, const MyAccount(tabIndex: 2,));
    } else {
      if (kDebugMode) {
        print(apiResponse.data?.message);
      }
    }
  }
}
