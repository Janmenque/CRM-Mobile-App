
import 'dart:convert';

ComposeMailContractList composeMailContractListFromJson(String str) => ComposeMailContractList.fromJson(json.decode(str));


class ComposeMailContractList {
  bool? result;
  String? message;
  List<ComposeContract>? data;

  ComposeMailContractList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailContractList.fromJson(Map<String, dynamic> json) => ComposeMailContractList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeContract>.from(json["data"]!.map((x) => ComposeContract.fromJson(x))),
  );
}

class ComposeContract {
  int? id;
  String? subject;
  int? contractAmount;
  int? clientId;
  Client? client;

  ComposeContract({
    this.id,
    this.subject,
    this.contractAmount,
    this.clientId,
    this.client,
  });

  factory ComposeContract.fromJson(Map<String, dynamic> json) => ComposeContract(
    id: json["id"],
    subject: json["subject"],
    contractAmount: json["contract_amount"],
    clientId: json["client_id"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );
}

class Client {
  int? id;
  String? name;

  Client({
    this.id,
    this.name,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
  );

}
