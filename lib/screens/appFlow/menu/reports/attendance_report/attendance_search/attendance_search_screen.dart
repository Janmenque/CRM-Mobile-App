import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_search/attendance_search_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AttendanceSearchScreen extends StatelessWidget {
  const AttendanceSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceSearchProvider(),
      child: Consumer<AttendanceSearchProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF00CCFF),
                        AppColors.colorPrimary,
                      ],
                      begin: FractionalOffset(3.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
              title: Text(
                tr('attendance_report'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.appBarColor),
              ),
            ),
            body: ListView(
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
                          color: Colors.grey[100]
                          ),
                      child: const Row(
                        children:  [
                          Icon(Icons.search),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Search"),
                        ],
                      )),
                ),
                InkWell(
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
                            color: Color(0xFF4554BB),
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
                            color: Color(0xFF4554BB),
                          )),
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Text(
                    tr('employee'),
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    child: ListTile(
                      title:
                      Text(provider.officialInfo?.data?.name ?? ""),
                      subtitle: Text(
                          provider.officialInfo?.data?.designation ?? ""),
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                          imageUrl: "${provider.officialInfo?.data?.avatar}",
                          placeholder: (context, url) => Center(
                            child: Image.asset("assets/images/placeholder_image.png"),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 2,
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
                              const Text(
                                "Working Days",
                                style: TextStyle(
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
                              Text(tr('on_time')),
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
                              Text(tr('left_timely')),
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
                              Text(tr('left_early')),
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
                              Text(tr('on_leave')),
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
                              Text(tr('absent')),
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
                              Text(tr('left_later')),
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
                  tr('daily_report'),
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
                        child: const Center(
                            child: Text(
                          "H",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                       Text(
                        tr('check_in_Check_out_from_home'),
                        style: const TextStyle(fontSize: 10, color: Colors.black),
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
                        child: const Center(
                            child: Text(
                          "V",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        tr('check_in_Check_out_from_office'),
                        style: const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25, top: 8, bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.redAccent, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: const Center(
                            child: Text(
                          "R",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                       Text(
                        tr('No_location_found_due_to_phone_poor_gps_receiver'),
                        style: const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ],
                  ),
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
                        tr('reason_for_late_check_in_early_check_out'),
                        style: const TextStyle(fontSize: 10, color: Colors.black),
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
