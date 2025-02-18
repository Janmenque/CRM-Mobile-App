import 'dart:convert';

ProjectDetailsModel projectDetailsModelFromJson(String str) => ProjectDetailsModel.fromJson(json.decode(str));

class ProjectDetailsModel {
  ProjectDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  ProjectDetails? data;

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProjectDetailsModel(
        result: json["result"],
        message: json["message"],
        data: ProjectDetails.fromJson(json["data"]),
      );
}

class ProjectDetails {
  final int? id;
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? dateRange;
  String? dbStartDate;
  String? dbEndDate;
  final String? status;
  final int? progress;
  final int? userCount;
  final int? actualCount;
  final List<ProjectFeedback>? feedbacks;
  final ProjectOwner? client;
  final ProjectOwner? projectOwner;
  final List<ProjectTasks>? tasks;
  final List<ProjectDetailsMembers>? projectDetailsMembers;
  final List<Files>? files;
  final String? timeline;

  ProjectDetails(
      {
        this.id,
        this.name,
        this.description,
        this.startDate,
        this.endDate,
        this.dateRange,
        this.dbStartDate,
        this.dbEndDate,
        this.status,
        this.userCount,
        this.actualCount,
        this.feedbacks,
        this.projectOwner,
        this.client,
        this.tasks,
        this.files,
        this.projectDetailsMembers,
        this.progress,
        this.timeline});

  factory ProjectDetails.fromJson(Map<String, dynamic> json) {
    return ProjectDetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      dateRange: json['date_range'],
      dbStartDate: json["db_start_date"],
      dbEndDate: json["db_end_date"],
      status: json['status'],
      userCount: json['users_count'],
      actualCount: json['actual_count'],
      projectDetailsMembers: List<ProjectDetailsMembers>.from(
          (json['members'] as List).map((e) => ProjectDetailsMembers.fromJson(e))),
      projectOwner: ProjectOwner.fromJson(json['project_owner']),
      client: ProjectOwner.fromJson(json['client']),
      timeline: json['timeline'],
      progress: json['progress'],
      tasks: List<ProjectTasks>.from(
          (json['tasks'] as List).map((e) => ProjectTasks.fromJson(e))),
      feedbacks: List<ProjectFeedback>.from(
          (json['feedback'] as List).map((e) => ProjectFeedback.fromJson(e))),
      files: List<Files>.from(
          (json['files'] as List).map((e) => Files.fromJson(e))),
    );
  }
}

class ProjectDetailsMembers {
  ProjectDetailsMembers({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.department,
    this.designation,

  });

  int ?id;
  String? name;
  String? phone;
  String? email;
  String? avatar;
  String? department;
  String? designation;


  factory ProjectDetailsMembers.fromJson(Map<String, dynamic> json) => ProjectDetailsMembers(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    department: json["department"],
    designation: json["designation"],

  );
}

class ProjectOwner {
  ProjectOwner({
    this.id,
    this.name,
    this.avatar,

  });

  int ?id;
  String? name;
  String? avatar;


  factory ProjectOwner.fromJson(Map<String, dynamic> json) => ProjectOwner(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],

  );

}

class ProjectTasks {
  final int? id;
  final String? name;
  final bool? isCompleted;
  final String? date;
  final List<ProjectDetailsMembers>? projectDetailsMembers;
  final int? discussions;
  final int? files;

  ProjectTasks(
      {this.id,
      this.name,
      this.isCompleted = false,
      this.date,
      this.projectDetailsMembers,
      this.discussions,
      this.files});

  factory ProjectTasks.fromJson(Map<String, dynamic> json) {
    return ProjectTasks(
        id: json['id'],
        name: json['name'],
        isCompleted: json['is_completed'],
        date: json['date'],
        projectDetailsMembers: List<ProjectDetailsMembers>.from(
            (json['members'] as List).map((e) => ProjectDetailsMembers.fromJson(e))),
        discussions: json['discussions'],
        files: json['files']);
  }
}

class ProjectFeedback {
  final int? id;
  final String? name;
  final bool? isCompleted;
  final String? date;
  final List<ProjectDetailsMembers>? projectDetailsMembers;
  final List<Discussion>? discussions;
  final int? discussionCount;
  final int? fileCount;
  final List<Files>? files;

  ProjectFeedback(
      {this.id,
      this.name,
      this.isCompleted = false,
      this.date,
      this.projectDetailsMembers,
      this.discussions,
      this.discussionCount,
      this.fileCount,
      this.files});

  factory ProjectFeedback.fromJson(Map<String, dynamic> json) {
    return ProjectFeedback(
      id: json['id'],
      name: json['name'],
      isCompleted: json['is_completed'],
      date: json['date'],
      discussions: List<Discussion>.from(
          (json['discussions'] as List).map((e) => Discussion.fromJson(e))),
      projectDetailsMembers: List<ProjectDetailsMembers>.from(
          (json['members'] as List).map((e) => ProjectDetailsMembers.fromJson(e))),
      discussionCount: json['discussions_count'],
      fileCount: json['files_count'],
      files: List<Files>.from((json['files'] as List).map((e) => Files.fromJson(e))),
    );
  }
}

class Discussion {
  final int? id;
  final String? subject;
  final String? description;
  final String? createdBy;
  final String? avatar;
  final String? createdAt;
  final bool? liked;
  final int? likeCount;

  Discussion(
      {this.id,
      this.subject,
      this.description,
      this.createdBy,
      this.avatar,
      this.createdAt,
      this.liked,
      this.likeCount});

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
        id: json['id'],
        subject: json['subject'],
        description: json['description'],
        createdBy: json['created_by'],
        avatar: json['avatar'],
        createdAt: json['created_at'],
        liked: json['already_liked'],
        likeCount: json['likes_count']);
  }
}

class Files {
  final int? id;
  final String? attachment;
  final String? logo;
  final String? title;
  final String? createdBy;

  Files({this.id, this.attachment, this.logo, this.title, this.createdBy});

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
        id: json['id'],
        attachment: json['attachment'],
        logo: json['file_logo'],
        title: json['title'],
        createdBy: json['created_by']);
  }
}


