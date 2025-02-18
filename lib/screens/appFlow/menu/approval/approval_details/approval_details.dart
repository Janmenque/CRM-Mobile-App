import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/approval_details/approval_details_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/app_const.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import '../leave_approval_summary/leave_approval_summary.dart';

class ApprovalDetails extends StatelessWidget {
  final int? approvalID;
  final int? userId;

  const ApprovalDetails({Key? key, this.approvalID, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApprovalDetailsProvider(approvalID, userId),
      child: Consumer<ApprovalDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                tr("request_details"),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.appBarColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                         SizedBox(width: 130, child: Text(tr("status"))),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(int.parse(
                                  provider.approvalDetails?.data?.colorCode ??
                                      "0xFF000000")),
                              // color: Color(int.parse("0xFF000000")),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Color(int.parse(
                                provider.approvalDetails?.data?.colorCode ??
                                    "0xFF000000")),
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
                              provider.approvalDetails?.data?.status ?? '',
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
                  buildContainer(
                      title: tr("name"),
                      titleValue: provider.approvalDetails?.data?.name ?? ""),
                  buildContainer(
                      title: tr("id"),
                      titleValue:
                          "${provider.approvalDetails?.data?.id ?? ""}"),
                  buildContainer(
                      title: tr("designation"),
                      titleValue:
                          provider.approvalDetails?.data?.designation ?? ""),
                  buildContainer(
                      title: tr("department"),
                      titleValue:
                          provider.approvalDetails?.data?.department ?? ""),
                  buildContainer(
                      title: tr("period"),
                      titleValue: provider.approvalDetails?.data?.period ?? ""),
                  buildContainer(
                      title: tr("type"),
                      titleValue: provider.approvalDetails?.data?.type ?? ""),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                         SizedBox(width: 130, child: Text(tr("balance"))),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                provider.approvalDetails?.data?.totalUsed
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                              ),
                              const Text(
                                " / ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                                maxLines: 1,
                              ),
                              Text(
                                provider.approvalDetails?.data?.availableLeave
                                        .toString() ??
                                    "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                              ),
                               Text(
                                " ${tr("days")}",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                                maxLines: 1,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                      context, LeaveApprovalSummary(userId: provider.approvalDetails?.data?.userId));
                                },
                                child: Row(
                                  children:  [
                                    const Icon(
                                      Icons.insert_drive_file_rounded,
                                      color: AppColors.colorPrimary,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      tr("leave_history"),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: AppColors.colorPrimary,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  buildContainer(
                      title: tr("balance"),
                      titleValue: provider.approvalDetails?.data?.availableLeave
                              .toString() ??
                          ""),
                  buildContainer(
                      title: tr("requested_on"),
                      titleValue:
                          provider.approvalDetails?.data?.requestedOn ?? ""),
                  buildContainer(
                      title: tr("note"),
                      titleValue: provider.approvalDetails?.data?.note ?? ""),
                  buildContainer(
                      title: tr("approves"),
                      titleValue:
                          provider.approvalDetails?.data?.apporover ?? ""),
                  buildContainer(
                      title: tr("substitute"),
                      titleValue:
                          provider.approvalDetails?.data?.substitute?.name),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
                    child: Text(tr("leave_reason"),style: const TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 0),
                    child: Text(provider.approvalDetails?.data?.note ?? "",textAlign: TextAlign.justify),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            floatingActionButton: Visibility(
              visible: provider.isVisibility,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 55,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Card(
                            color: AppColors.colorPrimary,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                provider.approvalOrReject(
                                    provider.approvalDetails?.data?.id,
                                    AppConst.approve,
                                    context);
                              },
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                    child: Text(
                                     tr("approve"),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                provider.approvalOrReject(
                                    provider.approvalDetails?.data?.id,
                                    AppConst.reject,
                                    context);
                              },
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                    child: Text(
                                      tr("reject"),
                                      style: const TextStyle(
                                          color: AppColors.colorPrimary,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
