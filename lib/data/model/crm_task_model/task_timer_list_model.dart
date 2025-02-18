
import 'dart:convert';

TaskTimerListModel taskTimerListModelFromJson(String str) => TaskTimerListModel.fromJson(json.decode(str));


class TaskTimerListModel {
  bool? result;
  String? message;
  Data? data;

  TaskTimerListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskTimerListModel.fromJson(Map<String, dynamic> json) => TaskTimerListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? currentPage;
  List<TaskTimer>? data;
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
    data: json["data"] == null ? [] : List<TaskTimer>.from(json["data"]!.map((x) => TaskTimer.fromJson(x))),
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

class TaskTimer {
  int? id;
  int? companyId;
  int? branchId;
  int? taskId;
  int? memberId;
  dynamic projectId;
  int? userId;
  int? showToCustomer;
  String? description;
  dynamic tags;
  DateTime? startTime;
  DateTime? endTime;
  String? duration;
  DateTime? createdAt;
  DateTime? updatedAt;
  Task? task;
  User? user;

  TaskTimer({
    this.id,
    this.companyId,
    this.branchId,
    this.taskId,
    this.memberId,
    this.projectId,
    this.userId,
    this.showToCustomer,
    this.description,
    this.tags,
    this.startTime,
    this.endTime,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.task,
    this.user,
  });

  factory TaskTimer.fromJson(Map<String, dynamic> json) => TaskTimer(
    id: json["id"],
    companyId: json["company_id"],
    branchId: json["branch_id"],
    taskId: json["task_id"],
    memberId: json["member_id"],
    projectId: json["project_id"],
    userId: json["user_id"],
    showToCustomer: json["show_to_customer"],
    description: json["description"],
    tags: json["tags"],
    startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
    duration: json["duration"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class Task {
  int? id;
  String? name;

  Task({
    this.id,
    this.name,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class User {
  int? id;
  String? name;
  int? avatarId;

  User({
    this.id,
    this.name,
    this.avatarId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    avatarId: json["avatar_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar_id": avatarId,
  };
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
