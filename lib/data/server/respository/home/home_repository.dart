import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/data/model/event_holiday_model/event_holiday_model.dart'; 
import '../../../../api_service/api_response.dart';
import '../../../../api_service/api_service.dart';
import '../../../model/home/crm_home_model.dart';
import '../../../model/home/statics_model.dart';
import '../../../model/home/upcoming_appointments_model.dart';

class HomeRepository {
 ///crm home repo
   static Future<ApiResponse<CrmHomeModel>> getCrmHomeData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/home-screen");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
         if (kDebugMode) {
           print("crm home data......${response.data}");
         }
        if (kDebugMode) {
          print("crm home data......${response.data}");
        }
        var obj = crmHomeModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = crmHomeModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = crmHomeModelFromJson(e.response.toString());
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


  ///previous home 
  static Future<ApiResponse<StaticsModel>> getAllStatics() async {
    try {
      var response = await ApiService.getDio()!.get("/dashboard/statistics");
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = staticsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = staticsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        // EasyLoading.dismiss();
        var obj = staticsModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        // EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

  /// get all holiday data from here
  static Future<ApiResponse<EventHolidayModel>> getUpcomingEvents() async {
    try {
      var response =
          await ApiService.getDio()!.post("/upcoming-events/get-list", data: '');
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = eventHolidayModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = eventHolidayModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        // EasyLoading.dismiss();
        var obj = eventHolidayModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        // EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

  static Future<ApiResponse<UpcomingModel>> getAppointment() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/appoinment/get-list");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = upcomingModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = upcomingModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = upcomingModelFromJson(e.response.toString());
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
