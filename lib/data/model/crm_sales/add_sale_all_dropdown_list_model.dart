
import 'dart:convert';

AddSalesAllDropdownListModel addSalesAllDropdownListModelFromJson(String str) => AddSalesAllDropdownListModel.fromJson(json.decode(str));

class AddSalesAllDropdownListModel {
  bool? result;
  String? message;
  Data? data;

  AddSalesAllDropdownListModel({
    this.result,
    this.message,
    this.data,
  });

  factory AddSalesAllDropdownListModel.fromJson(Map<String, dynamic> json) => AddSalesAllDropdownListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<SaleData>? biller;
  List<SaleData>? warehouse;
  List<SaleData>? customer;
  List<SaleData>? taxList;
  List<DiscountType>? discountTypeList;
  List<SaleData>? saleStatusList;
  List<SaleData>? paymentStatusList;

  Data({
    this.biller,
    this.warehouse,
    this.customer,
    this.taxList,
    this.discountTypeList,
    this.saleStatusList,
    this.paymentStatusList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    biller: json["biller"] == null ? [] : List<SaleData>.from(json["biller"]!.map((x) => SaleData.fromJson(x))),
    warehouse: json["warehouse"] == null ? [] : List<SaleData>.from(json["warehouse"]!.map((x) => SaleData.fromJson(x))),
    customer: json["customer"] == null ? [] : List<SaleData>.from(json["customer"]!.map((x) => SaleData.fromJson(x))),
    taxList: json["tax_list"] == null ? [] : List<SaleData>.from(json["tax_list"]!.map((x) => SaleData.fromJson(x))),
    discountTypeList: json["discount_type_list"] == null ? [] : List<DiscountType>.from(json["discount_type_list"]!.map((x) => DiscountType.fromJson(x))),
    saleStatusList: json["sale_status_list"] == null ? [] : List<SaleData>.from(json["sale_status_list"]!.map((x) => SaleData.fromJson(x))),
    paymentStatusList: json["payment_status_list"] == null ? [] : List<SaleData>.from(json["payment_status_list"]!.map((x) => SaleData.fromJson(x))),
  );
}

class SaleData {
  int? id;
  String? name;

  SaleData({
    this.id,
    this.name,
  });

  factory SaleData.fromJson(Map<String, dynamic> json) => SaleData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class DiscountType {
  String? value;
  String? name;

  DiscountType({
    this.value,
    this.name,
  });

  factory DiscountType.fromJson(Map<String, dynamic> json) => DiscountType(
    value: json["value"],
    name: json["name"],
  );
}
