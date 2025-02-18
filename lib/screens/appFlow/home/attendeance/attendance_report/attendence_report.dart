import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

import 'attendence_report_provider.dart';

class AttendenceReport extends StatelessWidget {
  const AttendenceReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceReportProvider(),
      child: Consumer<AttendanceReportProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
             backgroundColor: AppColors.white,
              title: Text(
                tr("attendance_report"),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    provider.selectDate(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20, bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                tr("working_days"),
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.workingDays ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("on_time")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalOnTimeIn ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("late")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalLateIn ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("left_timely")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalLeftTimely ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("left_early")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalLeftEarly ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[400]),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("on_leave")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalLeave ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black87),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("absent")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.absent ??
                                  "")
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber),
                                child: const SizedBox(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(tr("left_later")),
                              const Spacer(),
                              Text(provider.responseReport?.data
                                      ?.attendanceSummary?.totalLeftLater ??
                                  "")
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  tr("daily_report"),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      provider.responseReport?.data?.dailyReport?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final report =
                        provider.responseReport?.data!.dailyReport![index];
                    return provider.getWidget(report, context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        child: Center(
                            child: Text(
                          tr("h"),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        tr("check_in_check_out_from_home"),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blueAccent),
                        child: Center(
                            child: Text(
                          tr("v"),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        tr("check_in_check_out_from_office"),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23.0, vertical: 0),
                  child: Row(
                    children: [
                      IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.fileLines,
                            size: 15,
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            if (kDebugMode) {
                              print("Pressed");
                            }
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        tr("reason_for_late_check_in_early_check_out"),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
