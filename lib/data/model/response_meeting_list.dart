
import 'dart:convert';

ResponseMeetingList responseMeetingListFromJson(String str) =>
    ResponseMeetingList.fromJson(json.decode(str));

String responseMeetingListToJson(ResponseMeetingList data) =>
    json.encode(data.toJson());

class ResponseMeetingList {
  ResponseMeetingList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseMeetingList.fromJson(Map<String, dynamic> json) =>
      ResponseMeetingList(
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
    this.items,
  });

  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item(
      {this.id,
      this.title,
      this.date,
      this.day,
      this.time,
      this.startAt,
      this.endAt,
      this.location,
      this.duration,
      this.participants,
      this.appointmentWith});

  int? id;
  String? title;
  String? date;
  String? day;
  String? time;
  String? startAt;
  String? endAt;
  String? location;
  String? duration;
  List<Participant>? participants;
  String? appointmentWith;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        day: json["day"],
        time: json["time"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        location: json["location"],
        duration: json["duration"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
        appointmentWith: json["appoinmentWith"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "day": day,
        "time": time,
        "start_at": startAt,
        "end_at": endAt,
        "location": location,
        "duration": duration,
        "participants":
            List<dynamic>.from(participants!.map((x) => x.toJson())),
      };
}

class Participant {
  Participant({
    this.name,
    this.isAgree,
    this.isPresent,
    this.presentAt,
  });

  String? name;
  String? isAgree;
  String? isPresent;
  String? presentAt;

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        name: json["name"],
        isAgree: json["is_agree"],
        isPresent: json["is_present"],
        presentAt: json["present_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_agree": isAgree,
        "is_present": isPresent,
        "present_at": presentAt,
      };
}
