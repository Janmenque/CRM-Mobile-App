
import 'dart:convert';

ResponseFinancial responseFinancialFromJson(String str) =>
    ResponseFinancial.fromJson(json.decode(str));

String responseFinancialToJson(ResponseFinancial data) =>
    json.encode(data.toJson());

class ResponseFinancial {
  ResponseFinancial({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseFinancial.fromJson(Map<String, dynamic> json) =>
      ResponseFinancial(
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
