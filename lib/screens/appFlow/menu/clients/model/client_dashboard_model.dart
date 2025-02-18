import 'dart:convert';

ClientDashboardModel clientDashboardModelFromJson(String str) => ClientDashboardModel.fromJson(json.decode(str));

String clientDashboardModelToJson(ClientDashboardModel data) => json.encode(data.toJson());

class ClientDashboardModel {
    ClientDashboardModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory ClientDashboardModel.fromJson(Map<String, dynamic> json) => ClientDashboardModel(
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
        this.clients,
    });

    List<Staticstic>? staticstics;
    List<Client>? clients;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        staticstics: List<Staticstic>.from(json["staticstics"].map((x) => Staticstic.fromJson(x))),
        clients: List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "staticstics": List<dynamic>.from(staticstics!.map((x) => x.toJson())),
        "clients": List<dynamic>.from(clients!.map((x) => x.toJson())),
    };
}

class Client {
    Client({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.avater,
    });

    int? id;
    String? name;
    String? email;
    String? phone;
    String? avater;

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        avater: json["avater"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "avater": avater,
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
