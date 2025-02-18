import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_leave_type.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_type/leave_type_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class LeaveType extends StatelessWidget {
  const LeaveType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<LeaveTypeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'request_leave',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.black),
        ).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible:
                  provider.leaveTypeList?.data?.availableLeave?.isNotEmpty ??
                      false,
              child:  Text(
                tr("available_leave_type"),
                style: const TextStyle(
                    color: Color(0xFF364BA8),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            provider.isLoading
                ? provider.leaveTypeList!.data!.availableLeave!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.leaveTypeList?.data
                                  ?.availableLeave?.length ??
                              0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                elevation: 4,
                                child: RadioListTile<AvailableLeave?>(
                                  value: provider.leaveTypeList?.data?.availableLeave?[index],
                                  title: Row(
                                    children: [
                                      Text(provider.leaveTypeList?.data?.availableLeave?[index].type ?? "",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${provider.leaveTypeList?.data?.availableLeave?[index].leftDays} ${tr("days_left")}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ).tr(),
                                    ],
                                  ),
                                  groupValue: provider.selectedLeaveType,
                                  onChanged: (AvailableLeave? value) {
                                    provider.leaveTypeSelected(value!);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    :  Expanded(
                        child: Center(
                            child: Text(
                          tr("no_leave_type_found"),
                          style: const TextStyle(
                              color: Color(0x65555555),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        )),
                      )
                : const SizedBox(),
            Visibility(
              visible:
                  provider.leaveTypeList?.data?.availableLeave?.isNotEmpty ??
                      false,
              child: SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    provider.getLeaveType(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child:  Text(tr("next"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
