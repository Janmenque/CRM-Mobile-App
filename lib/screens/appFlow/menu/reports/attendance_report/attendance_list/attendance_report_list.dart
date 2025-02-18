import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_list/attedance_report_list_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class AttendanceReportList extends StatelessWidget {
  const AttendanceReportList({Key? key, this.endpoint, this.date})
      : super(key: key);
  final String? endpoint;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AttendanceReportListProvider(endpoint!, date!),
      child: Consumer<AttendanceReportListProvider>(
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
                tr('attendance_report_list'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.appBarColor),
              ),
            ),
            body: ListView.separated(
              itemCount:
                  provider.attendanceListResponse?.data?.users?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final data =
                    provider.attendanceListResponse?.data?.users?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 60,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.name ?? '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                           Text(tr('project_manager'),
                              style: const TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            "10:00 AM",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("06:00 PM",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          );
        },
      ),
    );
  }
}
