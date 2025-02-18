
import 'dart:convert';

ResponseCheckOut responseCheckOutFromJson(String str) => ResponseCheckOut.fromJson(json.decode(str));

String responseCheckOutToJson(ResponseCheckOut data) => json.encode(data.toJson());

class ResponseCheckOut {
  ResponseCheckOut({
    this.result,
    this.message,
    this.data,
    this.laravelValidationError
  });

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseCheckOut.fromJson(Map<String, dynamic> json) => ResponseCheckOut(
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
    this.id,
    this.companyId,
    this.userId,
    this.date,
    this.checkIn,
    this.checkOut,
    this.lateReason,
    this.lateTime,
    this.inStatus,
    this.outStatus,
    this.checkinIp,
    this.checkoutIp,
    this.remoteModeIn,
    this.remoteModeOut,
    this.checkInLocation,
    this.checkOutLocation,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.checkInCity,
    this.checkInCountryCode,
    this.checkInCountry,
    this.checkOutCity,
    this.checkOutCountryCode,
    this.checkOutCountry,
    this.statusId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? companyId;
  int? userId;
  String? date;
  DateTime? checkIn;
  DateTime? checkOut;
  String? lateReason;
  int? lateTime;
  String? inStatus;
  String? outStatus;
  String? checkinIp;
  String? checkoutIp;
  int? remoteModeIn;
  int? remoteModeOut;
  String? checkInLocation;
  String? checkOutLocation;
  String? checkOutLatitude;
  String? checkOutLongitude;
  String? checkInCity;
  String? checkInCountryCode;
  String? checkInCountry;
  String? checkOutCity;
  String? checkOutCountryCode;
  String? checkOutCountry;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    companyId: int.parse(json["company_id"].toString()),
    userId: json["user_id"],
    date: json["date"],
    checkIn: DateTime.parse(json["check_in"]),
    checkOut: DateTime.parse(json["check_out"]),
    lateReason: json["late_reason"],
    lateTime: json["late_time"],
    inStatus: json["in_status"],
    outStatus: json["out_status"],
    checkinIp: json["checkin_ip"],
    checkoutIp: json["checkout_ip"],
    remoteModeIn: int.parse(json["remote_mode_in"].toString()),
    remoteModeOut: json["remote_mode_out"],
    checkInLocation: json["check_in_location"],
    checkOutLocation: json["check_out_location"],
    checkOutLatitude: json["check_out_latitude"],
    checkOutLongitude: json["check_out_longitude"],
    checkInCity: json["check_in_city"],
    checkInCountryCode: json["check_in_country_code"],
    checkInCountry: json["check_in_country"],
    checkOutCity: json["check_out_city"],
    checkOutCountryCode: json["check_out_country_code"],
    checkOutCountry: json["check_out_country"],
    statusId: int.parse(json["status_id"].toString()),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "user_id": userId,
    "date": date,
    "check_in": checkIn!.toIso8601String(),
    "check_out": checkOut!.toIso8601String(),
    "late_reason": lateReason,
    "late_time": lateTime,
    "in_status": inStatus,
    "out_status": outStatus,
    "checkin_ip": checkinIp,
    "checkout_ip": checkoutIp,
    "remote_mode_in": remoteModeIn,
    "remote_mode_out": remoteModeOut,
    "check_in_location": checkInLocation,
    "check_out_location": checkOutLocation,
    "check_out_latitude": checkOutLatitude,
    "check_out_longitude": checkOutLongitude,
    "check_in_city": checkInCity,
    "check_in_country_code": checkInCountryCode,
    "check_in_country": checkInCountry,
    "check_out_city": checkOutCity,
    "check_out_country_code": checkOutCountryCode,
    "check_out_country": checkOutCountry,
    "status_id": statusId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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