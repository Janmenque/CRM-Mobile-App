import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/employee_leave_history/employee_leave_history.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/leave_summery_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/report_leave_list/report_leave_list_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LeaveSummeryScreen extends StatelessWidget {
  const LeaveSummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportLeaveProvider(),
      child: Consumer<ReportLeaveProvider>(builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(tr('leave_summery')),
          ),
          body: Column(
            children: [
              currentDate(provider, context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.separated(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () => NavUtil.navigateScreen(
                          context,
                           ReportLeaveListScreen(
                            title: tr('sick_leave'),
                          ),
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(tr('sick_leave')),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '$index',
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
                child: Padding(
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

  InkWell currentDate(ReportLeaveProvider provider, context) {
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
