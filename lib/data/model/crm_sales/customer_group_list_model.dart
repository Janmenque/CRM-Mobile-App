import 'dart:convert';

CustomerGroupListModel customerGroupListModelFromJson(String str) => CustomerGroupListModel.fromJson(json.decode(str));


class CustomerGroupListModel {
  bool? result;
  String? message;
  List<CustomerGroup>? data;

  CustomerGroupListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CustomerGroupListModel.fromJson(Map<String, dynamic> json) => CustomerGroupListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CustomerGroup>.from(json["data"]!.map((x) => CustomerGroup.fromJson(x))),
  );
}

class CustomerGroup {
  int? id;
  String? name;

  CustomerGroup({
    this.id,
    this.name,
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) => CustomerGroup(
    id: json["id"],
    name: json["name"],
  );
}
