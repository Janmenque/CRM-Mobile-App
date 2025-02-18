import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/report_response/attendance_response/report_attendance_list_reponse.dart';
import 'package:hrm_app/data/model/report_response/attendance_response/r_attendence_response.dart';

class AttendanceReportRepository {
  static Future<ApiResponse<ReportAttendanceResponse>> postReportAttendance(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/report/attendance/date-summary");
      }
      var response = await ApiService.getDio()!.post("/report/attendance/date-summary", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = reportAttendanceRepositoryFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = reportAttendanceRepositoryFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        // EasyLoading.dismiss();
        var obj = reportAttendanceRepositoryFromJson(e.response.toString());
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
  static Future<ApiResponse<ReportAttendanceListResponse>> postReportAttendanceList(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/report/attendance/summary-to-list");
      }
      var response = await ApiService.getDio()!.post("/report/attendance/summary-to-list", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = reportAttendanceListResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = reportAttendanceListResponseFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = reportAttendanceListResponseFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }
}