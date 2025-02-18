
import 'dart:convert';

ComposeMailNoteList composeMailNoteListFromJson(String str) => ComposeMailNoteList.fromJson(json.decode(str));


class ComposeMailNoteList {
  bool? result;
  String? message;
  List<ComposeNote>? data;

  ComposeMailNoteList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailNoteList.fromJson(Map<String, dynamic> json) => ComposeMailNoteList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeNote>.from(json["data"]!.map((x) => ComposeNote.fromJson(x))),
  );

}

class ComposeNote {
  int? id;
  String? description;

  ComposeNote({
    this.id,
    this.description,
  });

  factory ComposeNote.fromJson(Map<String, dynamic> json) => ComposeNote(
    id: json["id"],
    description: json["description"],
  );

}
