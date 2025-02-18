
import 'dart:convert';

TaskFileListModel taskFileListModelFromJson(String str) => TaskFileListModel.fromJson(json.decode(str));


class TaskFileListModel {
  bool? result;
  String? message;
  Data? data;

  TaskFileListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskFileListModel.fromJson(Map<String, dynamic> json) => TaskFileListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  int? currentPage;
  List<TaskFile>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<TaskFile>.from(json["data"]!.map((x) => TaskFile.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );
}

class TaskFile {
  int? id;
  int? companyId;
  String? subject;
  int? showToCustomer;
  int? taskId;
  int? userId;
  int? attachment;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastActivity;
  int? branchId;
  int? commentsCount;
  List<dynamic>? comments;

  TaskFile({
    this.id,
    this.companyId,
    this.subject,
    this.showToCustomer,
    this.taskId,
    this.userId,
    this.attachment,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.lastActivity,
    this.branchId,
    this.commentsCount,
    this.comments,
  });

  factory TaskFile.fromJson(Map<String, dynamic> json) => TaskFile(
    id: json["id"],
    companyId: json["company_id"],
    subject: json["subject"],
    showToCustomer: json["show_to_customer"],
    taskId: json["task_id"],
    userId: json["user_id"],
    attachment: json["attachment"],
    statusId: json["status_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lastActivity: json["last_activity"] == null ? null : DateTime.parse(json["last_activity"]),
    branchId: json["branch_id"],
    commentsCount: json["comments_count"],
    comments: json["comments"] == null ? [] : List<dynamic>.from(json["comments"]!.map((x) => x)),
  );

}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
