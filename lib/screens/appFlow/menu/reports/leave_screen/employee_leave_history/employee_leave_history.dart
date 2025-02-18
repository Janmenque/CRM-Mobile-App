import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/approval/leave_summary_details/leave_summary_details.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/employee_leave_history/employee_leave_history_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EmployeeLeaveHistory extends StatelessWidget {
  const EmployeeLeaveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmployeeLeaveHistoryProvider(),
      child: Consumer<EmployeeLeaveHistoryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(title: Text(tr('employee_leave_history'))),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    provider.getEmployeeData(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // radius of 10
                          color: Colors.grey[100] // green as background color
                          ),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(tr("Search")),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    child: ListTile(
                      title: Text(provider.officialInfo?.data?.name ?? ""),
                      subtitle:
                          Text(provider.officialInfo?.data?.designation ?? ""),
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          imageUrl: "${provider.officialInfo?.data?.avatar}",
                          placeholder: (context, url) => Center(
                            child: Image.asset(
                                "assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                               Text(
                                tr('total_leaves'),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.responseLeaveSummary?.data?.totalLeave
                                    .toString() ?? "0",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4358BE),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                tr("leaves_used"),
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.responseLeaveSummary?.data?.totalUsed
                                    .toString() ??
                                "0",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Visibility(
                  visible: provider.responseLeaveSummary?.data?.availableLeave?.isNotEmpty ?? false,
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.responseLeaveSummary?.data?.availableLeave?.length?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 100,
                                        showLabels: false,
                                        showTicks: false,
                                        startAngle: 270,
                                        endAngle: 270,
                                        axisLineStyle: const AxisLineStyle(
                                          thickness: 0.1,
                                          color: Color(0xFFE8E8E9),
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                              value: provider
                                                      .responseLeaveSummary
                                                      ?.data
                                                      ?.availableLeave?[index]
                                                      .leftDays
                                                      ?.toDouble() ??
                                                  0,
                                              width: 0.1,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              color: const Color(0xFF4358BE),
                                              cornerStyle:
                                                  CornerStyle.bothCurve),
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                            widget: Text(
                                                provider
                                                        .responseLeaveSummary
                                                        ?.data
                                                        ?.availableLeave?[index]
                                                        .leftDays
                                                        .toString() ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF414F5D))),
                                            positionFactor: 0,
                                            axisValue: 70,
                                          )
                                        ])
                                  ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    provider.responseLeaveSummary?.data
                                            ?.availableLeave?[index].type
                                            .toString() ??
                                        "",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                ///current date picker
                currentDate(provider, context),
                provider.isLoading == true ?
                provider.leaveTypeList!.data!.availableLeave!.isNotEmpty
                    ? Column(
                  children: provider
                      .leaveTypeList!.data!.availableLeave!
                      .map((leave) => Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          NavUtil.navigateScreen(
                              context,
                              LeaveSummaryDetails(
                                  leaveRequestDetailsId:
                                  leave.id,userId: provider.userObj?.id
                              ));
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment:
                                      WrapCrossAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "${leave.type} ${tr('leave')}: ",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w500),
                                        ),
                                        Text(
                                          '${leave.days} ${tr('days')}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .black,
                                              fontWeight:
                                              FontWeight
                                                  .w700),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${leave.applyDate}",
                                      style:
                                      const TextStyle(
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(int.parse(
                                        leave.colorCode ??
                                            "")),
                                    style:
                                    BorderStyle.solid,
                                    width: 3.0,
                                  ),
                                  color: Color(int.parse(
                                      leave.colorCode ??
                                          "")),
                                  borderRadius:
                                  BorderRadius.circular(
                                      8.0),
                                ),
                                child: DottedBorder(
                                  color: Colors.white,
                                  borderType:
                                  BorderType.RRect,
                                  radius:
                                  const Radius.circular(
                                      5),
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 10,
                                      vertical: 3),
                                  strokeWidth: 1,
                                  child: Center(
                                    child: Text(
                                      '${leave.status}',
                                      style: const TextStyle(
                                          color:
                                          Colors.white,
                                          fontSize: 10,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  ))
                      .toList(),
                )
                    : Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('no_leaves_history_found'),
                              style: const TextStyle(
                                  color: Color(0x65555555),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ): const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  InkWell currentDate(EmployeeLeaveHistoryProvider provider, BuildContext context) {
    return InkWell(
      onTap: () {
        provider.selectDate(context);
      },
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 30,
                color: AppColors.colorPrimary,
              )),
          const Spacer(),
          Center(
              child: Text(
                provider.monthYear ?? "",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          const Spacer(),
          IconButton(
              onPressed: () {
                provider.selectDate(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.angleRight,
                size: 30,
                color: AppColors.colorPrimary,
              )),
        ],
      ),
    );
  }
}
