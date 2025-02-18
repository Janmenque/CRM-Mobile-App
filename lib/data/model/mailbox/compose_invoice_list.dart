
import 'dart:convert';

ComposeMailInvoiceList composeMailInvoiceListFromJson(String str) => ComposeMailInvoiceList.fromJson(json.decode(str));


class ComposeMailInvoiceList {
  bool? result;
  String? message;
  List<ComposeInvoice>? data;

  ComposeMailInvoiceList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailInvoiceList.fromJson(Map<String, dynamic> json) => ComposeMailInvoiceList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeInvoice>.from(json["data"]!.map((x) => ComposeInvoice.fromJson(x))),
  );

}

class ComposeInvoice {
  int? id;
  int? totalCost;
  String? invoiceNo;

  ComposeInvoice({
    this.id,
    this.totalCost,
    this.invoiceNo,
  });

  factory ComposeInvoice.fromJson(Map<String, dynamic> json) => ComposeInvoice(
    id: json["id"],
    totalCost: json["total_cost"],
    invoiceNo: json["invoice_no"],
  );
}
