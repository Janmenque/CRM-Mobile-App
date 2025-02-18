import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/reports/leave_screen/report_leave_details/report_leave_details_provider.dart';

import 'package:provider/provider.dart';

class ReportLeaveListScreen extends StatelessWidget {
  const ReportLeaveListScreen(
      {Key? key, required this.title, this.date, this.leaveId})
      : super(key: key);
  final String title;
  final String? date;
  final int? leaveId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportLeaveDetailsProvider(date, leaveId),
      child: Consumer<ReportLeaveDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Column(
              children: [
                Expanded(
                  child: provider.isLoading
                      ? provider.reportDetailsResponse!.data!.leaves!.isNotEmpty
                          ? ListView.separated(
                              itemCount: provider.reportDetailsResponse?.data
                                      ?.leaves?.length ??
                                  0,
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider.reportDetailsResponse
                                    ?.data?.leaves?[index];
                                return ExpansionTile(
                                  title: Text(data?.userName ?? '',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  leading: Image.network(
                                    '${data?.avatar}',
                                    height: 40,
                                    width: 40,
                                  ),
                                  subtitle: Text(data?.userDesignation ?? ''),
                                  trailing: Text('${data?.days ?? ''} days'),
                                  children: [
                                    ListTile(
                                        title: Text(
                                            '${tr('reason')}: ${data?.reason ?? ' '}'))
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1.2,
                                );
                              },
                            )
                          :  Center(
                              child: Text(
                              tr("no_data_found"),
                              style: const TextStyle(
                                  color: Color(0x65555555),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ))
                      : const SizedBox(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
