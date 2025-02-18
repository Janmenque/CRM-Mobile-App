
import 'dart:convert';

LeadsAttachmentListModel leadsAttachmentListModelFromJson(String str) => LeadsAttachmentListModel.fromJson(json.decode(str));


class LeadsAttachmentListModel {
  bool? result;
  String? message;
  List<LeadAttachment>? data;

  LeadsAttachmentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadsAttachmentListModel.fromJson(Map<String, dynamic> json) => LeadsAttachmentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadAttachment>.from(json["data"]!.map((x) => LeadAttachment.fromJson(x))),
  );
}

class LeadAttachment {
  String? author;
  String? date;
  String? filePath;
  String? fileSize;
  String? title;

  LeadAttachment({
    this.author,
    this.date,
    this.filePath,
    this.fileSize,
    this.title,
  });

  factory LeadAttachment.fromJson(Map<String, dynamic> json) => LeadAttachment(
    author: json["author"],
    date: json["date"],
    filePath: json["file_path"],
    fileSize: json["file_size"],
    title: json["title"],
  );

}
