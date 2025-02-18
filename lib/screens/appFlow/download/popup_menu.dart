import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hrm_app/data/model/downloads.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/provider/downloads_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadPopupMenu extends StatelessWidget {
  const DownloadPopupMenu(this.download, {super.key, this.isDownloads});

  final Downloads? download;
  final bool? isDownloads;

  @override
  Widget build(BuildContext context) {
    DownloadsProvider downloadsModel = Provider.of<DownloadsProvider>(context);

    return PopupMenuButton(
      elevation: 3.2,
      itemBuilder: (BuildContext context) {
        List<String> choices = [];
        if (isDownloads != null && downloadsModel.isMediaInDownloads(download?.id ?? 0)?.status == DownloadTaskStatus.complete) {
          choices.add('delete file');
        }
        choices.add('share');
        return choices.map((itm) {
          return PopupMenuItem(
            value: itm,
            child: Text(itm),
          );
        }).toList();
      },
      //initialValue: 2,
      onCanceled: () {
        debugPrint("You have canceled the menu.");
      },
      onSelected: (value) {
        debugPrint(value.toString());
        if (value == 'delete file') {
          downloadsModel.removeDownloadedMedia(context, download?.id ?? 0);
        }
        if (value == 'share') {
          if (download != null) {
            ShareFile.share(download!);
          }
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.grey[500],
      ),
    );
  }

}

class ShareFile {
  static share(Downloads download) async {
    await Share.share(
      'Watch or Listen to ${download.title} Via CRM App, Download now ${download.attachment}',
      subject: 'Watch or Listen to ${download.title}',
    );
  }
}
