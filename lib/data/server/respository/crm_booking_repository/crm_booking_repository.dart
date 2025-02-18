import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/campaign/campaign_list_model.dart';
import 'package:hrm_app/data/model/coupon/coupon_customer_list_model.dart';
import 'package:hrm_app/data/model/coupon/coupon_list_model.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/data/model/discount/discount_list_model.dart';

class CrmBookingRepository {


  /// Discount list
  static Future<ApiResponse<DiscountListModel>> getDiscountListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/booking/discounts");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = discountListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = discountListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = discountListModelFromJson(e.response.toString());
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



  ///Create Discount Component list
  static Future<ApiResponse<DiscountCreateComponentListModel>> getCreateDiscountComponentListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/booking/discount-create");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = discountCreateComponentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = discountCreateComponentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = discountCreateComponentListModelFromJson(e.response.toString());
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



  ///create discount
  static Future postAddDiscount(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/booking/discount-store", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
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



  /// Campaign list
  static Future<ApiResponse<CampaignListModel>> getCampaignListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/booking/campaigns");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = campaignListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = campaignListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = campaignListModelFromJson(e.response.toString());
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



  ///create campaign
  static Future postAddCampaign(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/booking/campaign-store", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
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




  /// Coupon list
  static Future<ApiResponse<CouponListModel>> getCouponListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/booking/coupons");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = couponListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = couponListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = couponListModelFromJson(e.response.toString());
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



  /// Coupon Customer list
  static Future<ApiResponse<CouponCustomerListModel>> getCouponCustomerListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/booking/customer-list");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = couponCustomerListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = couponCustomerListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = couponCustomerListModelFromJson(e.response.toString());
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



  ///create Coupon
  static Future postAddCoupon(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/booking/coupons-store", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
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

}