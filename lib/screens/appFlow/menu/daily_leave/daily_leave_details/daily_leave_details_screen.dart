import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave_details/daily_leave_details_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave_single_view/daily_leave_single_vew_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class DailyLeaveDetailsScreen extends StatelessWidget {
  const DailyLeaveDetailsScreen(
      {Key? key,
      this.title,
      this.leaveStatus,
      this.employeeId,
      this.date,
      this.leaveType,
      required this.onCallBack})
      : super(key: key);
  final String? title;
  final String? leaveStatus;
  final int? employeeId;
  final String? date;
  final String? leaveType;

  final VoidCallback onCallBack;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyLeaveDetailsProvider(
          leaveStatus!, date!, leaveType,
          id: employeeId),
      child: Consumer<DailyLeaveDetailsProvider>(
        builder: (context, provider, _) {
          return WillPopScope(
            onWillPop: () async {
              onCallBack.call();
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('$title'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: provider.isLoading
                        ? provider.detailsResponse!.data!.data!.isNotEmpty
                            ? ListView.builder(
                                itemCount: provider
                                        .detailsResponse?.data?.data?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider
                                      .detailsResponse?.data?.data?[index];
                                  return ExpansionTile(
                                    leading: Image.network(
                                      '${data!.avater}',
                                      height: 42,
                                      width: 42,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.staff!),
                                        Text(
                                          data.leaveType!,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    subtitle: RichText(
                                      text: TextSpan(
                                        text: '${data.designation ?? ' '}\n',
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                                fontWeight: FontWeight.w400),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: data.tlApprovalMsg ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[600])),
                                        ],
                                      ),
                                    ),
                                    // Text('${data.designation} \n${data.tlApprovalMsg}'),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(data.time!),
                                        if (!leaveStatus!
                                                .contains('approved') &&
                                            !leaveStatus!.contains('rejected'))
                                          InkWell(
                                            onTap: () => NavUtil.navigateScreen(
                                              context,
                                              DailyLeaveSingleViewScreen(
                                                leaveId: data.id,
                                                onBack: () async {
                                                  await provider.detailsLeave();
                                                },
                                              ),
                                            ),
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 4),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: Colors.blue),
                                                child: Text(
                                                  tr('view'),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                      ],
                                    ),
                                    children: [
                                      ListTile(
                                        title: RichText(
                                          text: TextSpan(
                                            text: '${tr('reason')}: ',
                                            style: DefaultTextStyle.of(context)
                                                .style
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: data.reason ?? '',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                tr('no_data_found'),
                                style: const TextStyle(
                                    color: Color(0x65555555),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ))
                        : const SizedBox(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
