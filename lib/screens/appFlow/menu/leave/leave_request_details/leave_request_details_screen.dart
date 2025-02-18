import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/request_leave_update/request_leave_update_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'leave_request_details_provider.dart';

class LeaveRequestDetails extends StatelessWidget {
  final int? leaveRequestDetailsId;

  const LeaveRequestDetails({Key? key, this.leaveRequestDetailsId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? leaveId =
        ModalRoute.of(context)?.settings.arguments as String?;
    return ChangeNotifierProvider(
      create: (context) =>
          LeaveRequestDetailsProvider(leaveId ?? leaveRequestDetailsId),
      child: Consumer<LeaveRequestDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                tr("leave_details"),
                style: const TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
              ),
              actions: [
                Visibility(
                  visible: provider.isButtonShow ?? false,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      NavUtil.navigateScreen(
                          context,
                          RequestLeaveUpdate(
                              requestId: provider.leaveDetails?.data?.id));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
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
                                    style: BorderStyle.solid,
                                    width: 3.0,
                                  ),
                                  color: Color(int.parse(
                                      provider.leaveDetails?.data?.colorCode ??
                                          "")),
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
                                  ).tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildContainer(
                            title: tr("requested_on"),
                            titleValue:
                                '${provider.leaveDetails?.data?.requestedOn}'),
                        buildContainer(
                            title: tr("type"),
                            titleValue: '${provider.leaveDetails?.data?.type}'),
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
                            children: [
                              SizedBox(
                                  width: 130, child: Text(tr("attachment"))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.network(
                                provider.leaveDetails?.data?.attachment ??
                                    "assets/images/placeholder_image.png"),
                          ),
                        ),
                        Visibility(
                          visible: provider.isButtonShow ?? false,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await provider.cancelRequest(
                                      provider.leaveDetails?.data?.id, context);
                                },
                                child: Text(tr("cancel_request")),
                              ),
                            ),
                          ),
                        )
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
