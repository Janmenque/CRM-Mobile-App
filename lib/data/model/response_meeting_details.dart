
import 'dart:convert';

ResponseMeetingDetails responseMeetingDetailsFromJson(String str) => ResponseMeetingDetails.fromJson(json.decode(str));

String responseMeetingDetailsToJson(ResponseMeetingDetails data) => json.encode(data.toJson());

class ResponseMeetingDetails {
  ResponseMeetingDetails({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseMeetingDetails.fromJson(Map<String, dynamic> json) => ResponseMeetingDetails(
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
    this.id,
    this.title,
    this.description,
    this.location,
    this.meetingAt,
    this.duration,
    this.startAt,
    this.endAt,
    this.status,
    this.color,
    this.attachmentFile,
  });

  int? id;
  String? title;
  String? description;
  String? location;
  DateTime? meetingAt;
  String? duration;
  String? startAt;
  String? endAt;
  String? status;
  String? color;
  String? attachmentFile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    meetingAt: DateTime.parse(json["meeting_at"]),
    duration: json["duration"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    status: json["status"],
    color: json["color"],
    attachmentFile: json["attachment_file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "meeting_at": "${meetingAt!.year.toString().padLeft(4, '0')}-${meetingAt!.month.toString().padLeft(2, '0')}-${meetingAt!.day.toString().padLeft(2, '0')}",
    "duration": duration,
    "start_at": startAt,
    "end_at": endAt,
    "status": status,
    "color": color,
    "attachment_file": attachmentFile,
  };
}
