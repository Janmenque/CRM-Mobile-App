import 'dart:convert';

ClientTaskListModel clientTaskListModelFromJson(String str) => ClientTaskListModel.fromJson(json.decode(str));


class ClientTaskListModel {
  bool? result;
  String? message;
  Data? data;

  ClientTaskListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientTaskListModel.fromJson(Map<String, dynamic> json) => ClientTaskListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ClientTask>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ClientTask>.from(json["data"]!.map((x) => ClientTask.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientTask {
  int? id;
  int? clientId;
  String? name;
  int? hourlyRate;
  DateTime? date;
  int? progress;
  int? priority;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? attachment;
  DateTime? createdAt;
  List<String>? tags;
  CreatedBy? createdBy;
  Status? priorityStatus;
  Status? status;

  ClientTask({
    this.id,
    this.clientId,
    this.name,
    this.hourlyRate,
    this.date,
    this.progress,
    this.priority,
    this.description,
    this.startDate,
    this.endDate,
    this.attachment,
    this.createdAt,
    this.tags,
    this.createdBy,
    this.priorityStatus,
    this.status,
  });

  factory ClientTask.fromJson(Map<String, dynamic> json) => ClientTask(
    id: json["id"],
    clientId: json["client_id"],
    name: json["name"],
    hourlyRate: json["hourly_rate"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    progress: json["progress"],
    priority: json["priority"],
    description: json["description"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    attachment: json["attachment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    priorityStatus: json["priority_status"] == null ? null : Status.fromJson(json["priority_status"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );
}

class CreatedBy {
  int? id;
  String? name;

  CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    name: json["name"],
  );
}

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? translatedName;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    translatedName: json["translated_name"],
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
}
