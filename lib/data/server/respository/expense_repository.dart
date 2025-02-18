import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/expense_model/expanse_claims_details.dart';
import 'package:hrm_app/data/model/expense_model/expense_category_model.dart';
import 'package:hrm_app/data/model/expense_model/expense_list_details_model.dart';
import 'package:hrm_app/data/model/expense_model/expense_list_model.dart';
import 'package:hrm_app/data/model/expense_model/response_expense_detail.dart';
import 'package:hrm_app/data/model/expense_model/response_expense_list.dart';
import '../../model/expense_model/expanse_claim_model.dart';
import '../../model/expense_model/payment_history_model.dart';

class ExpenseRepository {
  static Future<ExpenseListModel?> postExpenseList(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
          await ApiService.getDio()!.post("/expense/list", data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseListModel.fromJson(response.data);
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  /// send all claim remarks
  static Future sendClaimRemarks(data) async {
    try {
      // EasyLoading.show(status: 'loading...');
      var response =
          await ApiService.getDio()!.post("/expense/send-claim", data: data);
      // EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = response.data;
        return obj;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  static Future<ExpenseListDetailsModel?> getExpenseListDetails(id) async {
    try {
      var response =
          await ApiService.getDio()!.get("/expense/single-expense/$id");
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseListDetailsModel.fromJson(response.data);
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  static Future<ExpenseCategoryModel?> getExpenseCategory() async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.get('/accounts/expense/category-list');
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseCategoryModel.fromJson(response.data);

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  static Future<ExpenseCategoryModel?> getCategory() async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.get('/accounts/expense/category-list');
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseCategoryModel.fromJson(response.data);

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  static Future postExpenseAdd(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/accounts/expense/add', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
      return e.response?.data;
    }
   
  }

  static Future<ApiResponse<ResponseExpenseList>> expenseList(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post('/accounts/expense/list', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ResponseExpenseList.fromJson(response.data);

      return ApiResponse(
          httpCode: response.statusCode,
          result: obj.result,
          message: obj.message,
          data: obj);
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
      var obj = ResponseExpenseList.fromJson(e.response?.data);
      return ApiResponse(
          httpCode: e.response?.statusCode,
          result: e.response!.data["result"],
          message: e.response!.data["message"],
          data: obj);
    }
  }

  static Future postExpenseEdit(data, id) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/expense/update/$id', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }

    return null;
  }

  ///payment history
  static Future<PaymentHistoryModel?> postPaymentList(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/expense/payment-history', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = paymentHistoryModelFromJson(response.data);

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  static Future<ExpenseClaimModel?> postExpanseClaim(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/expense/claim-history', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseClaimModel.fromJson(response.data);
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  static Future<ExpenseClaimDetailsModel?> postExpenseClaimDetails(id) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/expense/claim-details/$id', data: '');
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = ExpenseClaimDetailsModel.fromJson(response.data);
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }

  /// Attendance base-settings API -----------------
  static Future<ApiResponse<ResponseExpenseDetail>> expenseDetailApi(int? expenseId) async {
    try {
      var response = await ApiService.getDio()!.get("/accounts/expense/view/$expenseId");
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = ResponseExpenseDetail.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = ResponseExpenseDetail.fromJson(response.data);
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        // EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response?.statusCode,
            result: e.response?.data["result"],
            message: e.response?.data["message"],
            error: e.response?.data["error"]);
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

  static Future deleteExpense(id) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.delete('/expense/delete/$id', data: '');
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
    return null;
  }
}
