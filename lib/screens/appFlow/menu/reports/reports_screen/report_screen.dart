import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/attendance_report/attendance_summary/attendance_summary.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_summary/break_report_summary.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/leave_report_summery_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Reports',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.appBarColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: (){
                  NavUtil.navigateScreen(context,const AttendanceSummary());
                },
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children: [
                      Image.asset('assets/menu_report/report_attendance.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(tr('attendance'),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),

            InkWell(
              onTap: (){
                NavUtil.navigateScreen(context,const BreakReportSummary());
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children:  [
                      Image.asset('assets/menu_report/report_break.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(tr("break"),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: (){
                  NavUtil.navigateScreen(context, const LeaveReportSummeryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children:  [
                      Image.asset('assets/menu_report/report_leave.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(tr('leave'),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
