import 'dart:convert';

ClientListModel clientListModelFromJson(String str) =>
    ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) =>
    json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
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
    this.clients,
    this.pagination,
  });

  List<Client>? clients;
  Pagination? pagination;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clients:
            List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "clients": List<dynamic>.from(clients!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
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

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
