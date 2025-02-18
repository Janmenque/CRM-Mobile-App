
import 'dart:convert';

ComposeMailEstimateList composeMailEstimateListFromJson(String str) => ComposeMailEstimateList.fromJson(json.decode(str));

class ComposeMailEstimateList {
  bool? result;
  String? message;
  List<ComposeEstimate>? data;

  ComposeMailEstimateList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailEstimateList.fromJson(Map<String, dynamic> json) => ComposeMailEstimateList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeEstimate>.from(json["data"]!.map((x) => ComposeEstimate.fromJson(x))),
  );
}

class ComposeEstimate {
  int? id;
  int? totalCost;
  String? invoiceNo;

  ComposeEstimate({
    this.id,
    this.totalCost,
    this.invoiceNo,
  });

  factory ComposeEstimate.fromJson(Map<String, dynamic> json) => ComposeEstimate(
    id: json["id"],
    totalCost: json["total_cost"],
    invoiceNo: json["invoice_no"],
  );

}
