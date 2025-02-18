
import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
      result: json["result"],
      message: json["message"],
      data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      laravelValidationError: json["error"] != null
          ? LaravelValidationError.formjson(json["error"])
          : null);

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.companyId,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.token,
  });

  int? id;
  int? companyId;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avatar: json["avatar"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "token": token,
      };
}

class LaravelValidationError {
  final String? email;
  final String? password;

  LaravelValidationError({this.email, this.password});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        email: json["email"] != null ? json["email"][0] : null,
        password: json["password"] != null ? json["password"][0] : null);
  }
}
