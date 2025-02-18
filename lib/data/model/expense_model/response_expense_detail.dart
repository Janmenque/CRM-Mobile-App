
import 'dart:convert';

ResponseExpenseDetail responseExpenseDetailFromJson(String str) => ResponseExpenseDetail.fromJson(json.decode(str));

String responseExpenseDetailToJson(ResponseExpenseDetail data) => json.encode(data.toJson());

class ResponseExpenseDetail {
  ResponseExpenseDetail({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseExpenseDetail.fromJson(Map<String, dynamic> json) => ResponseExpenseDetail(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.category,
    this.requestedAmount,
    this.approvedAmount,
    this.dateShow,
    this.dateDb,
    this.payment,
    this.status,
    this.reason,
  });

  int? id;
  String? category;
  String? requestedAmount;
  String? approvedAmount;
  String? dateShow;
  String? dateDb;
  String? payment;
  String? status;
  String? reason;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    category: json["category"],
    requestedAmount: json["requested_amount"],
    approvedAmount: json["approved_amount"],
    dateShow: json["date_show"],
    dateDb: json["date_db"],
    payment: json["payment"],
    status: json["status"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "requested_amount": requestedAmount,
    "approved_amount": approvedAmount,
    "date_show": dateShow,
    "date_db": dateDb,
    "payment": payment,
    "status": status,
    "reason": reason,
  };
}
