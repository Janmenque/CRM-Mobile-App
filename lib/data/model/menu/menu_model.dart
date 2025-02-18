
import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
    MenuModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
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
        this.data,
    });

    List<Datum>? data;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.name,
        this.slug,
        this.position,
        this.icon,
        this.lavel,
        this.imageType,
    });

    String? name;
    String? slug;
    int? position;
    String? icon;
    String? lavel;
    String? imageType;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        slug: json["slug"],
        position: json["position"],
        lavel: json['lavel'],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "position": position,
        "lavel": lavel,
        "icon": icon,
    };
}




