
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
    this.isAdmin,
    this.isHr,
    this.isFaceRegistered,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.token,
    this.baseUrl,
    this.apiUrl,
  });

  int? id;
  int? companyId;
  bool? isAdmin;
  bool? isHr;
  bool? isFaceRegistered;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  String? token;
  String? baseUrl;
  String? apiUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    companyId: int.parse(json["company_id"].toString()),
    isAdmin: json["is_admin"],
    isHr: json["is_hr"],
    isFaceRegistered: json["is_face_registered"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
    token: json["token"],
    baseUrl: json["base_url"],
    apiUrl: json["api_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    'is_admin': isAdmin,
    'is_hr': isHr,
    'is_face_registered' : isFaceRegistered,
    "name": name,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "token": token,
    "base_url": baseUrl,
    "api_url": apiUrl,
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
