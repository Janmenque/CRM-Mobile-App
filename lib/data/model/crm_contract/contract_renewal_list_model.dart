import 'dart:convert';

ContractRenewalsListModel contractRenewalsListModelFromJson(String str) => ContractRenewalsListModel.fromJson(json.decode(str));


class ContractRenewalsListModel {
  bool? result;
  String? message;
  List<ContractRenewal>? data;

  ContractRenewalsListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractRenewalsListModel.fromJson(Map<String, dynamic> json) => ContractRenewalsListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractRenewal>.from(json["data"]!.map((x) => ContractRenewal.fromJson(x))),
  );

}

class ContractRenewal {
  String? contractValue;
  String? created;
  String? startDate;
  String? endDate;

  ContractRenewal({
    this.contractValue,
    this.created,
    this.startDate,
    this.endDate,
  });

  factory ContractRenewal.fromJson(Map<String, dynamic> json) => ContractRenewal(
    contractValue: json["contract_value"],
    created: json["created"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

}
