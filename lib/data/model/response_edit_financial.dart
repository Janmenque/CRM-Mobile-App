
import 'dart:convert';

ResponseEditFinancial responseEditFinancialFromJson(String str) =>
    ResponseEditFinancial.fromJson(json.decode(str));

String responseEditFinancialToJson(ResponseEditFinancial data) =>
    json.encode(data.toJson());

class ResponseEditFinancial {
  ResponseEditFinancial({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseEditFinancial.fromJson(Map<String, dynamic> json) =>
      ResponseEditFinancial(
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
    this.tin,
    this.bankName,
    this.bankAccount,
  });

  String? tin;
  String? bankName;
  String? bankAccount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tin: json["tin"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
      );

  Map<String, dynamic> toJson() => {
        "tin": tin,
        "bank_name": bankName,
        "bank_account": bankAccount,
      };
}
