
import 'dart:convert';

ResponseDesignation responseDesignationFromJson(String str) => ResponseDesignation.fromJson(json.decode(str));

String responseDesignationToJson(ResponseDesignation data) => json.encode(data.toJson());

class ResponseDesignation {
  ResponseDesignation({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseDesignation.fromJson(Map<String, dynamic> json) => ResponseDesignation(
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
  Data({
    this.designations,
  });

  List<Designation>? designations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    designations: List<Designation>.from(json["designations"].map((x) => Designation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "designations": List<dynamic>.from(designations!.map((x) => x.toJson())),
  };
}

class Designation {
  Designation({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
