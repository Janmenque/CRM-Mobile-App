import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/hourly_statistics_provider.dart';
import 'package:hrm_app/utils/res.dart';

class HourlyStaticsSearchContainer extends StatelessWidget {
  HourlyStatisticsProvider? provider;
  HourlyStaticsSearchContainer({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 12),
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
                child:InkWell(
                  onTap: () => provider?.selectStartDate(context),
                  child:  Container(
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
                          provider?.startDate ?? "Start Date",
                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                        const Icon(Icons.calendar_month_outlined, color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child:InkWell(
                  onTap: () => provider?.selectEndDate(context),
                  child:  Container(
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
                          provider?.endDate ?? "End Date",
                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14,),
          CustomDropdown<TimesheetEmployee>(
            value: provider?.employee,
            labelText: 'Select employee',
            items: provider?.timesheetRelatedResponse?.data?.employees ?? [],
            onChanged: (TimesheetEmployee? newValue) {
              provider?.selectedEmployee(newValue!);
            },
            itemLabelBuilder: (TimesheetEmployee value) => value.name ?? '',
          ),
          const SizedBox(height: 14,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: TextAlign.center,
              "sorted schedule overview by selected information",
              style: TextStyle(color: AppColors.colorPrimary),
            ),
          )
        ],
      ),
    );
  }
}