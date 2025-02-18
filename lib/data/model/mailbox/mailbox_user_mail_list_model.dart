import 'dart:convert';

MailBoxUserMailListModel mailBoxUserMailListModelFromJson(String str) => MailBoxUserMailListModel.fromJson(json.decode(str));

class MailBoxUserMailListModel {
  bool? result;
  String? message;
  List<MailBoxUser>? data;

  MailBoxUserMailListModel({
    this.result,
    this.message,
    this.data,
  });

  factory MailBoxUserMailListModel.fromJson(Map<String, dynamic> json) => MailBoxUserMailListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MailBoxUser>.from(json["data"]!.map((x) => MailBoxUser.fromJson(x))),
  );
}

class MailBoxUser {
  int? id;
  String? email;

  MailBoxUser({
    this.id,
    this.email,
  });

  factory MailBoxUser.fromJson(Map<String, dynamic> json) => MailBoxUser(
    id: json["id"],
    email: json["email"],
  );
}
