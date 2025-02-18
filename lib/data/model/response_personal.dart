
import 'dart:convert';

ResponsePersonal responsePersonalFromJson(String str) =>
    ResponsePersonal.fromJson(json.decode(str));

String responsePersonalToJson(ResponsePersonal data) =>
    json.encode(data.toJson());

class ResponsePersonal {
  ResponsePersonal({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponsePersonal.fromJson(Map<String, dynamic> json) =>
      ResponsePersonal(
        result: json["result"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

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
    this.birthDate,
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
  });

  String? gender;
  String? phone;
  DateTime? birthDateDb;
  String? birthDate;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gender: json["gender"],
        phone: json["phone"],
        birthDateDb: json["birth_date_db"] != null
            ? DateTime.parse(json["birth_date_db"])
            : null,
        birthDate: json["birth_date"],
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
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "phone": phone,
        "birth_date_db":
            "${birthDateDb!.year.toString().padLeft(4, '0')}-${birthDateDb!.month.toString().padLeft(2, '0')}-${birthDateDb!.day.toString().padLeft(2, '0')}",
        "birthDate": birthDate,
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
      };
}
