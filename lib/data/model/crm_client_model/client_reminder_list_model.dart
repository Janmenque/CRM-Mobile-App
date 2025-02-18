import 'dart:convert';

ClientReminderListModel clientReminderListModelFromJson(String str) => ClientReminderListModel.fromJson(json.decode(str));


class ClientReminderListModel {
  bool? result;
  String? message;
  Data? data;

  ClientReminderListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientReminderListModel.fromJson(Map<String, dynamic> json) => ClientReminderListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ClientReminderData>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ClientReminderData>.from(json["data"]!.map((x) => ClientReminderData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientReminderData {
  int? id;
  String? date;
  String? description;
  DateTime? createdAt;
  ReminderClient? client;

  ClientReminderData({
    this.id,
    this.date,
    this.description,
    this.createdAt,
    this.client,
  });

  factory ClientReminderData.fromJson(Map<String, dynamic> json) => ClientReminderData(
    id: json["id"],
    date: json["date"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    client: json["client"] == null ? null : ReminderClient.fromJson(json["client"]),
  );
}

class ReminderClient {
  int? id;
  String? name;

  ReminderClient({
    this.id,
    this.name,
  });

  factory ReminderClient.fromJson(Map<String, dynamic> json) => ReminderClient(
    id: json["id"],
    name: json["name"],
  );
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

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
