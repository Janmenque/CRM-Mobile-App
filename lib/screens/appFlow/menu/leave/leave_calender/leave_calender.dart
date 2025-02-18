import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'leave_calender_provider.dart';

class LeaveCalender extends StatelessWidget {
  final int? leaveTypeId;

  const LeaveCalender({super.key, this.leaveTypeId});

  @override
  Widget build(BuildContext context) {
    LeaveCalenderProvider provider = context.watch<LeaveCalenderProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("request_leave"),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionColor: Colors.green,
            showNavigationArrow: true,
            toggleDaySelection: false,
            enablePastDates: false,
            selectionShape: DateRangePickerSelectionShape.rectangle,
            onSelectionChanged: provider.onSelectionChanged,
            monthViewSettings: const DateRangePickerMonthViewSettings(
                weekendDays: <int>[6, 3]),
            selectionMode: DateRangePickerSelectionMode.range,
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                provider.getDateFromCalender(context, leaveTypeId);
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
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
