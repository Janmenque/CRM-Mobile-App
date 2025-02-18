
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.notifications,
  });

  List<Notification>? notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    this.id,
    this.sender,
    this.senderId,
    this.title,
    this.body,
    this.image,
    this.date,
    this.slag,
    this.isRead,
  });

  String? id;
  String? sender;
  int? senderId;
  String? title;
  String? body;
  String? image;
  String? date;
  String? slag;
  bool? isRead;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    sender: json["sender"],
    senderId: json["sender_id"],
    title: json["title"],
    body: json["body"],
    image: json["image"],
    date: json["date"],
    slag: json["slag"],
    isRead: json["is_read"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender,
    "sender_id": senderId,
    "title": title,
    "body": body,
    "image": image,
    "date": date,
    "slag": slag,
    "is_read": isRead,
  };
}
