
import 'dart:convert';

CrmHomeModel crmHomeModelFromJson(String str) => CrmHomeModel.fromJson(json.decode(str));

class CrmHomeModel {
  CrmHomeModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  CrmHomeModelData? data;

  factory CrmHomeModel.fromJson(Map<String, dynamic> json) => CrmHomeModel(
        result: json["result"],
        message: json["message"],
        data: CrmHomeModelData.fromJson(json["data"]),
      );
}

class CrmHomeModelData {
  CrmHomeModelData({
    this.projectSummary,
    this.staticstics,
    this.tasks,
    this.projects,
    this.notices,
    this.supports,
    this.calendar,
    this.projectCount,
    this.clientCount,
    this.taskCount,

  });

  Notices? projectSummary;
  Staticstics? staticstics;
  Notices? tasks;
  List<HomeProject>? projects;
  Notices? notices;
  Notices? supports;
  Calendar? calendar;
  Count? projectCount;
  Count? clientCount;
  Count? taskCount;

  factory CrmHomeModelData.fromJson(Map<String, dynamic> json) =>
      CrmHomeModelData(
        projectSummary: Notices.fromJson(json["project_summary"]),
        staticstics: Staticstics.fromJson(json["staticstics"]),
        tasks: Notices.fromJson(json["tasks"]),
        projects: List<HomeProject>.from(
            json["projects"].map((x) => HomeProject.fromJson(x))),
        notices: Notices.fromJson(json["notices"]),
        supports: Notices.fromJson(json["supports"]),
        calendar: Calendar.fromJson(json["calendar"]),
        projectCount: Count.fromJson(json["project_count"]),
        clientCount: Count.fromJson(json["client_count"]),
        taskCount: Count.fromJson(json["task_count"]),
      );
}

class Calendar {
  Calendar({
    this.slug,
    this.label,
    this.data,
  });

  String? slug;
  String? label;
  CalendarData? data;

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        slug: json["slug"],
        label: json["label"],
        data: CalendarData.fromJson(json["data"]),
      );
}

class CalendarData {
  CalendarData({
    this.currentMonth,
    this.selectedDate,
  });

  String? currentMonth;
  String? selectedDate;

  factory CalendarData.fromJson(Map<String, dynamic> json) => CalendarData(
        currentMonth: json["current_month"],
        selectedDate: json["selected_date"],
      );

  Map<String, dynamic> toJson() => {
        "current_month": currentMonth,
        "selected_date": selectedDate,
      };
}

class Count {
  String? name;
  int? count;

  Count({
    this.name,
    this.count,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    name: json["name"],
    count: json["count"],
  );
}

class Notices {
  Notices({
    this.slug,
    this.label,
    this.title,
    this.data,
    this.endPoint,
  });

  String? slug;
  String? label;
  String? title;
  List<Datum>? data;
  String? endPoint;

  factory Notices.fromJson(Map<String, dynamic> json) => Notices(
        slug: json["slug"],
        label: json["label"],
        title: json["title"] == null ? null : json["title"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        endPoint: json["end_point"] == null ? null : json["end_point"],
      );
}

class Datum {
  Datum({
    this.name,
    this.slug,
    this.position,
    this.icon,
    this.number,
    this.text,
    this.endPoint,
    this.buttonText,
    this.color,
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.isCreator,
    this.usersCount,
    this.members,
  });

  String? name;
  String? slug;
  int? position;
  String? icon;
  int? number;
  String? text;
  String? endPoint;
  String? buttonText;
  dynamic color;
  int? id;
  String? title;
  String? dateRange;
  String? startDate;
  String? endDate;
  bool? isCreator;
  int? usersCount;
  List<Members>? members;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"] ?? "",
        slug: json["slug"] == null ? null : json["slug"] ?? "",
        position: json["position"] == null ? null : json["position"] ?? "",
        icon: json["icon"] == null ? null : json["icon"] ?? "",
        number: json["number"] == null ? null : json["number"] ?? "",
        text: json["text"] == null ? null : json["text"] ?? "",
        endPoint: json["end_point"] == null ? null : json["end_point"] ?? "",
        buttonText: json["button_text"] == null ? null : json["button_text"] ?? "",
        color: [json["color"]],
        id: json["id"] == null ? null : json["id"] ?? "",
        title: json["title"] == null ? null : json["title"] ?? "",
        dateRange: json["date_range"] == null ? null : json["date_range"] ?? "",
        startDate: json["start_date"] == null ? null : json["start_date"] ?? "",
        endDate: json["end_date"] == null ? null : json["end_date"] ?? "",
        isCreator: json["is_creator"] == null ? null : json["is_creator"] ?? "",
        usersCount: json["users_count"] == null ? null : json["users_count"] ?? '',
        members: json["members"] == null
            ? null
            : List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
      );
}

class Members {
  Members({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,

  });

  int? id;
  String? name;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? avatar;

  factory Members.fromJson(Map<String, dynamic> json) => Members(
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
    "email":email,
          "avatar": avatar,
          "designation": designation,
          "department": department
      };
}

class HomeProject {
  HomeProject({
    this.id,
    this.title,
    this.dateRange,
    this.userCount,
    this.members,
    this.progress,
    this.color,
    this.status,
    this.priority,
    this.priorityColor,
    this.clickable,
    this.endPoint,
  });

  int? id;
  String? title;
  String? dateRange;
  int? userCount;
  List<Members>? members;
  int? progress;
  String? color;
  String? status;
  String? priority;
  String? priorityColor;
  bool? clickable;
  String? endPoint;

  factory HomeProject.fromJson(Map<String, dynamic> json) => HomeProject(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        userCount: json["user_count"],
        members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
        progress: json["progress"],
        color: json["color"],
        status: json["status"],
        priority: json["priority"],
        priorityColor: json["priority_color"],
        clickable: json["clickable"],
        endPoint: json["end_point"],
      );
}

class Staticstics {
  Staticstics({
    this.slug,
    this.label,
    this.data,
  });

  String? slug;
  String? label;
  StaticsticsData? data;

  factory Staticstics.fromJson(Map<String, dynamic> json) => Staticstics(
        slug: json["slug"],
        label: json["label"],
        data: StaticsticsData.fromJson(json["data"]),
      );
}

class StaticsticsData {
  StaticsticsData({
    this.completeTasks,
    this.incompleteTasks,
  });

  List<CompleteTask>? completeTasks;
  List<IncompleteTask>? incompleteTasks;

  factory StaticsticsData.fromJson(Map<String, dynamic> json) =>
      StaticsticsData(
        completeTasks: List<CompleteTask>.from(
            json["complete_tasks"].map((x) => CompleteTask.fromJson(x))),
        incompleteTasks: List<IncompleteTask>.from(
            json["incomplete_tasks"].map((x) => IncompleteTask.fromJson(x))),
      );
}

class CompleteTask {
  CompleteTask({
    this.date,
    this.complete,
  });

  int? date;
  int? complete;

  factory CompleteTask.fromJson(Map<String, dynamic> json) => CompleteTask(
        date: json["date"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "complete": complete,
      };
}

class IncompleteTask {
  IncompleteTask({
    this.date,
    this.incomplete,
  });

  int? date;
  int? incomplete;

  factory IncompleteTask.fromJson(Map<String, dynamic> json) => IncompleteTask(
        date: json["date"],
        incomplete: json["incomplete"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "incomplete": incomplete,
      };
}
