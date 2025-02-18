import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hrm_app/data/model/downloads.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'dart:isolate';
import '../../../../../data/database/sqflite_database_provider.dart';

class DownloadsProvider with ChangeNotifier {
  List<Downloads> downloadsList = [];
  List<Downloads> tmpDownloadsList = [];
  bool isLoading = true;
  bool permissionReady = false;
  String? localPath;
  final ReceivePort _port = ReceivePort();
  TargetPlatform? platform;
  bool shouldRequestDownload = false;
  bool isLoaded = false;

  DownloadsProvider() {
    getDownloads();
    _bindBackgroundIsolate();
  }

  searchDownloads(String query) {
    tmpDownloadsList.addAll(downloadsList);
    downloadsList.clear();
    for (var p in tmpDownloadsList) {
      if (p.title!.contains(query)) {
        downloadsList.add(p);
      }
    }
    notifyListeners();
  }

  cancelSearch() {
    downloadsList.addAll(tmpDownloadsList);
    tmpDownloadsList.clear();
    notifyListeners();
  }


  initDownloads(TargetPlatform platform, Downloads? downloads) async {
    this.platform = platform;
    await setLocalPath();

    if (isMediaInDownloads(downloads?.id ?? 0)?.id == null) {
      shouldRequestDownload = true;
      downloads?.attachment = downloads.attachment;
      String extension = p.extension(downloads?.attachment ?? '');
      downloads?.streamAttachment = "$localPath/${downloads.title}";
      if(downloads != null) {
        await saveDownloadMedia(downloads);
        downloadsList.insert(0, downloads);
      }
    } else {
      shouldRequestDownload = false;
    }
    await getDownloads();
    FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
    isLoading = true;
    permissionReady = false;
    await _prepare();
  }

  getDownloads() async {
    downloadsList = await SQLiteDbProvider.db.getAllDownloads();
    notifyListeners();
  }

  ///save media data to local file
  saveDownloadMedia(Downloads media) async {
    await SQLiteDbProvider.db.addNewDownloadItem(media);
  }

  removeDownloadedMedia(BuildContext context, int id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('delete file'),
              content: const Text('Do you wish to delete this downloaded file? This action cannot be undone.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: const Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    SQLiteDbProvider.db.deleteDownloadMedia(id);
                    getDownloads();
                    final downloads = isMediaInDownloads(id);
                    if(downloads != null) {
                      delete(downloads);
                    }
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: const Text('cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Downloads? isMediaInDownloads(int id) {
    final itm = downloadsList.where((itm) => itm.id == id).toList();
    return itm.isNotEmpty ? itm.first : null;
  }

  void requestDownload(Downloads task) async {
    debugPrint("task.downloadUrl = ${task.attachment}");
    String extension = p.extension(task.attachment ?? '');
    debugPrint("_extension =$extension");
    task.taskId = await FlutterDownloader.enqueue(
        url: task.attachment ?? '',
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: localPath ?? '',
        showNotification: true,
        requiresStorageNotLow: true,
        fileName: '${task.title}',
        openFileFromNotification: false);

    final itm = downloadsList.firstWhere((itm) => itm.taskId == task.taskId);
    downloadsList[downloadsList.indexOf(itm)].taskId = task.taskId;
  }

  void pauseDownload(Downloads task) async {
    await FlutterDownloader.pause(taskId: '${task.taskId}');
  }

  void resumeDownload(Downloads task) async {
    String? newTaskId = await FlutterDownloader.resume(taskId: '${task.taskId}');
    task.taskId = newTaskId;
  }

  void retryDownload(Downloads task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: '${task.taskId}');
    task.taskId = newTaskId;
  }

  void delete(Downloads task) async {
    await FlutterDownloader.remove(
        taskId: '${task.taskId}', shouldDeleteContent: true);
    await _prepare();
  }

  Future<bool> checkPermission() async {
    if (platform == TargetPlatform.android) {
      return await Permission.storage.request().isGranted;
    }
    return false;
  }

  requestPermission() async {
    permissionReady = await Permission.storage.request().isGranted;
    notifyListeners();
  }

  setLocalPath() async {
    localPath = '${await _findLocalPath()}${Platform.pathSeparator}Download';
    final savedDir = Directory(localPath ?? '');
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    debugPrint("localPath = $localPath");
    List contents = savedDir.listSync();
    for (var fileOrDir in contents) {
      if (fileOrDir is File) {
        debugPrint(fileOrDir.absolute.path);
      } else if (fileOrDir is Directory) {
        debugPrint(fileOrDir.path);
      }
    }
  }

  Future<bool> _prepare() async {
    permissionReady = await checkPermission();
    isLoading = false;
    notifyListeners();
    await loadTasks();
    return true;
  }

  Future<bool> loadTasks() async {
    final tasks = await FlutterDownloader.loadTasks();
    tasks?.forEach((task) {
      for (Downloads info in downloadsList) {
        if (info.attachment == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    });
    notifyListeners();
    if (shouldRequestDownload && permissionReady) {
      requestDownload(downloadsList[0]);
    }
    return true;
  }

  Future<String> _findLocalPath() async {
    final directory = platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory?.path ?? '';
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      debugPrint('UI Isolate Callback: $data');
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (downloadsList.isNotEmpty) {
        debugPrint("current task downloadsList id = ${downloadsList[0].taskId}");
        debugPrint("current task id = $id");
        final task = downloadsList.firstWhere((task) => task.taskId == id);
        task.status = status;
        task.progress = progress;
        notifyListeners();
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    debugPrint('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }
}
