
import 'dart:convert';

ResponseExpenseList responseExpenseListFromJson(String str) => ResponseExpenseList.fromJson(json.decode(str));

String responseExpenseListToJson(ResponseExpenseList data) => json.encode(data.toJson());

class ResponseExpenseList {
  ResponseExpenseList({
    this.data,
    this.result,
    this.message,
    this.paymentType,
    this.expanseStatus,
    this.status,
  });

  List<ExpenseItem>? data;
  bool? result;
  String? message;
  List<ExpanseStatus>? paymentType;
  List<ExpanseStatus>? expanseStatus;
  int? status;

  factory ResponseExpenseList.fromJson(Map<String, dynamic> json) => ResponseExpenseList(
    data: List<ExpenseItem>.from(json["data"].map((x) => ExpenseItem.fromJson(x))),
    result: json["result"],
    message: json["message"],
    paymentType: List<ExpanseStatus>.from(json["payment_type"].map((x) => ExpanseStatus.fromJson(x))),
    expanseStatus: List<ExpanseStatus>.from(json["expanse_status"].map((x) => ExpanseStatus.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "result": result,
    "message": message,
    "payment_type": List<dynamic>.from(paymentType!.map((x) => x.toJson())),
    "expanse_status": List<dynamic>.from(expanseStatus!.map((x) => x.toJson())),
    "status": status,
  };
}

class ExpenseItem {
  ExpenseItem({
    this.id,
    this.category,
    this.requestedAmount,
    this.approvedAmount,
    this.dateShow,
    this.dateDb,
    this.payment,
    this.paymentColor,
    this.status,
    this.statusColor,
    this.reason,
  });

  int? id;
  String? category;
  String? requestedAmount;
  String? approvedAmount;
  String? dateShow;
  String? dateDb;
  String? payment;
  String? paymentColor;
  String? status;
  String? statusColor;
  String? reason;

  factory ExpenseItem.fromJson(Map<String, dynamic> json) => ExpenseItem(
    id: json["id"],
    category: json["category"],
    requestedAmount: json["requested_amount"],
    approvedAmount: json["approved_amount"],
    dateShow: json["date_show"],
    dateDb: json["date_db"],
    payment: json["payment"],
    paymentColor: json["payment_color"],
    status: json["status"],
    statusColor: json["status_color"],
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
    "payment_color": paymentColor,
    "status": status,
    "status_color": statusColor,
    "reason": reason,
  };
}

class ExpanseStatus {
  ExpanseStatus({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ExpanseStatus.fromJson(Map<String, dynamic> json) => ExpanseStatus(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
