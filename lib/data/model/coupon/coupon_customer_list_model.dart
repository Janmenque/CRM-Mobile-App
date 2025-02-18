
import 'dart:convert';

CouponCustomerListModel couponCustomerListModelFromJson(String str) => CouponCustomerListModel.fromJson(json.decode(str));


class CouponCustomerListModel {
  bool? result;
  String? message;
  List<CouponCustomer>? data;

  CouponCustomerListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CouponCustomerListModel.fromJson(Map<String, dynamic> json) => CouponCustomerListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CouponCustomer>.from(json["data"]!.map((x) => CouponCustomer.fromJson(x))),
  );

}

class CouponCustomer {
  int? id;
  String? name;

  CouponCustomer({
    this.id,
    this.name,
  });

  factory CouponCustomer.fromJson(Map<String, dynamic> json) => CouponCustomer(
    id: json["id"],
    name: json["name"],
  );
}
