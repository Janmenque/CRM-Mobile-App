
import 'dart:convert';

import 'package:hrm_app/data/model/home/crm_home_model.dart';

ProjectListModel projectListModelFromJson(String str) => ProjectListModel.fromJson(json.decode(str));

class ProjectListModel {
    ProjectListModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    ProjectListModelData? data;

    factory ProjectListModel.fromJson(Map<String, dynamic> json) => ProjectListModel(
        result: json["result"],
        message: json["message"],
        data: ProjectListModelData.fromJson(json["data"]),
 );

}

class ProjectListModelData {
    ProjectListModelData({
        this.slug,
        this.label,
        this.priorities,
        this.data,
    });

    String ?slug;
    String ?label;
    List<Priority>? priorities;
    DataData? data;

    factory ProjectListModelData.fromJson(Map<String, dynamic> json) => ProjectListModelData(
        slug: json["slug"],
        label: json["label"],
        priorities: List<Priority>.from(json["priorities"].map((x) => Priority.fromJson(x))),
        data: DataData.fromJson(json["data"]),
    );

   
}

class DataData {
    DataData({
        this.projects,
        this.pagination,
    });

    List<Project>? projects;
    Pagination ?pagination;

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    
}

class Pagination {
    Pagination({
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
    });

    int ?total;
    int? count;
    int ?perPage;
    int? currentPage;
    int ?totalPages;

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

class Project {
    Project({
        this.id,
        this.title,
        this.dateRange,
        this.userCount,
        this.actualCount,
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
    String ?title;
    String? dateRange;
    int? userCount;
    int? actualCount;
    List<Members>? members;
    int? progress;
    String? color;
    String? status;
    String? priority;
    String? priorityColor;
    bool? clickable;
    String? endPoint;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        userCount: json["users_count"],
        actualCount: json["actual_count"],
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


class Priority {
    Priority({
        this.title,
        this.id,
    });

    String ?title;
    int? id;

    factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        title: json["title"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
    };
}
