
import 'dart:convert';

NewProjectTaskListModel newProjectTaskListModelFromJson(String str) => NewProjectTaskListModel.fromJson(json.decode(str));


class NewProjectTaskListModel {
  List<NewProjectTask>? items;
  Pagination? pagination;

  NewProjectTaskListModel({
    this.items,
    this.pagination,
  });

  factory NewProjectTaskListModel.fromJson(Map<String, dynamic> json) => NewProjectTaskListModel(
    items: json["items"] == null ? [] : List<NewProjectTask>.from(json["items"]!.map((x) => NewProjectTask.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class NewProjectTask {
  int? id;
  String? taskNumber;
  String? name;
  String? date;
  String? startDate;
  String? endDate;
  String? priority;
  String? status;
  List<Assignee>? assignee;
  List<String>? tags;

  NewProjectTask({
    this.id,
    this.taskNumber,
    this.name,
    this.date,
    this.startDate,
    this.endDate,
    this.priority,
    this.status,
    this.assignee,
    this.tags,
  });

  factory NewProjectTask.fromJson(Map<String, dynamic> json) => NewProjectTask(
    id: json["id"],
    taskNumber: json["task_number"],
    name: json["name"],
    date: json["date"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    priority: json["priority"],
    status: json["status"],
    assignee: json["assignee"] == null ? [] : List<Assignee>.from(json["assignee"]!.map((x) => Assignee.fromJson(x))),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
  );
}

class Assignee {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? avatar;

  Assignee({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    designation: json["designation"],
    department: json["department"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "designation": designation,
    "department": department,
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
