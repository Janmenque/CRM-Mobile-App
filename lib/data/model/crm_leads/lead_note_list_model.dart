import 'dart:convert';

LeadNoteListModel leadNoteListModelFromJson(String str) => LeadNoteListModel.fromJson(json.decode(str));

class LeadNoteListModel {
  bool? result;
  String? message;
  List<LeadNote>? data;

  LeadNoteListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadNoteListModel.fromJson(Map<String, dynamic> json) => LeadNoteListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadNote>.from(json["data"]!.map((x) => LeadNote.fromJson(x))),
  );

}

class LeadNote {
  String? date;
  String? author;
  String? message;
  String? subject;

  LeadNote({
    this.date,
    this.author,
    this.message,
    this.subject,
  });

  factory LeadNote.fromJson(Map<String, dynamic> json) => LeadNote(
    date: json["date"],
    author: json["author"],
    message: json["message"],
    subject: json["subject"],
  );

}
