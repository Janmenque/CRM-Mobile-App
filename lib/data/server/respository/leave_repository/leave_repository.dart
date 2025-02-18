import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/response_all_leave_request.dart';
import 'package:hrm_app/data/model/response_all_leave_request_details.dart';
import 'package:hrm_app/data/model/response_create_leave_request.dart';
import 'package:hrm_app/data/model/response_leave_summary.dart';
import 'package:hrm_app/data/model/response_leave_type.dart';

class LeaveRepository{
  /// Leave summary API -----------------
  static Future<ApiResponse<ResponseLeaveSummary>> leaveSummary(
      BodyUserId bodyUserId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/summary", data: bodyUserId);

      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseLeaveSummaryFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseLeaveSummaryFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
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

  /// LEAVE TYPE API -----------------
  static Future<ApiResponse<ResponseLeaveType>> leaveTypeApi(
      BodyUserId bodyUserId) async {
    if (kDebugMode) {
      print(bodyUserId);
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/available", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseLeaveTypeFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseLeaveTypeFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseLeaveTypeFromJson(e.response.toString());
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

  /// ALL LEAVE REQUEST LIST API -----------------
  static Future<ApiResponse<ResponseAllLeaveRequest>> allLeaveRequest(
      BodyLeaveRequest bodyLeaveRequest) async {
    if (kDebugMode) {
      print(bodyLeaveRequest.toJson());
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/list/view", data: bodyLeaveRequest);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = ResponseAllLeaveRequest.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = ResponseAllLeaveRequest.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = ResponseAllLeaveRequest.fromJson(
            json.decode(e.response.toString()));
        // var obj = responseLeaveTypeFromJson(e.response.toString());
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

  /// ALL LEAVE REQUEST DETAILS SCREEN API -----------------
  static Future<ApiResponse<ResponseLeaveRequestDetails>> leaveRequestDetails(
      BodyUserId bodyUserId, requestId) async {
    if (kDebugMode) {
      print(bodyUserId.toJson());
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/details/$requestId", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = ResponseLeaveRequestDetails.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = ResponseLeaveRequestDetails.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = ResponseLeaveRequestDetails.fromJson(
            json.decode(e.response.toString()));
        // var obj = responseLeaveTypeFromJson(e.response.toString());
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

  /// Create leave request API -----------------
  static Future<ApiResponse<ResponseCreateLeaveRequest>> createLeaveRequestApi(
      int? userId,
      int? leaveTypeId,
      int? managerId,
      String? applyDate,
      String? starDate,
      String? endDate,
      String? reason,
      File? attachmentPath,
      ) async {
    var fileAttachment = attachmentPath?.path.split('/').last;

    var fromData = FormData.fromMap({
      "user_id": userId,
      "assign_leave_id": leaveTypeId,
      "substitute_id": managerId,
      "apply_date": applyDate,
      "leave_from": starDate,
      "leave_to": endDate,
      "reason": reason,
      "attachment_file": attachmentPath?.path != null
          ? await MultipartFile.fromFile(attachmentPath!.path,
          filename: fileAttachment)
          : null,
    });

    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/request", data: fromData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseCreateLeaveRequestFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseCreateLeaveRequestFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
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

  /// Update leave request API -----------------
  static Future<ApiResponse> updateLeaveRequest(
      {final fromData, leaveId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/leave/request/update/$leaveId", data: fromData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data['message'];
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data['result'],
            message: obj,
            data: obj);
      } else {
        var obj = response.toString();
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data['result'],
            message: obj,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = e.response.toString();
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

  /// cancel request -----------------
  static Future<ApiResponse> cancelRequest({final parmas}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
      await ApiService.getDio()!.get("/user/leave/request/cancel/$parmas");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data['message'];
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data['result'],
            message: obj,
            data: obj);
      } else {
        var obj = response.data['message'];
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseCreateLeaveRequestFromJson(e.response.toString());
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