import 'dart:convert';
import 'dart:ui';
import '../client_details/common/common.dart';

ClientDetailsModel clientDetailsModelFromJson(String str) => ClientDetailsModel.fromJson(json.decode(str));

class ClientDetailsModel {
    ClientDetailsModel({
        this.result,
        this.message,
        this.data,
    });

    bool ?result;
    String? message;
    Data? data;

    factory ClientDetailsModel.fromJson(Map<String, dynamic> json) => ClientDetailsModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

}

class Data {
    Data({this.client});

    Client? client;

    factory Data.fromJson(Map<String, dynamic> json) => Data(client: Client.fromJson(json["client"]));
}

class Client {
    Client({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.description,
        this.avater,
        this.projectStatistics,
        this.projects,
    });

    int? id;
    String? name;
    String ?email;
    String? phone;
    String ?address;
    dynamic description;
    String ?avater;
    List<ProjectStatistic>? projectStatistics;
    List<Project>? projects = [];

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        description: json["description"],
        avater: json["avater"],
        projectStatistics: List<ProjectStatistic>.from(json["project_statistics"].map((x) => ProjectStatistic.fromJson(x))),
        projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
    );

    
}

class ProjectStatistic {
    ProjectStatistic({
        this.title,
        this.statusId,
        this.count,
    });

    String? title;
    int? statusId;
    int? count;

    factory ProjectStatistic.fromJson(Map<String, dynamic> json) => ProjectStatistic(
        title: json["title"],
        statusId: json["status_id"],
        count: json["count"],
    );

  
}

class Project {
    Project({
        this.id,
        this.name,
        this.status,
        this.statusId,
        this.date,
        this.avatar,
        this.clickable,
        this.endPoint,
        this.color,
    });

    int ?id;
    String? name;
    String?status;
    int? statusId;
    String? date;
    String? avatar;
    bool ?clickable;
    String? endPoint;
    String ?color;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        statusId: json["status_id"],
        date: json["date"],
        avatar: json["avatar"],
        clickable: json["clickable"],
        endPoint: json["end_point"],
        color: json["color"],
    );

    Color get getColor => getPursedColor(int.parse(color ?? '0xffF2994A'));

}
