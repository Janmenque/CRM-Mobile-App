
import 'dart:convert';

ResponseApprovalOrReject responseApprovalOrRejectFromJson(String str) => ResponseApprovalOrReject.fromJson(json.decode(str));

String responseApprovalOrRejectToJson(ResponseApprovalOrReject data) => json.encode(data.toJson());

class ResponseApprovalOrReject {
  ResponseApprovalOrReject({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseApprovalOrReject.fromJson(Map<String, dynamic> json) => ResponseApprovalOrReject(
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
