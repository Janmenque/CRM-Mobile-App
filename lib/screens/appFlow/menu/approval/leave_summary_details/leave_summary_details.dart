import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/leave_summary_details/leave_summary_details_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LeaveSummaryDetails extends StatelessWidget {
  final int? leaveRequestDetailsId;
  final int? userId;

  const LeaveSummaryDetails({Key? key, this.leaveRequestDetailsId, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          LeaveSummaryDetailsProvider(leaveRequestDetailsId, userId),
      child: Consumer<LeaveSummaryDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                tr("leave_details"),
                style: const TextStyle(color: AppColors.appBarColor),
              ),
            ),
            body: provider.leaveDetails != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 26,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 130, child: Text(tr("status"))),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(int.parse(provider
                                            .leaveDetails?.data?.colorCode ??
                                        "")),
                                    // color: Color(int.parse("0xFF000000")),
                                    style: BorderStyle.solid,
                                    width: 3.0,
                                  ),
                                  color: Color(int.parse(
                                      provider.leaveDetails?.data?.colorCode ??
                                          "")),
                                  // color: Color(int.parse("0xFF000000")),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DottedBorder(
                                  color: Colors.white,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  strokeWidth: 1,
                                  child: Text(
                                    '${provider.leaveDetails?.data?.status}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///Feb 8 at 10:05 AM
                        buildContainer(
                            title: tr("requested_on"),
                            titleValue:
                                '${provider.leaveDetails?.data?.requestedOn}'),
                        buildContainer(
                            title: tr("type"),
                            titleValue: '${provider.leaveDetails?.data?.type}'),

                        ///Feb 9 Feb 12
                        buildContainer(
                            title: tr("period"),
                            titleValue:
                                '${provider.leaveDetails?.data?.period}'),
                        buildContainer(
                            title: tr("total_days"),
                            titleValue:
                                '${provider.leaveDetails?.data?.totalDays} ${tr("days")}'),
                        buildContainer(
                          title: tr("note"),
                          titleValue: '${provider.leaveDetails?.data?.note}',
                        ),
                        buildContainer(
                          title: tr("substitute"),
                          titleValue:
                              provider.leaveDetails?.data?.substitute?.name ??
                                  tr("add_substitute"),
                        ),
                        buildContainer(
                          title: tr("approves"),
                          titleValue: provider.leaveDetails?.data?.apporover,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              SizedBox(width: 130, child: Text(tr("attachment"))),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.network(
                                '${provider.leaveDetails?.data?.attachment}'),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
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
