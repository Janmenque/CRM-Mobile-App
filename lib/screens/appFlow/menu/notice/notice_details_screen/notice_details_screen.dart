import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_details_screen/notice_details_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class NoticeDetailsScreen extends StatelessWidget {
  final int? noticeId;

  const NoticeDetailsScreen({Key? key, this.noticeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoticeDetailsProvider(noticeId),
      child: Consumer<NoticeDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              title: Text(
                tr("notice_details"),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.noticeDetails?.data?.subject ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          provider.noticeDetails?.data?.date ?? "",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          provider.noticeDetails?.data?.description ?? "",
                          style: const TextStyle(fontSize: 14,height: 1.4),
                          textAlign: TextAlign.justify,

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                         "Attachments",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.noticeDetails?.data?.attachments?.length ?? 0,
                              itemBuilder: (BuildContext context, int index){
                                return  Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CachedNetworkImage(
                                    height: 200,
                                    width : 150,
                                    fit: BoxFit.cover,
                                    imageUrl: provider.noticeDetails?.data?.attachments?[index].attachmentId ?? "",
                                    placeholder: (context, url) => Center(
                                      child: Image.asset(
                                          "assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset("assets/images/placeholder_image.png"),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
