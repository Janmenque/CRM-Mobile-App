import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave_single_view/daily_leave_single_view_provider.dart';
import 'package:provider/provider.dart';

class DailyLeaveSingleViewScreen extends StatelessWidget {
  const DailyLeaveSingleViewScreen({Key? key, this.leaveId,required this.onBack}) : super(key: key);
  final int? leaveId;

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DailyLeaveSingleViewProvider(leaveId),
      child: Consumer<DailyLeaveSingleViewProvider>(
        builder: (context, provider, _) {
          final data = provider.viewResponse?.data;
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr('pending_early_leave')),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            data?.status ?? '',
                          )),
                      RichText(
                        text: TextSpan(
                          text: '${tr('leave_type')}: ',
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: data?.leaveType ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: '${tr('leave_date')}: ',
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: data?.date ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        tr('Reason'),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(data?.reason ?? ''),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: '${tr('approval_status')}: ',
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                                text: data?.tlApprovalMsg ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${tr('approval_details')} ',
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2),
                        child: Wrap(
                          spacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            Text('${tr('manager_approval')}: ${data?.approvalDetails?.managerApproval ?? 'N/A'}')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 2),
                        child: Wrap(
                          spacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                            Text(
                                '${tr('hr_approval')}: ${data?.approvalDetails?.hrApproval ?? 'N/A'}')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: provider.isHr ?? false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: ()async {
                              await provider.leaveApproval('approved', context);
                              onBack.call();
                            },
                            child: Text(tr('approved'))),
                        ElevatedButton(
                          onPressed: () async{
                            await provider.leaveApproval('rejected', context);
                            onBack.call();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: Text(tr('reject')),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
