
PaymentHistoryModel paymentHistoryModelFromJson(str) => PaymentHistoryModel.fromJson(str);

class PaymentHistoryModel {
  PaymentHistoryModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.data,
  });

  List<Datum>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.id,
    this.invoiceNumber,
    this.paymentDate,
    this.payableAmount,
    this.paidAmount,
    this.dueAmount,
    this.status,
    this.colorCode,
  });

  int? id;
  String? invoiceNumber;
  String? paymentDate;
  String? payableAmount;
  String? paidAmount;
  String? dueAmount;
  String? status;
  String? colorCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        paymentDate: json["payment_date"],
        payableAmount: json["payable_amount"],
        paidAmount: json["paid_amount"],
        dueAmount: json["due_amount"],
        status: json["status"],
        colorCode: json["color_code"],
      );
}
