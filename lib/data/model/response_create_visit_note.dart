
import 'dart:convert';

ResponseCreateVisitNote responseCreateVisitNoteFromJson(String str) => ResponseCreateVisitNote.fromJson(json.decode(str));

String responseCreateVisitNoteToJson(ResponseCreateVisitNote data) => json.encode(data.toJson());

class ResponseCreateVisitNote {
  ResponseCreateVisitNote({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseCreateVisitNote.fromJson(Map<String, dynamic> json) => ResponseCreateVisitNote(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
