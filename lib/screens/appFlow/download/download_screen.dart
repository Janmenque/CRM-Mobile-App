import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/download/popup_menu.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/provider/downloads_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/model/downloads.dart';

class DownloaderScreen extends StatefulWidget with WidgetsBindingObserver {

  final TargetPlatform platform;
  static const routeName = "/downloader";
  final Downloads? downloads;

  DownloaderScreen({Key? key, this.downloads, required this.platform}) : super(key: key);

  @override
  State<DownloaderScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DownloaderScreen> {
  late DownloadsProvider downloadsModel;
  final TextEditingController inputController = TextEditingController();
  bool showClear = false;
  String filter = '';

  @override
  void initState() {
    Provider.of<DownloadsProvider>(context, listen: false).initDownloads(widget.platform, widget.downloads);
    inputController.addListener(() {
      setState(() {
        filter = inputController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    downloadsModel = Provider.of<DownloadsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          maxLines: 1,
          controller: inputController,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          keyboardType: TextInputType.text,
          onSubmitted: (query) {
          },
       
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Downloads',
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          showClear
              ? IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              inputController.clear();
              showClear = false;
              downloadsModel.cancelSearch();
            },
          )
              : Container(),
        ],
      ),
      body: BuildBodyPage(downloadsModel: downloadsModel, filter: filter),
    );
  }
}

class BuildBodyPage extends StatelessWidget {
  const BuildBodyPage({
    Key? key,
    required this.downloadsModel,
    required this.filter,
  }) : super(key: key);

  final DownloadsProvider downloadsModel;
  final String filter;

  @override
  Widget build(BuildContext context) {
    if (downloadsModel.isLoading) {
      return const Center(
        child:  CircularProgressIndicator(),
      );
    }
    if (!downloadsModel.permissionReady) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Please grant accessing storage permission to continue',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            TextButton(
                onPressed: () {
                  downloadsModel.requestPermission();
                },
                child: const Text(
                  'Retry',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ))
          ],
        ),
      );
    }
    if (downloadsModel.permissionReady && downloadsModel.downloadsList.isEmpty) {
      return const Center(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('No Items To Display',
                textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
        ),
      );
    }
    return ListView.builder(
        itemCount: downloadsModel.downloadsList.length,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(3.0),
        itemBuilder: (BuildContext context, int index) {
          return filter == ""
              ? ItemTile(
              index: index,
              download: downloadsModel.downloadsList[index],
              downloadsModel: downloadsModel)
              : downloadsModel.downloadsList[index].title
          !.toLowerCase()
              .contains(filter.toLowerCase())
              ? ItemTile(
              index: index,
              download: downloadsModel.downloadsList[index],
              downloadsModel: downloadsModel)
              : const SizedBox.shrink();
        });
  }
}

class ItemTile extends StatefulWidget {
  final Downloads download;
  final int index;
  final DownloadsProvider downloadsModel;

  const ItemTile({
    Key? key,
    required this.index,
    required this.download,
    required this.downloadsModel,
  })  : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  100.0,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: CachedNetworkImage(
                        imageUrl: widget.download.attachment ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                    Colors.black12, BlendMode.darken)),
                          ),
                        ),
                        placeholder: (context, url) =>
                        const Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.grey,
                            )),
                      ),
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.download.title ?? '',
                        maxLines: 1,),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: DownloadPopupMenu(
                    widget.download,
                    isDownloads: true,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 0,
          ),
          widget.download.status == DownloadTaskStatus.running ||
              widget.download.status == DownloadTaskStatus.paused
              ? LinearProgressIndicator(value: (widget.download.progress??0) / 100,)
              : Container(),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildActionForTask(Downloads task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          widget.downloadsModel.requestDownload(task);
        },
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
        child: const Icon(Icons.file_download),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          widget.downloadsModel.pauseDownload(task);
        },
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
        child: const Icon(
          Icons.pause,
          color: Colors.red,
        ),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          widget.downloadsModel.resumeDownload(task);
        },
        shape: const CircleBorder(),
        constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
        child: const Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children:  [
          Text(
            'Ready',
            style: TextStyle(color: Colors.green),
          ),
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return const Text('Canceled', style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Failed', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              widget.downloadsModel.retryDownload(task);
            },
            shape: const CircleBorder(),
            constraints: const BoxConstraints(minHeight: 32.0, minWidth: 32.0),
            child: const Icon(
              Icons.refresh,
              color: Colors.green,
            ),
          )
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}