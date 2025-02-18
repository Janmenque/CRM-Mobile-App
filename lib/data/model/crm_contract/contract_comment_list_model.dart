
import 'dart:convert';

ContractCommentListModel contractCommentListModelFromJson(String str) => ContractCommentListModel.fromJson(json.decode(str));


class ContractCommentListModel {
  bool? result;
  String? message;
  List<ContractComment>? data;

  ContractCommentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractCommentListModel.fromJson(Map<String, dynamic> json) => ContractCommentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractComment>.from(json["data"]!.map((x) => ContractComment.fromJson(x))),
  );

}

class ContractComment {
  String? message;
  String? created;

  ContractComment({
    this.message,
    this.created,
  });

  factory ContractComment.fromJson(Map<String, dynamic> json) => ContractComment(
    message: json["message"],
    created: json["created"],
  );

}
