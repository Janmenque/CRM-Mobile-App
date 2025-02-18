import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_overview_provider.dart';
import '../../../../../utils/res.dart';

class TimesheetOverviewSearchContainer extends StatelessWidget {
  TimeSheetOverviewProvider? provider;
  TimesheetOverviewSearchContainer({
    super.key, this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => provider?.selectDateForSearch(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          provider?.dateForSearchTimeSheet ?? "Select Date",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child:  CustomDropdown<TimesheetEmployee>(
                  value: provider?.employeeForSearch,
                  labelText: 'Select employee',
                  items: provider?.timesheetRelatedResponse?.data?.employees ?? [],
                  onChanged: (TimesheetEmployee? newValue) {
                    provider?.selectedEmployeeForSearch(newValue!);
                  },
                  itemLabelBuilder: (TimesheetEmployee value) => value.name ?? '',
                ),),
            ],
          ),
          const SizedBox(height: 10,),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: TextAlign.center,
              "Search Schedule overview by select date or employee",
              style: TextStyle(color: AppColors.colorPrimary, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}