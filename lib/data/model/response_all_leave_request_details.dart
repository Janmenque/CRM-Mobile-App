class ResponseLeaveRequestDetails {
  ResponseLeaveRequestDetails({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseLeaveRequestDetails.fromJson(Map<String, dynamic> json) =>
      ResponseLeaveRequestDetails(
        result: json["result"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]):null,
      );
}

class Data {
  Data(
      {this.id,
      this.status,
      this.requestedOn,
      this.type,
      this.period,
      this.note,
      this.totalDays,
      this.substitute,
      this.apporover,
      this.attachment,
      this.colorCode});

  int? id;
  String? status;
  String? requestedOn;
  String? type;
  String? period;
  String? note;
  int? totalDays;
  SubstituteData? substitute;
  String? apporover;
  String? attachment;
  String? colorCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      status: json["status"],
      requestedOn: json["requested_on"],
      type: json["type"],
      period: json["period"],
      note: json["note"],
      totalDays: int.parse(json['total_days'].toString()),
      substitute: json['substitute'] != null
          ? SubstituteData.fromData(json['substitute'])
          : null,
      apporover: json["apporover"],
      attachment: json["attachment"],
      colorCode: json["color_code"]);
}

class SubstituteData {
  int? id;
  String? name;
  String? designation;
  String? avatar;

  SubstituteData({this.id, this.name, this.designation, this.avatar});

  factory SubstituteData.fromData(Map<String, dynamic> json) => SubstituteData(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      avatar: json['avatar']);
}
