import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/natification/notification_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotificationProvider(),
      child: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.white,
                title: Text(tr("notifications"),style: const TextStyle(fontSize: 16),),
                actions: [
                  Visibility(
                    visible: provider.notificationsList?.isNotEmpty ?? false,
                    child: InkWell(
                      onTap: () {
                        provider.clearNotificationApi();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              tr("clear_all"),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                  child: Column(
                children: [
                  provider.isLoading
                      ? provider.notificationsList!.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                itemCount:
                                    provider.notificationsList?.length ?? 0,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  height: 1,
                                  color: AppColors.backgroundColor,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final data =
                                      provider.notificationsList?[index];
                                  return provider.notificationsList!.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            provider.getReadNotification(
                                                provider
                                                    .notificationsList?[index]
                                                    .id);
                                            provider.getRoutSlag(
                                                context,
                                                provider
                                                    .notificationsList?[index]
                                                    .slag);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: data?.isRead == true
                                                    ? Colors.white
                                                    : const Color(0xD7E5F3FE),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                             
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipOval(
                                                    child: CachedNetworkImage(
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                      imageUrl: data?.image ??
                                                          "assets/images/placeholder_image.png",
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child: Image.asset(
                                                            "assets/images/placeholder_image.png"),
                                                      ),
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          Image.asset(
                                                              "assets/images/placeholder_image.png"),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Wrap(
                                                        children: [
                                                          Text(
                                                            "${data?.title} ",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text("${data?.body}"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${data?.date} ",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                'https://i.pinimg.com/originals/f3/36/64/f3366437556b621bc1b69248bf5a08c4.png',
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                tr("no_notification_found"),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        );
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                  child: Text(
                                tr("no_notification_found"),
                                style: const TextStyle(
                                    color: Color(0x65555555),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              )),
                            )
                      : const SizedBox(),
                ],
              )));
        },
      ),
    );
  }
}
