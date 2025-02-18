
import 'dart:convert';

ResponseEditPersonalInfo responseEditPersonalInfoFromJson(String str) =>
    ResponseEditPersonalInfo.fromJson(json.decode(str));

String responseEditPersonalInfoToJson(ResponseEditPersonalInfo data) =>
    json.encode(data.toJson());

class ResponseEditPersonalInfo {
  ResponseEditPersonalInfo(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseEditPersonalInfo.fromJson(Map<String, dynamic> json) =>
      ResponseEditPersonalInfo(
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
    this.gender,
    this.phone,
    this.birthDateDb,
    this.address,
    this.nationality,
    this.nidCardNumber,
    this.nidCardId,
    this.passportNumber,
    this.passportFile,
    this.maritalStatus,
    this.bloodGroup,
    this.facebookLink,
    this.linkedinLink,
    this.instagramLink,
    this.birthDate
  });

  String? gender;
  String? phone;
  DateTime? birthDateDb;
  String? address;
  String? nationality;
  String? nidCardNumber;
  String? nidCardId;
  String? passportNumber;
  String? passportFile;
  String? maritalStatus;
  String? bloodGroup;
  String? facebookLink;
  String? linkedinLink;
  String? instagramLink;
  String? birthDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gender: json["gender"],
        phone: json["phone"],
        birthDateDb: json["birth_date_db"] != null
            ? DateTime.parse(json["birth_date_db"])
            : null,
        address: json["address"],
        nationality: json["nationality"],
        nidCardNumber: json["nid_card_number"],
        nidCardId: json["nid_card_id"],
        passportNumber: json["passport_number"],
        passportFile: json["passport_file"],
        maritalStatus: json["marital_status"],
        bloodGroup: json["blood_group"],
        facebookLink: json["facebook_link"],
        linkedinLink: json["linkedin_link"],
        instagramLink: json["instagram_link"],
        birthDate: json["birth_date"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "phone": phone,
        "birth_date_db":
            "${birthDateDb!.year.toString().padLeft(4, '0')}-${birthDateDb!.month.toString().padLeft(2, '0')}-${birthDateDb!.day.toString().padLeft(2, '0')}",
        "address": address,
        "nationality": nationality,
        "nid_card_number": nidCardNumber,
        "nid_card_id": nidCardId,
        "passport_number": passportNumber,
        "passport_file": passportFile,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,
        "facebook_link": facebookLink,
        "linkedin_link": linkedinLink,
        "instagram_link": instagramLink,
        "birth_date": birthDate,
      };
}

class LaravelValidationError {
  final String? phone;

  LaravelValidationError({this.phone});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        phone: json["phone"] != null ? json["phone"][0] : null);
  }
}
