import 'dart:convert';

DailyLeaveSummaryResponse dailyLeaveSummaryResponseFromJson(String str) => DailyLeaveSummaryResponse.fromJson(json.decode(str));

String dailyLeaveSummaryResponseToJson(DailyLeaveSummaryResponse data) => json.encode(data.toJson());

class DailyLeaveSummaryResponse {
  DailyLeaveSummaryResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory DailyLeaveSummaryResponse.fromJson(Map<String, dynamic> json) => DailyLeaveSummaryResponse(
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
    this.approved,
    this.rejected,
    this.pending,
  });

  Approved? approved;
  Approved? rejected;
  Approved? pending;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    approved: Approved.fromJson(json["approved"]),
    rejected: Approved.fromJson(json["rejected"]),
    pending: Approved.fromJson(json["pending"]),
  );

  Map<String, dynamic> toJson() => {
    "approved": approved!.toJson(),
    "rejected": rejected!.toJson(),
    "pending": pending!.toJson(),
  };
}

class Approved {
  Approved({
    this.earlyLeave,
    this.lateArrive,
  });

  int? earlyLeave;
  int? lateArrive;

  factory Approved.fromJson(Map<String, dynamic> json) => Approved(
    earlyLeave: json["early_leave"],
    lateArrive: json["late_arrive"],
  );

  Map<String, dynamic> toJson() => {
    "early_leave": earlyLeave,
    "late_arrive": lateArrive,
  };
}
