import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/break_report/break_report_list/break_report_list_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class BreakReportList extends StatelessWidget {
  const BreakReportList({Key? key, required this.userId, required this.date})
      : super(key: key);
  final int userId;
  final String date;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BreakReportListProvider(userId, date),
      child: Consumer<BreakReportListProvider>(
        builder: (context, provider, _) {
          ///scroll functionality
          provider.scrollListener(isLoading: provider.isLoading);
          return Scaffold(
            appBar: AppBar(
              title: Text(tr('break_time_report')),
            ),
            body: Column(
              children: [
                Container(
                  color: const Color(0xff6AB026),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${tr('total_break_time')}:",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16, color: Colors.white),
                      ),
                      // ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        provider.responseBreakReport?.data?.totalBreakTime ??
                            "00:00:00",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "digitalNumber"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                provider.isLoading == true
                    ? provider.responseBreakReport!.data!.breakHistory!
                            .todayHistory!.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                              controller: provider.scrollController,
                              shrinkWrap: true,
                              itemCount: provider.todayBreakList?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        provider
                                                .responseBreakReport
                                                ?.data
                                                ?.breakHistory
                                                ?.todayHistory?[index]
                                                .breakTimeDuration ??
                                            "",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 3,
                                      color: AppColors.colorPrimary,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider
                                                  .responseBreakReport
                                                  ?.data
                                                  ?.breakHistory
                                                  ?.todayHistory?[index]
                                                  .reason ??
                                              "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(provider
                                                .responseBreakReport
                                                ?.data
                                                ?.breakHistory
                                                ?.todayHistory?[index]
                                                .breakBackTime ??
                                            ""),
                                      ],
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tr("nothing_found"),
                                  style: const TextStyle(
                                      color: Color(0x65555555),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ) : SizedBox(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
