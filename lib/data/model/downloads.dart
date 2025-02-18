import 'package:flutter_downloader/flutter_downloader.dart';
import '../../screens/appFlow/menu/clients/model/project_details_model.dart';

class Downloads {
  int? id;
  String? taskId;
  String? attachment;
  String? streamAttachment;
  final String? logo;
  final String? title;
  final String? createdBy;
  int? progress;
  final String? timeStamp;

  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  Downloads({
    this.id,
    this.title,
    this.timeStamp,
    this.attachment,
    this.streamAttachment,
    this.logo,
    this.createdBy,
    this.progress
  });

  static const String downloadsTable = "downloads";

  static final downloadsColumns = [
    "id",
    "title",
    "logo",
    "streamAttachment",
    "attachment",
    "createdBy",
    "timeStamp",
    "progress"
  ];

  factory Downloads.fromMap(Map<String, dynamic> data) {
    return Downloads(
      id: data['id'],
      title: data['title'],
      timeStamp: data['timeStamp'],
      attachment: data['attachment'],
      streamAttachment: data['streamAttachment'],
      logo: data['logo'],
      createdBy: data['createdBy'],
      progress: data['progress'],
    );
  }

  static Downloads mapCurrentFileToDownload(Files files) {
    return Downloads(
      id: files.id,
      title: files.title,
      timeStamp: DateTime.now().microsecondsSinceEpoch.toString(),
      attachment: files.attachment,
      streamAttachment: files.attachment,
      logo: files.logo,
      createdBy: files.createdBy,
      progress: 0
    );
  }

  static Files mapMediaFromDownload(Downloads media) {
    return Files(
        id: media.id,
        title: media.title,
        attachment: media.attachment,
        logo: media.logo,
        createdBy: media.createdBy
    );
  }

  static List<Files> mapMediaListFromDownloadList(List<Downloads> downloadsList) {
    List<Files> mediaList = [];
    for (var media in downloadsList) {
      mediaList.add(Files(
          id: media.id,
          title: media.title,
          attachment: media.attachment,
          logo: media.logo,
          createdBy: media.createdBy
      ));
    }
    return mediaList;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "attachment": attachment,
        "streamAttachment": streamAttachment,
        "logo": logo,
        "createdBy": createdBy,
        "timeStamp": timeStamp,
      };
}
