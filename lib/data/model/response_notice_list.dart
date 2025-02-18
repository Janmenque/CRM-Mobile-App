
import 'dart:convert';

ResponseNoticeList responseNoticeListFromJson(String str) => ResponseNoticeList.fromJson(json.decode(str));

String responseNoticeListToJson(ResponseNoticeList data) => json.encode(data.toJson());

class ResponseNoticeList {
  ResponseNoticeList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseNoticeList.fromJson(Map<String, dynamic> json) => ResponseNoticeList(
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
    this.notices,
  });

  Notices? notices;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notices: Notices.fromJson(json["notices"]),
  );

  Map<String, dynamic> toJson() => {
    "notices": notices!.toJson(),
  };
}

class Notices {
  Notices({
    this.data,
  });

  List<NoticeList>? data;

  factory Notices.fromJson(Map<String, dynamic> json) => Notices(
    data: List<NoticeList>.from(json["data"].map((x) => NoticeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NoticeList {
  NoticeList({
    this.id,
    this.subject,
    this.description,
    this.date,
    this.file,
  });

  int? id;
  String? subject;
  String? description;
  String? date;
  String? file;

  factory NoticeList.fromJson(Map<String, dynamic> json) => NoticeList(
    id: json["id"],
    subject: json["subject"],
    description: json["description"],
    date: json["date"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "description": description,
    "date": date,
    "file": file,
  };
}
