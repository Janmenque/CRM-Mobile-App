
import 'dart:convert';

CrmCreateContractComponent crmCreateContractComponentFromJson(String str) => CrmCreateContractComponent.fromJson(json.decode(str));


class CrmCreateContractComponent {
  bool? result;
  String? message;
  Data? data;

  CrmCreateContractComponent({
    this.result,
    this.message,
    this.data,
  });

  factory CrmCreateContractComponent.fromJson(Map<String, dynamic> json) => CrmCreateContractComponent(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ContractComponent>? clients;
  List<ContractComponent>? contractType;
  String? isServiceBase;
  List<ContractComponent>? services;

  Data({
    this.clients,
    this.contractType,
    this.isServiceBase,
    this.services,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clients: json["clients"] == null ? [] : List<ContractComponent>.from(json["clients"]!.map((x) => ContractComponent.fromJson(x))),
    contractType: json["contract_type"] == null ? [] : List<ContractComponent>.from(json["contract_type"]!.map((x) => ContractComponent.fromJson(x))),
    isServiceBase: json["is_service_base"],
    services: json["services"] == null ? [] : List<ContractComponent>.from(json["services"]!.map((x) => ContractComponent.fromJson(x))),
  );

}

class ContractComponent {
  int? id;
  String? name;

  ContractComponent({
    this.id,
    this.name,
  });

  factory ContractComponent.fromJson(Map<String, dynamic> json) => ContractComponent(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
