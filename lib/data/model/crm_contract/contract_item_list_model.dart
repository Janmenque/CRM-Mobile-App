
import 'dart:convert';

ContractItemListModel contractItemListModelFromJson(String str) => ContractItemListModel.fromJson(json.decode(str));


class ContractItemListModel {
  bool? result;
  String? message;
  List<ContractItem>? data;

  ContractItemListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractItemListModel.fromJson(Map<String, dynamic> json) => ContractItemListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractItem>.from(json["data"]!.map((x) => ContractItem.fromJson(x))),
  );
}

class ContractItem {
  String? serviceName;
  String? created;

  ContractItem({
    this.serviceName,
    this.created,
  });

  factory ContractItem.fromJson(Map<String, dynamic> json) => ContractItem(
    serviceName: json["service_name"],
    created: json["created"],
  );
}
