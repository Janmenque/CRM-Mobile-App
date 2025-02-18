import 'dart:convert';
import '../../../../../data/model/home/crm_home_model.dart';

TaskDetailsModel taskDetailsModelFromJson(String str) =>
    TaskDetailsModel.fromJson(json.decode(str));

class TaskDetailsModel {
  TaskDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) =>
      TaskDetailsModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    required this.clients,
    required this.projects,
    required this.taskDetailsMembers,
    required this.priorities,
    this.taskDetails,
  });

  List<ClientDetails> clients = [];
  List<ProjectDetails> projects = [];
  List<TaskDetailsMembers> taskDetailsMembers = [];
  List<PriorityDetails> priorities = [];
  TaskDetails? taskDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        clients: List<ClientDetails>.from(
            json["clients"].map((x) => ClientDetails.fromJson(x))),
        projects: List<ProjectDetails>.from(
            json["projects"].map((x) => ProjectDetails.fromJson(x))),
        taskDetailsMembers: List<TaskDetailsMembers>.from(
            json["members"].map((x) => TaskDetailsMembers.fromJson(x))),
        priorities: List<PriorityDetails>.from(
            json["priorities"].map((x) => PriorityDetails.fromJson(x))),
        taskDetails: TaskDetails.fromJson(json["task_details"]),
      );
}

class ClientDetails {
  ClientDetails({
    this.id,
    this.name,
    this.avatar,
  });

  int? id;
  String? name;
  String? avatar;

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );
}

class PriorityDetails {
  PriorityDetails({
    this.title,
    this.id,
  });

  String? title;
  int? id;

  factory PriorityDetails.fromJson(Map<String, dynamic> json) =>
      PriorityDetails(
        title: json["title"],
        id: json["id"],
      );
}

class ProjectDetails {
  ProjectDetails({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"],
        name: json["name"],
      );
}

class TaskDetails {
  TaskDetails({
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.dbEndDate,
    this.dbStartDate,
    this.date,
    this.supervisor,
    this.usersCount,
    this.discussionsCount,
    this.filesCount,
    this.progress,
    this.projectId,
    this.project,
    this.clientId,
    this.client,
    this.isCompleted,
    this.priorityId,
    this.priority,
    this.color,
    this.description,
    this.files,
    this.discussion,
    this.members,
    this.status
  });

  int? id;
  String? title;
  String? dateRange;
  String? startDate;
  String? endDate;
  String? dbStartDate;
  String? dbEndDate;
  String? date;
  String? supervisor;
  int? usersCount;
  int? discussionsCount;
  int? filesCount;
  int? progress;
  int? projectId;
  String? project;
  int? clientId;
  String? client;
  bool? isCompleted;
  int? priorityId;
  String? priority;
  String? color;
  String? description;
  String? status;
  List<Members>? members;
  List<FileElement>? files;
  List<Discussion>? discussion;

  factory TaskDetails.fromJson(Map<String, dynamic> json) => TaskDetails(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        dbEndDate: json["db_end_date"],
        dbStartDate: json["db_start_date"],
        date: json["date"],
        supervisor: json["supervisor"],
        usersCount: json["users_count"],
        discussionsCount: json["discussions_count"],
        filesCount: json["files_count"],
        progress: json["progress"],
        projectId: json["project_id"],
        project: json["project"],
        clientId: json["client_id"],
        client: json["client"],
        isCompleted: json["is_completed"],
        priorityId: json["priority_id"],
        priority: json["priority"],
        color: json["color"],
        status: json["status"],
        members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
        description: json["description"].toString(),
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        discussion: List<Discussion>.from(
            json["discussion"].map((x) => Discussion.fromJson(x))),
      );
}

class Discussion {
  Discussion({
    this.id,
    this.subject,
    this.description,
    this.createdBy,
    this.avatar,
    this.createdAt,
    this.alreadyLiked,
    this.likesCount,
    this.ownCreated,
    this.file,
  });

  int? id;
  String? subject;
  String? description;
  String? createdBy;
  String? avatar;
  String? createdAt;
  bool? alreadyLiked;
  int? likesCount;
  bool? ownCreated;
  String? file;

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        createdBy: json["created_by"],
        avatar: json["avatar"],
        createdAt: json["created_at"],
        alreadyLiked: json["already_liked"],
        likesCount: json["likes_count"],
        ownCreated: json["own_created"],
        file: json["file"],
      );
}

class FileElement {
  FileElement({
    this.id,
    this.attachment,
    this.fileLogo,
    this.title,
    this.type,
    this.createdBy,
  });

  int? id;
  String? attachment;
  String? fileLogo;
  String? title;
  String? type;
  String? createdBy;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        attachment: json["attachment"],
        fileLogo: json["file_logo"],
        title: json["title"],
        type: json["type"],
        createdBy: json["created_by"],
      );
}

class TaskDetailsMembers {
  TaskDetailsMembers(
      {this.id,
      this.name,
      this.avatar,
      this.email,
      this.phone,
      this.designation,
      this.department});

  int? id;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  String? designation;
  String? department;

  factory TaskDetailsMembers.fromJson(Map<String, dynamic> json) =>
      TaskDetailsMembers(
          id: json["id"],
          name: json["name"],
          avatar: json["avatar"],
          email: json["email"],
          phone: json["phone"],
          designation: json["designation"],
          department: json["department"]);
}
