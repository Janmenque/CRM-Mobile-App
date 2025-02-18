
import 'dart:convert';

IncomeDashboardModel incomeDashboardModelFromJson(String str) => IncomeDashboardModel.fromJson(json.decode(str));

String incomeDashboardModelToJson(IncomeDashboardModel data) => json.encode(data.toJson());

class IncomeDashboardModel {
    IncomeDashboardModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory IncomeDashboardModel.fromJson(Map<String, dynamic> json) => IncomeDashboardModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.staticstics,
    });

    List<Staticstic>? staticstics;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        staticstics: List<Staticstic>.from(json["staticstics"].map((x) => Staticstic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "staticstics": List<dynamic>.from(staticstics!.map((x) => x.toJson())),
    };
}

class Staticstic {
    Staticstic({
        this.count,
        this.text,
        this.image,
    });

    String? count;
    String? text;
    String? image;

    factory Staticstic.fromJson(Map<String, dynamic> json) => Staticstic(
        count: json["count"],
        text: json["text"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "text": text,
        "image": image,
    };
}
