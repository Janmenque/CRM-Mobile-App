
import 'dart:convert';

ContractNoteListModel contractNoteListModelFromJson(String str) => ContractNoteListModel.fromJson(json.decode(str));


class ContractNoteListModel {
  bool? result;
  String? message;
  List<ContractNote>? data;

  ContractNoteListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractNoteListModel.fromJson(Map<String, dynamic> json) => ContractNoteListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractNote>.from(json["data"]!.map((x) => ContractNote.fromJson(x))),
  );
}

class ContractNote {
  String? note;
  String? status;
  String? created;

  ContractNote({
    this.note,
    this.status,
    this.created,
  });

  factory ContractNote.fromJson(Map<String, dynamic> json) => ContractNote(
    note: json["note"],
    status: json["status"],
    created: json["created"],
  );
}
