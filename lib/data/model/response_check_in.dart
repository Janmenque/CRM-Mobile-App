
import 'dart:convert';

ResponseCheckIn responseCheckInFromJson(String str) => ResponseCheckIn.fromJson(json.decode(str));

String responseCheckInToJson(ResponseCheckIn data) => json.encode(data.toJson());

class ResponseCheckIn {
  ResponseCheckIn({
    this.result,
    this.message,
    this.data,
    this.laravelValidationError
  });

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseCheckIn.fromJson(Map<String, dynamic> json) => ResponseCheckIn(
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
    this.companyId,
    this.userId,
    this.remoteModeIn,
    this.checkIn,
    this.inStatus,
    this.checkinIp,
    this.lateTime,
    this.checkInLocation,
    this.checkInLatitude,
    this.checkInLongitude,
    this.checkInCity,
    this.checkInCountryCode,
    this.checkInCountry,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? companyId;
  int? userId;
  int? remoteModeIn;
  DateTime? checkIn;
  String? inStatus;
  String? checkinIp;
  int? lateTime;
  String? checkInLocation;
  String? checkInLatitude;
  String? checkInLongitude;
  String? checkInCity;
  String? checkInCountryCode;
  String? checkInCountry;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyId: json["company_id"],
    userId: json["user_id"],
    remoteModeIn: json["remote_mode_in"],
    checkIn: DateTime.parse(json["check_in"]),
    inStatus: json["in_status"],
    checkinIp: json["checkin_ip"],
    lateTime: json["late_time"],
    checkInLocation: json["check_in_location"],
    checkInLatitude: json["check_in_latitude"],
    checkInLongitude: json["check_in_longitude"],
    checkInCity: json["check_in_city"],
    checkInCountryCode: json["check_in_country_code"],
    checkInCountry: json["check_in_country"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "company_id": companyId,
    "user_id": userId,
    "remote_mode_in": remoteModeIn,
    "check_in": checkIn!.toIso8601String(),
    "in_status": inStatus,
    "checkin_ip": checkinIp,
    "late_time": lateTime,
    "check_in_location": checkInLocation,
    "check_in_latitude": checkInLatitude,
    "check_in_longitude": checkInLongitude,
    "check_in_city": checkInCity,
    "check_in_country_code": checkInCountryCode,
    "check_in_country": checkInCountry,
    "updated_at": updatedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "id": id,
  };
}

class LaravelValidationError{
  final String? reason;
  LaravelValidationError({this.reason});
  factory LaravelValidationError.formjson(Map<String, dynamic> json){
    return LaravelValidationError(
        reason: json["reason_status"]);
  }
}
