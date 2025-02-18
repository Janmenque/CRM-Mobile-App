import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/report_response/leave_response/report_leave_details_response.dart';
import 'package:hrm_app/data/model/report_response/leave_response/report_leave_summery_response.dart';

class LeaveReportRepository{
  static Future<ApiResponse<ReportLeaveSummeryResponse>> postLeaveSummery(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/report/leave/date-summary");
      }
      var response = await ApiService.getDio()!.post("/report/leave/date-summary", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = reportLeaveSummeryResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = reportLeaveSummeryResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = reportLeaveSummeryResponseFromJson(e.response.toString());
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

  static Future<ApiResponse<LeaveReportDetailsResponse>> postLeaveDetailsSummery(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/report/leave/date-wise-leave");
      }
      var response = await ApiService.getDio()!.post("/report/leave/date-wise-leave", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = leaveReportDetailsResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leaveReportDetailsResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leaveReportDetailsResponseFromJson(e.response.toString());
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