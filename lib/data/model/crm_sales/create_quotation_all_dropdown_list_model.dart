
import 'dart:convert';

CreateQuotationAllDropdownListModel createQuotationAllDropdownListModelFromJson(String str) => CreateQuotationAllDropdownListModel.fromJson(json.decode(str));

class CreateQuotationAllDropdownListModel {
  bool? result;
  String? message;
  Data? data;

  CreateQuotationAllDropdownListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CreateQuotationAllDropdownListModel.fromJson(Map<String, dynamic> json) => CreateQuotationAllDropdownListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Value>? biller;
  List<Value>? warehouse;
  List<Value>? customer;
  List<Value>? supplier;
  List<Value>? taxList;
  List<Value>? quotationStatusList;

  Data({
    this.biller,
    this.warehouse,
    this.customer,
    this.supplier,
    this.taxList,
    this.quotationStatusList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    biller: json["biller"] == null ? [] : List<Value>.from(json["biller"]!.map((x) => Value.fromJson(x))),
    warehouse: json["warehouse"] == null ? [] : List<Value>.from(json["warehouse"]!.map((x) => Value.fromJson(x))),
    customer: json["customer"] == null ? [] : List<Value>.from(json["customer"]!.map((x) => Value.fromJson(x))),
    supplier: json["supplier"] == null ? [] : List<Value>.from(json["supplier"]!.map((x) => Value.fromJson(x))),
    taxList: json["tax_list"] == null ? [] : List<Value>.from(json["tax_list"]!.map((x) => Value.fromJson(x))),
    quotationStatusList: json["quotation_status_list"] == null ? [] : List<Value>.from(json["quotation_status_list"]!.map((x) => Value.fromJson(x)))
  );
}

class Value {
  int? id;
  String? name;

  Value({
    this.id,
    this.name,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    name: json["name"],
  );
}
