
import 'dart:convert';

ResponseCancelVisit responseCancelVisitFromJson(String str) => ResponseCancelVisit.fromJson(json.decode(str));

String responseCancelVisitToJson(ResponseCancelVisit data) => json.encode(data.toJson());

class ResponseCancelVisit {
  ResponseCancelVisit({
    this.visitId,
    this.title,
    this.status,
    this.latitude,
    this.longitude,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? visitId;
  String? title;
  String? status;
  String? latitude;
  String? longitude;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory ResponseCancelVisit.fromJson(Map<String, dynamic> json) => ResponseCancelVisit(
    visitId: json["visit_id"],
    title: json["title"],
    status: json["status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "visit_id": visitId,
    "title": title,
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}
