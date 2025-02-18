
import 'dart:convert';

ResponseEmergency responseEmergencyFromJson(String str) =>
    ResponseEmergency.fromJson(json.decode(str));

String responseEmergencyToJson(ResponseEmergency data) =>
    json.encode(data.toJson());

class ResponseEmergency {
  ResponseEmergency({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseEmergency.fromJson(Map<String, dynamic> json) =>
      ResponseEmergency(
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
    this.emergencyName,
    this.emergencyMobileNumber,
    this.emergencyMobileRelationship,
  });

  String? emergencyName;
  String? emergencyMobileNumber;
  String? emergencyMobileRelationship;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        emergencyName: json["emergency_name"],
        emergencyMobileNumber: json["emergency_mobile_number"],
        emergencyMobileRelationship: json["emergency_mobile_relationship"],
      );

  Map<String, dynamic> toJson() => {
        "emergency_name": emergencyName,
        "emergency_mobile_number": emergencyMobileNumber,
        "emergency_mobile_relationship": emergencyMobileRelationship,
      };
}
