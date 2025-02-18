
import 'dart:convert';

DealListModel dealListModelFromJson(String str) => DealListModel.fromJson(json.decode(str));


class DealListModel {
    DealListModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String ?message;
    Data? data;

    factory DealListModel.fromJson(Map<String, dynamic> json) => DealListModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

}

class Data {
    Data({
        this.projects,
        this.pagination,
    });

    List<Project> ?projects;
    Pagination ?pagination;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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

    int? total;
    int? count;
    int? perPage;
    int? currentPage;
    int? totalPages;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
    );

}

class Project {
    Project({
        this.id,
        this.title,
        this.date,
        this.color,
        this.status,
        this.avatar,
        this.clickable,
        this.endPoint,
    });

    int? id;
    String? title;
    String? date;
    String? color;
    String? status;
    String? avatar;
    bool? clickable;
    String ?endPoint;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        color: json["color"],
        status: json["status"],
        avatar: json["avatar"],
        clickable: json["clickable"],
        endPoint: json["end_point"],
    );

}
