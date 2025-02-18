
import 'dart:convert';

ComposeMailProposalList composeMailProposalListFromJson(String str) => ComposeMailProposalList.fromJson(json.decode(str));


class ComposeMailProposalList {
  bool? result;
  String? message;
  List<ComposeProposal>? data;

  ComposeMailProposalList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailProposalList.fromJson(Map<String, dynamic> json) => ComposeMailProposalList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeProposal>.from(json["data"]!.map((x) => ComposeProposal.fromJson(x))),
  );
}

class ComposeProposal {
  int? id;
  int? totalCost;
  String? invoiceNo;

  ComposeProposal({
    this.id,
    this.totalCost,
    this.invoiceNo,
  });

  factory ComposeProposal.fromJson(Map<String, dynamic> json) => ComposeProposal(
    id: json["id"],
    totalCost: json["total_cost"],
    invoiceNo: json["invoice_no"],
  );

}
