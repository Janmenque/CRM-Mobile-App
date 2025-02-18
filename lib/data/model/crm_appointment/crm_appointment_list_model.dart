import 'dart:convert';

CrmAppointmentListModel crmAppointmentListModelFromJson(String str) => CrmAppointmentListModel.fromJson(json.decode(str));

class CrmAppointmentListModel {
  Data? data;
  String? env;
  bool? result;
  String? message;
  int? status;

  CrmAppointmentListModel({
    this.data,
    this.env,
    this.result,
    this.message,
    this.status,
  });

  factory CrmAppointmentListModel.fromJson(Map<String, dynamic> json) => CrmAppointmentListModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    env: json["env"],
    result: json["result"],
    message: json["message"],
    status: json["status"],
  );

}

class Data {
  List<Appointment>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<Appointment>.from(json["items"]!.map((x) => Appointment.fromJson(x))),
  );
}

class Appointment {
  int? id;
  String? title;
  String? status;
  String? date;
  String? day;
  String? time;
  String? startAt;
  String? endAt;
  String? location;
  String? appoinmentWith;
  List<Participant>? participants;

  Appointment({
    this.id,
    this.status,
    this.title,
    this.date,
    this.day,
    this.time,
    this.startAt,
    this.endAt,
    this.location,
    this.appoinmentWith,
    this.participants,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    date: json["date"],
    day: json["day"],
    time: json["time"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    location: json["location"],
    appoinmentWith: json["appoinmentWith"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
  );
}

class Participant {
  String? name;
  String? isAgree;
  String? isPresent;
  dynamic presentAt;
  dynamic appoinmentStartedAt;
  dynamic appoinmentEndedAt;
  dynamic appoinmentDuration;

  Participant({
    this.name,
    this.isAgree,
    this.isPresent,
    this.presentAt,
    this.appoinmentStartedAt,
    this.appoinmentEndedAt,
    this.appoinmentDuration,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    name: json["name"],
    isAgree: json["is_agree"],
    isPresent: json["is_present"],
    presentAt: json["present_at"],
    appoinmentStartedAt: json["appoinment_started_at"],
    appoinmentEndedAt: json["appoinment_ended_at"],
    appoinmentDuration: json["appoinment_duration"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_agree": isAgree,
    "is_present": isPresent,
    "present_at": presentAt,
    "appoinment_started_at": appoinmentStartedAt,
    "appoinment_ended_at": appoinmentEndedAt,
    "appoinment_duration": appoinmentDuration,
  };
}
