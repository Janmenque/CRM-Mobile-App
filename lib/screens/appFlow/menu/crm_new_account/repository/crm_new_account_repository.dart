import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_new_account/model/crm_new_account_dashboard_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmNewAccountRepository{
   static Future<ApiResponse<CrmNewAccountDashboardModel>> getCrmNewAccountDashboardData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/accounts");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = crmNewAccountDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = crmNewAccountDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = crmNewAccountDashboardModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

}