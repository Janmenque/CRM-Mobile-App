import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_details_response.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_single_view_response.dart';
import 'package:hrm_app/data/model/daily_leave/daily_leave_summary_response.dart';

class DailyLeaveRepository {
  static Future<ApiResponse<DailyLeaveSummaryResponse>> postDailyLeaveSummery(
      data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/daily-leave/leave-list");
      }
      var response = await ApiService.getDio()!
          .post("/daily-leave/leave-list", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = dailyLeaveSummaryResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = dailyLeaveSummaryResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = dailyLeaveSummaryResponseFromJson(e.response.toString());
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

  static Future<ApiResponse<DailyLeaveDetailsResponse>> dailyLeaveDetails(
      data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/daily-leave/staff-list-view");
      }
      var response = await ApiService.getDio()!
          .post("/daily-leave/staff-list-view", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = dailyLeaveDetailsResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = dailyLeaveDetailsResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = dailyLeaveDetailsResponseFromJson(e.response.toString());
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

  ///Daily leave single View
  static Future<ApiResponse<DailyLeaveSingleViewResponse>> dailyLeaveSingleView(
      data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/daily-leave/single-view");
      }
      var response = await ApiService.getDio()!
          .post("/daily-leave/single-view", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = dailyLeaveSingleViewResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = dailyLeaveSingleViewResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = dailyLeaveSingleViewResponseFromJson(e.response.toString());
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

  static Future createDailyLeaveRequest(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/daily-leave/store");
      }
      var response =
          await ApiService.getDio()!.post("/daily-leave/store", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data;
        return obj;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
    }
  }

  ///leave approved $ rejected
  static Future createLeaveApprovedRejected(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/daily-leave/approve-reject");
      }
      var response =
      await ApiService.getDio()!.post("/daily-leave/approve-reject", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data;
        return obj;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
    }
  }
}
