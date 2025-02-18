import 'dart:convert';

CreateTaskModel createTaskModelFromJson(String str) => CreateTaskModel.fromJson(json.decode(str));

class CreateTaskModel {
    CreateTaskModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory CreateTaskModel.fromJson(Map<String, dynamic> json) => CreateTaskModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );
}

class Data {
    Data({
        this.clients,
        this.projects,
        this.createTaskMembers,
        this.priorities,
    });

    List<Client>? clients;
    List<Project>? projects;
     List<CreateTaskMembers>? createTaskMembers;
    List<Priority>? priorities;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clients: List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
        projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
        createTaskMembers: List<CreateTaskMembers>.from(json["members"].map((x) => CreateTaskMembers.fromJson(x))),
        priorities: List<Priority>.from(json["priorities"].map((x) => Priority.fromJson(x))),
    );


}

class Client {
    Client({
        this.id,
        this.name,
        this.avatar,
    });

    int? id;
    String? name;
    String? avatar;

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
class CreateTaskMembers {
    CreateTaskMembers({
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

    factory CreateTaskMembers.fromJson(Map<String, dynamic> json) => CreateTaskMembers(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        designation: json["designation"],
        department: json["department"],
        avatar: json["avatar"],
    );

}

class Priority {
    Priority({
        this.title,
        this.id,
    });

    String? title;
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

class Project {
    Project({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
