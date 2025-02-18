import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_request_details/leave_request_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_summary/leave_summary_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LeaveSummary extends StatefulWidget {
  const LeaveSummary({Key? key}) : super(key: key);

  @override
  State<LeaveSummary> createState() => _LeaveSummaryState();
}

class _LeaveSummaryState extends State<LeaveSummary>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool gestureUp = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        animationBehavior: AnimationBehavior.normal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeaveSummaryProvider(controller, context),
      child: Consumer<LeaveSummaryProvider>(
        builder: (context, provider, _) {
          return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                elevation: 0,
                title:  Text(
                  'leave_summary',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black, fontSize: 16.sp),
                ).tr(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: GestureDetector(
                        behavior: HitTestBehavior.deferToChild,
                        onVerticalDragCancel: () {
                          controller.reset();
                        },
                        onHorizontalDragCancel: () {
                          controller.reset();
                        },
                        onTapDown: (_) {
                          controller.forward();
                        },
                        onTapUp: (_) {
                          if (controller.status == AnimationStatus.forward) {
                            controller.reverse();
                            controller.value;
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 175,
                              width: 175,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            Container(
                              height: 185,
                              width: 185,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: const Offset(0, 3),
                                    )
                                  ]),
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                value: controller.value,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColors.colorPrimary),
                              ),
                            ),
                            ClipOval(
                              child: Material(
                                  child: Container(
                                height: 170,
                                width: 170,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.colorPrimary,
                                        Color(0xFF00CCFF)
                                      ],
                                      begin: FractionalOffset(1.0, 0.0),
                                      end: FractionalOffset(0.0, 3.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Image.asset(
                                          "assets/images/tap_figer.png",
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: const Text(
                                          "apply_leave",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ).tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: const Text(
                        "tab_to_apply_for_leave",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ).tr(),
                    ),
                    const SizedBox(
                      height: 25,
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
                                  const Text(
                                    "total_leaves",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ).tr()
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                provider.responseLeaveSummary?.data?.totalLeave
                                        .toString() ??
                                    "",
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
                                      color: AppColors.colorPrimary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "leaves_used",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ).tr()
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                provider.responseLeaveSummary?.data?.totalUsed
                                        .toString() ??
                                    "",
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
                      visible: provider.responseLeaveSummary?.data
                              ?.availableLeave?.isNotEmpty ??
                          false,
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.responseLeaveSummary?.data
                                    ?.availableLeave?.length ??
                                0,
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
                                              thicknessUnit:
                                                  GaugeSizeUnit.factor,
                                            ),
                                            pointers: <GaugePointer>[
                                              RangePointer(
                                                  value: provider
                                                          .responseLeaveSummary
                                                          ?.data
                                                          ?.availableLeave?[
                                                              index]
                                                          .leftDays
                                                          ?.toDouble() ??
                                                      0,
                                                  width: 0.1,
                                                  sizeUnit:
                                                      GaugeSizeUnit.factor,
                                                  color: AppColors.colorPrimary,
                                                  cornerStyle:
                                                      CornerStyle.bothCurve),
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                widget: Text(
                                                    provider
                                                            .responseLeaveSummary
                                                            ?.data
                                                            ?.availableLeave?[
                                                                index]
                                                            .leftDays
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF414F5D))),
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
                    const SizedBox(
                      height: 20,
                    ),

                    ///current date picker
                    currentDate(provider, context),
                    provider.isLoading == true
                        ? provider
                                .leaveTypeList!.data!.availableLeave!.isNotEmpty
                            ? Column(
                                children: provider
                                    .leaveTypeList!.data!.availableLeave!
                                    .map((leave) => Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                NavUtil.navigateScreen(
                                                    context,
                                                    LeaveRequestDetails(
                                                      leaveRequestDetailsId:
                                                          leave.id,
                                                    ));
                                              },
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                                                child: Container(
                                                  decoration:  BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 16.0,
                                                            vertical: 16),
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
                                                                    "${leave.type} ${tr('leave_type')} ",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ).tr(),
                                                                  Text(
                                                                    '${leave.days} ${tr('days')}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700),
                                                                  ).tr(),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                "${leave.applyDate}",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            10),
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
                                                                BorderRadius
                                                                    .circular(8.0),
                                                          ),
                                                          child: DottedBorder(
                                                            color: Colors.white,
                                                            borderType:
                                                                BorderType.RRect,
                                                            radius: const Radius
                                                                .circular(5),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal: 10,
                                                                    vertical: 3),
                                                            strokeWidth: 1,
                                                            child: Center(
                                                              child: Text(
                                                                '${leave.status}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ).tr(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  const Text(
                                    "no_leaves_history_found",
                                    style: TextStyle(
                                        color: Color(0x65555555),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ).tr(),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ))
                        : const SizedBox(),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  InkWell currentDate(LeaveSummaryProvider provider, BuildContext context) {
    return InkWell(
      onTap: () {
        provider.selectDate(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10)
          ),
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
        ),
      ),
    );
  }
}