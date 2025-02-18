
import 'dart:convert';

ClientFileListModel clientFileListModelFromJson(String str) => ClientFileListModel.fromJson(json.decode(str));


class ClientFileListModel {
  bool? result;
  String? message;
  Data? data;

  ClientFileListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientFileListModel.fromJson(Map<String, dynamic> json) => ClientFileListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ClientFile>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ClientFile>.from(json["data"]!.map((x) => ClientFile.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientFile {
  int? id;
  String? subject;
  int? showToCustomer;
  int? clientId;
  int? commentsCount;
  String? attachment;
  String? lastActivity;
  String? createdAt;
  CreateBy? createBy;
  Status? status;
  List<Comment>? comments;

  ClientFile({
    this.id,
    this.subject,
    this.showToCustomer,
    this.clientId,
    this.commentsCount,
    this.attachment,
    this.lastActivity,
    this.createdAt,
    this.createBy,
    this.status,
    this.comments,
  });

  factory ClientFile.fromJson(Map<String, dynamic> json) => ClientFile(
    id: json["id"],
    subject: json["subject"],
    showToCustomer: json["show_to_customer"],
    clientId: json["client_id"],
    commentsCount: json["comments_count"],
    attachment: json["attachment"],
    lastActivity: json["last_activity"],
    createdAt: json["created_at"],
    createBy: json["create_by"] == null ? null : CreateBy.fromJson(json["create_by"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
  );
}

class Comment {
  int? id;
  dynamic commentId;
  int? companyId;
  String? description;
  int? showToCustomer;
  int? clientFileId;
  int? userId;
  dynamic attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? branchId;
  CommentUser? user;
  List<dynamic>? childComments;

  Comment({
    this.id,
    this.commentId,
    this.companyId,
    this.description,
    this.showToCustomer,
    this.clientFileId,
    this.userId,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.user,
    this.childComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    commentId: json["comment_id"],
    companyId: json["company_id"],
    description: json["description"],
    showToCustomer: json["show_to_customer"],
    clientFileId: json["client_file_id"],
    userId: json["user_id"],
    attachment: json["attachment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    branchId: json["branch_id"],
    user: json["user"] == null ? null : CommentUser.fromJson(json["user"]),
    childComments: json["child_comments"] == null ? [] : List<dynamic>.from(json["child_comments"]!.map((x) => x)),
  );
}

class CommentUser {
  int? id;
  int? avatarId;

  CommentUser({
    this.id,
    this.avatarId,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
    id: json["id"],
    avatarId: json["avatar_id"],
  );
}

class CreateBy {
  int? id;
  String? name;

  CreateBy({
    this.id,
    this.name,
  });

  factory CreateBy.fromJson(Map<String, dynamic> json) => CreateBy(
    id: json["id"],
    name: json["name"],
  );
}

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? translatedName;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    translatedName: json["translated_name"],
  );
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
  );
}
