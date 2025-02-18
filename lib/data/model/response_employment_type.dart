
import 'dart:convert';

ResponseEmploymentType responseEmploymentTypeFromJson(String str) => ResponseEmploymentType.fromJson(json.decode(str));

String responseEmploymentTypeToJson(ResponseEmploymentType data) => json.encode(data.toJson());

class ResponseEmploymentType {
  ResponseEmploymentType({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseEmploymentType.fromJson(Map<String, dynamic> json) => ResponseEmploymentType(
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
    this.types,
  });

  List<String>? types;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    types: List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "types": List<dynamic>.from(types!.map((x) => x)),
  };
}
