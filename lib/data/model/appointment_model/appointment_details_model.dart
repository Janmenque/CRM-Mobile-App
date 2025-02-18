
import 'dart:convert';

AppointmentDetailsModel appointmentDetailsModelFromJson(String str) => AppointmentDetailsModel.fromJson(json.decode(str));

class AppointmentDetailsModel {
  AppointmentDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory AppointmentDetailsModel.fromJson(Map<String, dynamic> json) => AppointmentDetailsModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.id,
    this.title,
    this.date,
    this.day,
    this.time,
    this.startAt,
    this.endAt,
    this.location,
    this.appoinmentWith,
    this.otherParticipant,
  });

  int? id;
  String? title;
  String? date;
  String? day;
  String? time;
  String? startAt;
  String? endAt;
  String? location;
  String? appoinmentWith;
  OtherParticipant? otherParticipant;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    day: json["day"],
    time: json["time"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    location: json["location"],
    appoinmentWith: json["appoinmentWith"],
    otherParticipant: OtherParticipant.fromJson(json["other_participant"]),
  );
}

class OtherParticipant {
  OtherParticipant({
    this.id,
    this.name,
    this.isAgree,
    this.isPresent,
    this.presentAt,
    this.appoinmentStartedAt,
    this.appoinmentEndedAt,
    this.appoinmentDuration,
  });

  int? id;
  String? name;
  String? isAgree;
  String? isPresent;
  dynamic presentAt;
  dynamic appoinmentStartedAt;
  dynamic appoinmentEndedAt;
  dynamic appoinmentDuration;

  factory OtherParticipant.fromJson(Map<String, dynamic> json) => OtherParticipant(
    id: json["id"],
    name: json["name"],
    isAgree: json["is_agree"],
    isPresent: json["is_present"],
    presentAt: json["present_at"],
    appoinmentStartedAt: json["appoinment_started_at"],
    appoinmentEndedAt: json["appoinment_ended_at"],
    appoinmentDuration: json["appoinment_duration"],
  );
}
