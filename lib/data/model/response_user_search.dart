
import 'dart:convert';

ResponseUserSearch responseUserSearchFromJson(String str) => ResponseUserSearch.fromJson(json.decode(str));

String responseUserSearchToJson(ResponseUserSearch data) => json.encode(data.toJson());

class ResponseUserSearch {
  ResponseUserSearch({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseUserSearch.fromJson(Map<String, dynamic> json) => ResponseUserSearch(
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
    this.users,
  });

  List<User>? users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.phone,
    this.designation,
    this.avatar,
  });

  int? id;
  String? name;
  String? phone;
  String? designation;
  String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    designation: json["designation"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "designation": designation,
    "avatar": avatar,
  };
}
