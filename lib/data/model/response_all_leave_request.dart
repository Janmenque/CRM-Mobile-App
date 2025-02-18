class ResponseAllLeaveRequest {
  ResponseAllLeaveRequest({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  DataList? data;

  factory ResponseAllLeaveRequest.fromJson(Map<String, dynamic> json) =>
      ResponseAllLeaveRequest(
        result: json["result"],
        message: json["message"],
        data: json["data"] != null ? DataList.fromJson(json["data"]) : null,
      );
}

class DataList {
  DataList({
    this.availableLeave,
  });

  List<RequestLeave>? availableLeave;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        availableLeave: json['leaveRequests'] != null
            ? List<RequestLeave>.from(
                json["leaveRequests"].map((x) => RequestLeave.fromJson(x)),
              )
            : null,
      );
}

class RequestLeave {
  int? id;
  String? type;
  int? days;
  String? status;
  String? applyDate;
  String? colorCode;

  RequestLeave(
      {this.id,
      this.type,
      this.days,
      this.status,
      this.applyDate,
      this.colorCode});

  factory RequestLeave.fromJson(Map<String, dynamic> json) => RequestLeave(
      id: json['id'],
      type: json['type'],
      days: int.parse(json['days'].toString()),
      status: json['status'],
      applyDate: json['apply_date'],
      colorCode: json['color_code']);
}