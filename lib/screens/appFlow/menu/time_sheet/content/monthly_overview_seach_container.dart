import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/content/timesheet_multiselect_employee_list.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/monthly_overview_provider.dart';
import 'package:hrm_app/utils/res.dart';

class MonthlyOverviewSearchContainer extends StatelessWidget {
  MonthlyOverviewProvider? provider;
  MonthlyOverviewSearchContainer({
    super.key, this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: TextEditingController(text: provider?.selectedMonth),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Select Month",
                labelStyle: TextStyle(color: Colors.black54),
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
              onTap: () {
                provider?.pickMonth(context);
              },
            ),
          ),
          const SizedBox(height: 4),
          TimesheetMultiselectEmployeeList(provider: provider!,),
          const SizedBox(height: 10,),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: TextAlign.center,
              "Search Monthly overview by select Month or multiple employees",
              style: TextStyle(color: AppColors.colorPrimary, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}