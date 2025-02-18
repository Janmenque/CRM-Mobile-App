class ExpenseClaimDetailsModel {
  ExpenseClaimDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ExpenseClaimDetailsModel.fromJson(Map<String, dynamic> json) => ExpenseClaimDetailsModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.month,
    this.totalAmount,
    this.claimData,
  });

  String? month;
  String? totalAmount;
  ClaimData? claimData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    month: json["month"],
    totalAmount: json["total_amount"],
    claimData: ClaimData.fromJson(json["claim_data"]),
  );
}

class ClaimData {
  ClaimData({
    this.data,
  });

  List<Datum>? data;

  factory ClaimData.fromJson(Map<String, dynamic> json) => ClaimData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  Datum({
    this.id,
    this.date,
    this.category,
    this.amount,
  });

  int? id;
  String? date;
  String? category;
  String? amount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"],
    category: json["category"],
    amount: json["amount"],
  );
}
