import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/approval_details/approval_details.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/approval_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApprovalProvider(),
      child: Consumer<ApprovalProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  tr("approval"),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBarColor),
                ),
              ),
              body: Column(
                children: [
                  provider.isLoading == true
                      ? provider.approvalList!.data!.leaveRequests!.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: provider.approvalList?.data
                                          ?.leaveRequests?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            NavUtil.navigateScreen(
                                                context,
                                                ApprovalDetails(
                                                  approvalID: provider
                                                      .approvalList
                                                      ?.data
                                                      ?.leaveRequests?[index]
                                                      .id,
                                                  userId: provider
                                                      .approvalList
                                                      ?.data
                                                      ?.leaveRequests?[index]
                                                      .userId,
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 5),
                                            child: Card(
                                              elevation: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${provider.approvalList?.data?.leaveRequests?[index].name} ${tr("requested_for")} ${provider.approvalList?.data?.leaveRequests?[index].dateDuration} ${provider.approvalList?.data?.leaveRequests?[index].type}",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          provider
                                                                  .approvalList
                                                                  ?.data
                                                                  ?.leaveRequests?[
                                                                      index]
                                                                  .applyDate ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: Color(int.parse(provider
                                                                      .approvalList
                                                                      ?.data
                                                                      ?.leaveRequests?[
                                                                          index]
                                                                      .colorCode ??
                                                                  "")),
                                                              style: BorderStyle
                                                                  .solid,
                                                              width: 3.0,
                                                            ),
                                                            color: Color(int.parse(provider
                                                                    .approvalList
                                                                    ?.data
                                                                    ?.leaveRequests?[
                                                                        index]
                                                                    .colorCode ??
                                                                "")),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: DottedBorder(
                                                            color: Colors.white,
                                                            borderType:
                                                                BorderType
                                                                    .RRect,
                                                            radius: const Radius
                                                                .circular(5),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        3),
                                                            strokeWidth: 1,
                                                            child: Text(
                                                              provider
                                                                      .approvalList
                                                                      ?.data
                                                                      ?.leaveRequests?[
                                                                          index]
                                                                      .status ??
                                                                  "",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            )
                          : Expanded(
                              child: Column(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/images/placeholder_image.png',
                                  image:
                                      'https://i.pinimg.com/originals/75/4f/ef/754fef5ccbae781570e74e57a85d2720.jpg',
                                  width: double.infinity,
                                ),
                                 Text(
                                  tr("no_request_for_approval_yet"),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    tr("requests_that_need_your_approval_will_appear_here"),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ))
                      : const SizedBox()
                ],
              ));
        },
      ),
    );
  }
}
