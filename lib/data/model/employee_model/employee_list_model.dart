
import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) => EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) => json.encode(data.toJson());

class EmployeeListModel {
    EmployeeListModel({
        this.result,
        this.message,
        this.data,
    });

    bool? result;
    String? message;
    Data? data;

    factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
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
        this.employees,
        this.pagination,
    });

    List<Employee>? employees;
    Pagination? pagination;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        employees: List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class Employee {
    Employee({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.designation,
        this.avatar,
    });

    int? id;
    String? name;
    String? phone;
    String? email;
    String? designation;
    String? avatar;

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        designation: json["designation"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "designation": designation,
        "avatar": avatar,
    };
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
    int?currentPage;
    int? totalPages;

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
