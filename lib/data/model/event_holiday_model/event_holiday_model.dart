
import 'dart:convert';

EventHolidayModel eventHolidayModelFromJson(String str) =>
    EventHolidayModel.fromJson(json.decode(str));

class EventHolidayModel {
  EventHolidayModel({
    this.data,
    this.env,
    this.result,
    this.message,
    this.status,
  });

  Data? data;
  String? env;
  bool? result;
  String? message;
  int? status;

  factory EventHolidayModel.fromJson(Map<String, dynamic> json) =>
      EventHolidayModel(
        data: Data.fromJson(json["data"]),
        env: json["env"],
        result: json["result"],
        message: json["message"],
        status: json["status"],
      );
}

class Data {
  Data({
    this.items,
  });

  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json['items'] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : null,
      );
}

class Item {
  Item({
    this.id,
    this.title,
    this.description,
    this.date,
    this.day,
    this.startDate,
    this.endDate,
    this.attachmentFileId,
  });

  int? id;
  String? title;
  String? description;
  String? date;
  String? day;
  String? startDate;
  String? endDate;
  String? attachmentFileId;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json['date'],
        day: json['day'],
        startDate: json["start_date"],
        endDate: json["end_date"],
        attachmentFileId: json["attachment_file_id"],
      );
}
