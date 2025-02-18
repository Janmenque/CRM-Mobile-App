import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meeting_details_provider.dart';

class MeetingDetailsScreen extends StatelessWidget {
  final int? meetingId;

  const MeetingDetailsScreen({Key? key, required this.meetingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MeetingDetailsProvider(meetingId),
      child: Consumer<MeetingDetailsProvider>(
        builder: (context, provider, _) {
          final data = provider.meetingDetails?.data;
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("meeting_details")),
            ),
            body: Column(
              children: [
                buildContainer(title: tr("title"), titleValue: data?.title ?? ''),
                buildContainer(title: tr("description"), titleValue: data?.description ?? ''),
                buildContainer(title: tr("date"), titleValue: "${data?.meetingAt?.toLocal() ?? tr("n/a")}".split(' ')[0],),
                buildContainer(title: tr("time"), titleValue: data?.startAt ?? ''),
                buildContainer(title: tr("location"), titleValue: data?.location ?? ''),
                buildContainer(title: tr("start_time"), titleValue: data?.startAt ?? ''),
                buildContainer(title: tr("end_time"), titleValue: data?.endAt ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildContainer(
      {String? title,
      String? titleValue,
      Function()? onPressed,
      bool iconVisibility = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(title ?? '')),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    titleValue ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    maxLines: 1,
                  ),
                ),
                Visibility(
                  visible: iconVisibility,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: onPressed,
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
