
import 'dart:convert';

ResponseBloodGroup responseBloodGroupFromJson(String str) => ResponseBloodGroup.fromJson(json.decode(str));

String responseBloodGroupToJson(ResponseBloodGroup data) => json.encode(data.toJson());

class ResponseBloodGroup {
  ResponseBloodGroup({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseBloodGroup.fromJson(Map<String, dynamic> json) => ResponseBloodGroup(
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
    this.bloodGroup,
  });

  List<String>? bloodGroup;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bloodGroup: List<String>.from(json["blood_group"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "blood_group": List<dynamic>.from(bloodGroup!.map((x) => x)),
  };
}
