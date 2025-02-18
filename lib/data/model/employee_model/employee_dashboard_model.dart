
import 'dart:convert';

EmployeeDashboardModel employeeDashboardModelFromJson(String str) => EmployeeDashboardModel.fromJson(json.decode(str));

String employeeDashboardModelToJson(EmployeeDashboardModel data) => json.encode(data.toJson());

class EmployeeDashboardModel {
    EmployeeDashboardModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory EmployeeDashboardModel.fromJson(Map<String, dynamic> json) => EmployeeDashboardModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.staticstics,
        this.employees,
    });

    List<Staticstic>? staticstics;
    List<Employee>? employees;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        staticstics: List<Staticstic>.from(json["staticstics"].map((x) => Staticstic.fromJson(x))),
        employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "staticstics": List<dynamic>.from(staticstics!.map((x) => x.toJson())),
        "employees": List<dynamic>.from(employees!.map((x) => x.toJson())),
    };
}

class Employee {
    Employee({
        this.id,
        this.name,
        this.phone,
        this.designation,
        this.avatar,
    });

    int? id;
    String? name;
    String? phone;
    String? designation;
    String? avatar;

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        designation: json["designation"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "designation": designation,
        "avatar": avatar,
    };
}

class Staticstic {
    Staticstic({
        this.count,
        this.text,
        this.image,
    });

    String? count;
    String? text;
    String? image;

    factory Staticstic.fromJson(Map<String, dynamic> json) => Staticstic(
        count: json["count"],
        text: json["text"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "text": text,
        "image": image,
    };
}
