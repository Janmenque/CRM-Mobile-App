import 'dart:convert';

ContractAttachmentListModel contractAttachmentListModelFromJson(String str) => ContractAttachmentListModel.fromJson(json.decode(str));

class ContractAttachmentListModel {
  bool? result;
  String? message;
  List<ContractAttachment>? data;

  ContractAttachmentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractAttachmentListModel.fromJson(Map<String, dynamic> json) => ContractAttachmentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractAttachment>.from(json["data"]!.map((x) => ContractAttachment.fromJson(x))),
  );

}

class ContractAttachment {
  String? title;
  String? attachmentFile;

  ContractAttachment({
    this.title,
    this.attachmentFile,
  });

  factory ContractAttachment.fromJson(Map<String, dynamic> json) => ContractAttachment(
    title: json["title"],
    attachmentFile: json["attachment_file"],
  );
}
