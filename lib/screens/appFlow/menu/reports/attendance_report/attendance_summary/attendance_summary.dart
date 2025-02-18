import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_report_details/attendance_report_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_search/attendance_search_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_summary/attendance_sumery_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceSummeryProvider(),
      child: Consumer<AttendanceSummeryProvider>(
        builder: (BuildContext context, provider, _) {
          final data = provider.attendanceResponse?.data?.attendanceSummary;
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
                  tr('reports_summary'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBarColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      currentDate(provider, context),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        provider.attendanceResponse?.data?.date ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: buildTile(
                                data: data,
                                onPressed: () => NavUtil.navigateScreen(
                                  context,
                                  AttendanceReportDetails(
                                    endpoint: 'on_time_in',
                                    date: provider.monthYear,
                                  ),
                                ),
                                title: tr('on_time'),
                                ovalColor: Colors.blue,
                                value: data?.onTimeIn,
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'late_in',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: 'Late',
                              ovalColor: Colors.red,
                              value: data?.lateIn,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'left_timely',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: tr('left_timely'),
                              ovalColor: Colors.green,
                              value: data?.leftTimely,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'left_early',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: tr('left_early'),
                              ovalColor: Colors.red,
                              value: data?.leftEarly,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'leave',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: tr('on_leave'),
                              ovalColor: Colors.grey.shade400,
                              value: data?.leave,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'absent',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: tr('absent'),
                              ovalColor: Colors.black87,
                              value: data?.absent,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            buildTile(
                              data: data,
                              onPressed: () => NavUtil.navigateScreen(
                                context,
                                AttendanceReportDetails(
                                  endpoint: 'left_later',
                                  date: provider.monthYear,
                                ),
                              ),
                              title: tr('left_later'),
                              ovalColor: Colors.amber,
                              value: data?.leftLater,
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 4,
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            NavUtil.navigateScreen(
                                context, const AttendanceSearchScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  tr('search_all_attendance_report'),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  InkWell buildTile(
      {data,
      required Color ovalColor,
      required String title,
      String? value,
      required Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: ovalColor),
              child: const SizedBox(),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(title),
            const Spacer(),
            Text(value ?? '')
          ],
        ),
      ),
    );
  }

  InkWell currentDate(AttendanceSummeryProvider provider, context) {
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
