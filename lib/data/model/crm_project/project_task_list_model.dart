
import 'dart:convert';

ProjectTaskListModel projectTaskListModelFromJson(String str) => ProjectTaskListModel.fromJson(json.decode(str));


class ProjectTaskListModel {
  bool? result;
  String? message;
  Data? data;

  ProjectTaskListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectTaskListModel.fromJson(Map<String, dynamic> json) => ProjectTaskListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ProjectTask>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ProjectTask>.from(json["data"]!.map((x) => ProjectTask.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ProjectTask {
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
  dynamic tags;
  CreatedBy? createdBy;
  Status? priorityStatus;
  Status? status;

  ProjectTask({
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

  factory ProjectTask.fromJson(Map<String, dynamic> json) => ProjectTask(
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
    tags: json["tags"],
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": statusClass,
    "translated_name": translatedName,
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
