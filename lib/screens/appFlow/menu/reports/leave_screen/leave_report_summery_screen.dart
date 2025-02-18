import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/employee_leave_history/employee_leave_history.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/leave_report_summery_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/report_leave_details/report_leave_details_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LeaveReportSummeryScreen extends StatelessWidget {
  const LeaveReportSummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportLeaveSummaryProvider(),
      child:
          Consumer<ReportLeaveSummaryProvider>(builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(tr('leave_summery'), style: const TextStyle(color: AppColors.black),),
          ),
          body: Column(
            children: [
              currentDate(provider, context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.separated(
                    itemCount:
                        provider.summeryResponse?.data?.leaveTypes?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          provider.summeryResponse?.data?.leaveTypes?[index];
                      return ListTile(
                        onTap: () => NavUtil.navigateScreen(
                          context,
                          ReportLeaveListScreen(title: data?.name ?? '', date: provider.monthYear, leaveId: data?.id,),
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          data?.name ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '${data?.count}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 1.3,
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                onPressed: () => NavUtil.navigateScreen(
                    context, const EmployeeLeaveHistory()),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16),
                  child: Text(tr('search_all')),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        );
      }),
    );
  }

  InkWell currentDate(ReportLeaveSummaryProvider provider, context) {
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
