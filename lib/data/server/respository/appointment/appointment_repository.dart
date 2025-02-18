import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/appointment_model/appointment_details_model.dart';
import '../../../model/response_meeting_list.dart';

class AppointmentRepository{
  static Future<ApiResponse<ResponseMeetingList>> postAppointmentList(data) async {
    try {
      if (kDebugMode) {
        print("/appoinment/get-list");
      }
      var response = await ApiService.getDio()!.post("/appoinment/get-list", data: data);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseMeetingListFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseMeetingListFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = responseMeetingListFromJson(e.response.toString());
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

  static Future postCreateAppointment(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/appoinment/create");
      }
      final response = await ApiService.getDio()!.post("/appoinment/create", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
     if (kDebugMode) {
       print(e);
     }
     EasyLoading.dismiss();
     Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  ///Appointment Details
  static Future<ApiResponse<AppointmentDetailsModel>> getAppointmentDetails(id) async {
    try {
      EasyLoading.show(status: 'loading...');
      if (kDebugMode) {
        print("/appoinment/details/$id");
      }
      var response = await ApiService.getDio()!.get("/appoinment/details/$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = appointmentDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = appointmentDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = appointmentDetailsModelFromJson(e.response.toString());
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