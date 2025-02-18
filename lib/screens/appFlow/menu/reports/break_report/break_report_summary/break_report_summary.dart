import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_list/break_report_list.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_search/break_report_search.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_summary/break_report_summery_provider.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class BreakReportSummary extends StatelessWidget {
  const BreakReportSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BreakReportSummeryProvider(),
      child: Consumer<BreakReportSummeryProvider>(
        builder: (BuildContext context, provider, _) {
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
                  tr('break_summary'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBarColor),
                ),
              ),
              body: Column(
                children: [
                  currentDate(provider, context),
                  Expanded(
                    child: provider.isLoading
                        ? provider.breakSummeryResponse!.data!.employeeList!
                                .isNotEmpty
                            ? ListView.separated(
                                itemCount: provider.breakSummeryResponse?.data
                                        ?.employeeList?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider.breakSummeryResponse
                                      ?.data?.employeeList?[index];
                                  return ListTile(
                                    onTap: () => NavUtil.navigateScreen(
                                      context,
                                      BreakReportList(
                                        userId: data!.userId!,
                                        date: provider.monthYear!,
                                      ),
                                    ),
                                    leading: ClipOval(
                                      child: Image.network(
                                        '${data?.avatarId}',
                                        fit: BoxFit.cover,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                    title: Text(
                                      data?.name ?? '',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(data?.designation ?? '',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                    trailing: Text(
                                      data?.totalBreakTime ?? '',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider();
                                },
                              )
                            : Center(
                                child: Text(
                                tr("No Data Found"),
                                style: const TextStyle(
                                    color: Color(0x65555555),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ))
                        : const SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Card(
                      elevation: 4,
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          NavUtil.navigateScreen(
                              context, const BreakReportSearch());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 16),
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
                                tr('search_all_break_report'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }

  InkWell currentDate(BreakReportSummeryProvider provider, context) {
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
