import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/department_list_model.dart';
import 'package:hrm_app/data/model/employee_model/designation_list_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_dashboard_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmEmployeeRepository {
  ///employee dashboard
  static Future<ApiResponse<EmployeeDashboardModel>>
      getCrmEployeeHomeData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/employees");
      if (response.statusCode == 200) {
        var obj = employeeDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = employeeDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = employeeDashboardModelFromJson(e.response.toString());
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

  ///employee list
  static Future<ApiResponse<EmployeeListModel>> getCrmEployeeList({String? reposearch}) async {
    try {
      var response = await ApiService.getDio()!.get("/app/employees/list?keyword=$reposearch");
      if (response.statusCode == 200) {
        var obj = employeeListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = employeeListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = employeeListModelFromJson(e.response.toString());
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

//////// Department list////////

  static Future<ApiResponse<DepartmentListModel>>
      getCrmEployeeDermentList() async {
    try {
      var response = await ApiService.getDio()!.get("/app/get-department");

      if (response.statusCode == 200) {
        var obj = departmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = departmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = departmentListModelFromJson(e.response.toString());
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

  static Future deleteDepartment(departmentId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.get('/app/delete-department?id=$departmentId');
      EasyLoading.dismiss();
      var obj = response.data;
      return obj;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }

  static Future<ApiResponse<DesignationListModel>> getDesignationList(
      {String? reposearch}) async {
    try {
      var response = await ApiService.getDio()!.get("/app/get-designation?keyword=$reposearch");

      if (response.statusCode == 200) {
        var obj = designationListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = designationListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = designationListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

  static Future deleteDesignation(designationId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.get('/app/delete-designation?id=$designationId');
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }
}
