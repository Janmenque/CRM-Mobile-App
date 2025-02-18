
import 'dart:convert';

ResponseVisitDetails responseVisitDetailsFromJson(String str) =>
    ResponseVisitDetails.fromJson(json.decode(str));

String responseVisitDetailsToJson(ResponseVisitDetails data) =>
    json.encode(data.toJson());

class ResponseVisitDetails {
  ResponseVisitDetails({
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

  factory ResponseVisitDetails.fromJson(Map<String, dynamic> json) =>
      ResponseVisitDetails(
        data: Data.fromJson(json["data"]),
        env: json["env"],
        result: json["result"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "env": env,
        "result": result,
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    this.id,
    this.title,
    this.date,
    this.description,
    this.status,
    this.statusColor,
    this.imageListVisit,
    this.notes,
    this.schedules,
    this.nextStatus,
  });

  int? id;
  String? title;
  String? date;
  String? description;
  String? status;
  String? statusColor;
  List<ImageListVisit>? imageListVisit;
  List<Note>? notes;
  List<Schedule>? schedules;
  NextStatus? nextStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        description: json["description"],
        status: json["status"],
        statusColor: json["status_color"],
        imageListVisit: List<ImageListVisit>.from(json["images"].map((x) => ImageListVisit.fromJson(x))),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
        nextStatus: NextStatus.fromJson(json["next_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "description": description,
        "status": status,
        "status_color": statusColor,
        "images": List<dynamic>.from(imageListVisit!.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes!.map((x) => x.toJson())),
        "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "next_status": nextStatus!.toJson(),
      };
}

class ImageListVisit {
  ImageListVisit({
    this.id,
    this.fileId,
    this.filePath,
  });

  int? id;
  int? fileId;
  String? filePath;

  factory ImageListVisit.fromJson(Map<String, dynamic> json) => ImageListVisit(
        id: json["id"],
        fileId: json["file_id"],
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_id": fileId,
        "file_path": filePath,
      };
}

class NextStatus {
  NextStatus({
    this.status,
    this.statusText,
  });

  String? status;
  String? statusText;

  factory NextStatus.fromJson(Map<String, dynamic> json) => NextStatus(
        status: json["status"],
        statusText: json["status_text"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_text": statusText,
      };
}

class Note {
  Note({
    this.note,
    this.status,
    this.statusColor,
    this.dateTime,
  });

  String? note;
  String? status;
  String? statusColor;
  String? dateTime;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        note: json["note"],
        status: json["status"],
        statusColor: json["status_color"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "status": status,
        "status_color": statusColor,
        "date_time": dateTime,
      };
}

class Schedule {
  Schedule({
    this.title,
    this.latitude,
    this.longitude,
    this.note,
    this.status,
    this.statusColor,
    this.dateTime,
  });

  String? title;
  String? latitude;
  String? longitude;
  String? note;
  String? status;
  String? statusColor;
  String? dateTime;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        title: json["title"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        note: json["note"],
        status: json["status"],
        statusColor: json["status_color"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
        "status": status,
        "status_color": statusColor,
        "date_time": dateTime,
      };
}
