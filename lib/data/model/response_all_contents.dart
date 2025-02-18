import 'dart:convert';

ResponseAllContents responseAllContentsFromJson(String str) =>
    ResponseAllContents.fromJson(json.decode(str));

String responseAllContentsToJson(ResponseAllContents data) =>
    json.encode(data.toJson());

class ResponseAllContents {
  ResponseAllContents({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseAllContents.fromJson(Map<String, dynamic> json) =>
      ResponseAllContents(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.contents,
  });

  List<Content>? contents;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    contents:  json["contents"] != null ? List<Content>.from(json["contents"].map((x) => Content.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {"contents": List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.id,
    this.companyId,
    this.userId,
    this.type,
    this.title,
    this.slug,
    this.content,
    this.metaTitle,
    this.metaDescription,
    this.keywords,
    this.metaImage,
  });

  int? id;
  int? companyId;
  int? userId;
  String? type;
  String? title;
  String? slug;
  String? content;
  String? metaTitle;
  dynamic metaDescription;
  String? keywords;
  String? metaImage;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        type: json["type"],
        title: json["title"],
        slug: json["slug"],
        content: json["content"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        keywords: json["keywords"],
        metaImage: json["meta_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "type": type,
        "title": title,
        "slug": slug,
        "content": content,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "keywords": keywords,
        "meta_image": metaImage,
      };
}
