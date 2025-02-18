import 'dart:convert';

ProjectOverviewDetailsModel projectOverviewDetailsModelFromJson(String str) => ProjectOverviewDetailsModel.fromJson(json.decode(str));


class ProjectOverviewDetailsModel {
  bool? result;
  String? message;
  ProjectOverviewDetails? data;

  ProjectOverviewDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectOverviewDetailsModel.fromJson(Map<String, dynamic> json) => ProjectOverviewDetailsModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : ProjectOverviewDetails.fromJson(json["data"]),
  );

}

class ProjectOverviewDetails {
  int? id;
  String? name;
  String? dateRange;
  String? startDate;
  String? endDate;
  String? createdAt;
  int? progress;
  String? billingType;
  int? perRate;
  int? totalRate;
  int? estimatedHour;
  int? amount;
  int? paid;
  int? due;
  String? description;
  String? avatarId;
  int? usersCount;
  int? actualCount;
  Status? status;
  Status? priorityStatus;
  Status? paymentStatus;
  Client? client;
  List<Member>? members;
  List<Task>? tasks;
  List<Feedback>? feedback;
  List<dynamic>? files;
  String? goal;
  Client? createdBy;
  String? taskRight;
  dynamic progressRight;
  String? progressRightWithStatus;
  String? daysLeft;
  int? daysLeftProgress;
  String? daysLeftProgressWithStatus;
  String? totalExpenses;
  String? billedExpenses;
  String? unbilledExpenses;

  ProjectOverviewDetails({
    this.id,
    this.name,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.progress,
    this.billingType,
    this.perRate,
    this.totalRate,
    this.estimatedHour,
    this.amount,
    this.paid,
    this.due,
    this.description,
    this.avatarId,
    this.usersCount,
    this.actualCount,
    this.status,
    this.priorityStatus,
    this.paymentStatus,
    this.client,
    this.members,
    this.tasks,
    this.feedback,
    this.files,
    this.goal,
    this.createdBy,
    this.taskRight,
    this.progressRight,
    this.progressRightWithStatus,
    this.daysLeft,
    this.daysLeftProgress,
    this.daysLeftProgressWithStatus,
    this.totalExpenses,
    this.billedExpenses,
    this.unbilledExpenses,
  });

  factory ProjectOverviewDetails.fromJson(Map<String, dynamic> json) => ProjectOverviewDetails(
    id: json["id"],
    name: json["name"],
    dateRange: json["date_range"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    createdAt: json["created_at"],
    progress: json["progress"],
    billingType: json["billing_type"],
    perRate: json["per_rate"],
    totalRate: json["total_rate"],
    estimatedHour: json["estimated_hour"],
    amount: json["amount"],
    paid: json["paid"],
    due: json["due"],
    description: json["description"],
    avatarId: json["avatar_id"],
    usersCount: json["users_count"],
    actualCount: json["actual_count"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    priorityStatus: json["priority_status"] == null ? null : Status.fromJson(json["priority_status"]),
    paymentStatus: json["payment_status"] == null ? null : Status.fromJson(json["payment_status"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    feedback: json["feedback"] == null ? [] : List<Feedback>.from(json["feedback"]!.map((x) => Feedback.fromJson(x))),
    files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
    goal: json["goal"],
    createdBy: json["created_by"] == null ? null : Client.fromJson(json["created_by"]),
    taskRight: json["task_right"],
    progressRight: json["progress_right"],
    progressRightWithStatus: json["progress_right_with_status"],
    daysLeft: json["days_left"],
    daysLeftProgress: json["days_left_progress"],
    daysLeftProgressWithStatus: json["days_left_progress_with_status"],
    totalExpenses: json["total_expenses"],
    billedExpenses: json["billed_expenses"],
    unbilledExpenses: json["unbilled_expenses"],
  );

}

class Client {
  int? id;
  String? name;
  String? avatar;

  Client({
    this.id,
    this.name,
    this.avatar,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}

class Feedback {
  int? id;
  String? name;
  bool? isCompleted;
  String? date;
  int? discussionsCount;
  int? filesCount;
  List<Member>? members;
  List<dynamic>? discussions;
  List<dynamic>? files;

  Feedback({
    this.id,
    this.name,
    this.isCompleted,
    this.date,
    this.discussionsCount,
    this.filesCount,
    this.members,
    this.discussions,
    this.files,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    name: json["name"],
    isCompleted: json["is_completed"],
    date: json["date"],
    discussionsCount: json["discussions_count"],
    filesCount: json["files_count"],
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    discussions: json["discussions"] == null ? [] : List<dynamic>.from(json["discussions"]!.map((x) => x)),
    files: json["files"] == null ? [] : List<dynamic>.from(json["files"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_completed": isCompleted,
    "date": date,
    "discussions_count": discussionsCount,
    "files_count": filesCount,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    "discussions": discussions == null ? [] : List<dynamic>.from(discussions!.map((x) => x)),
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
  };
}

class Member {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? avatar;

  Member({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? colorCode;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.colorCode,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    colorCode: json["color_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": statusClass,
    "color_code": colorCode,
  };
}

class Task {
  int? id;
  String? name;
  bool? isCompleted;
  String? date;
  List<Member>? members;
  int? discussions;
  int? files;

  Task({
    this.id,
    this.name,
    this.isCompleted,
    this.date,
    this.members,
    this.discussions,
    this.files,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    name: json["name"],
    isCompleted: json["is_completed"],
    date: json["date"],
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    discussions: json["discussions"],
    files: json["files"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_completed": isCompleted,
    "date": date,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    "discussions": discussions,
    "files": files,
  };
}
