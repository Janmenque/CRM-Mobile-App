
import 'dart:convert';

ResponseEditEmergency responseEditEmergencyFromJson(String str) =>
    ResponseEditEmergency.fromJson(json.decode(str));

String responseEditEmergencyToJson(ResponseEditEmergency data) =>
    json.encode(data.toJson());

class ResponseEditEmergency {
  ResponseEditEmergency(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseEditEmergency.fromJson(Map<String, dynamic> json) =>
      ResponseEditEmergency(
          result: json["result"],
          message: json["message"],
          data: json["data"] != null ? Data.fromJson(json["data"]) : null,
          laravelValidationError: json["error"] != null
              ? LaravelValidationError.formjson(json["error"])
              : null);

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

class LaravelValidationError {
  final String? emergencyNumber;


  LaravelValidationError({this.emergencyNumber});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        emergencyNumber: json["emergency_mobile_number"] != null ? json["emergency_mobile_number"][0] : null);
  }
}
