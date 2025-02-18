import 'dart:convert';

ComposeMailSalePaymentList composeMailSalePaymentListFromJson(String str) => ComposeMailSalePaymentList.fromJson(json.decode(str));


class ComposeMailSalePaymentList {
  bool? result;
  String? message;
  List<ComposeSalePayment>? data;

  ComposeMailSalePaymentList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailSalePaymentList.fromJson(Map<String, dynamic> json) => ComposeMailSalePaymentList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeSalePayment>.from(json["data"]!.map((x) => ComposeSalePayment.fromJson(x))),
  );
}

class ComposeSalePayment {
  int? id;
  int? amount;
  int? saleId;
  dynamic purchaseId;
  String? paymentReference;

  ComposeSalePayment({
    this.id,
    this.amount,
    this.saleId,
    this.purchaseId,
    this.paymentReference,
  });

  factory ComposeSalePayment.fromJson(Map<String, dynamic> json) => ComposeSalePayment(
    id: json["id"],
    amount: json["amount"],
    saleId: json["sale_id"],
    purchaseId: json["purchase_id"],
    paymentReference: json["payment_reference"],
  );
}
