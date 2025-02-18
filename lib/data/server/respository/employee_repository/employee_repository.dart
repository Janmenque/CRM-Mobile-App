
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/employee_model/employee_details_model.dart';

class EmployeeRepository {
  static Future<ApiResponse<EmployeeDetailsModel>> getEmployeeDetails(
      id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .get("/app/employees/details?employee_id=$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm home data......${response.data}");
        }
        if (kDebugMode) {
          print("crm home data......${response.data}");
        }
        var obj = employeeDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = employeeDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = employeeDetailsModelFromJson(e.response.toString());
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

  static Future addEmployee(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/employees/store', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }

  static Future editEmployees(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/employees/update', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }

  static Future addDesignation(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/store-designation', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message']);
      return e.response?.data;
    }
  }

  static Future addDepartment(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/store-department', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message']);
      return e.response?.data;
    }
  }

  static Future editDepartments(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/update-department', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message']);
      return e.response?.data;
    }
  }

  static Future editDesignation(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/app/update-designation', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message']);
      return e.response?.data;
    }
  }


  ///employee delete
  static Future employeeDelete(
      int? employeeId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/employees/delete/$employeeId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = response.data;
        return obj;
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }

}
