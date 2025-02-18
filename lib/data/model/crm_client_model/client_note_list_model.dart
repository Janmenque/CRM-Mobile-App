import 'dart:convert';

ClientNoteListModel clientNoteListModelFromJson(String str) => ClientNoteListModel.fromJson(json.decode(str));


class ClientNoteListModel {
  bool? result;
  String? message;
  Data? data;

  ClientNoteListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientNoteListModel.fromJson(Map<String, dynamic> json) => ClientNoteListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ClientNote>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ClientNote>.from(json["data"]!.map((x) => ClientNote.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientNote {
  int? id;
  String? description;
  DateTime? createdAt;
  CreatedBy? createdBy;

  ClientNote({
    this.id,
    this.description,
    this.createdAt,
    this.createdBy,
  });

  factory ClientNote.fromJson(Map<String, dynamic> json) => ClientNote(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
  );
}

class CreatedBy {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  CreatedBy({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "avatar": avatar,
  };
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
