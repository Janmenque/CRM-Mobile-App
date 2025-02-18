import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_related_data_model.dart';
import 'package:hrm_app/data/model/timesheet/timesheet_task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/content/custom_dropdown.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_report_provider.dart';
import 'package:hrm_app/utils/res.dart';

class TimesheetReportSearchContainer extends StatelessWidget {
  TimesheetReportProvider? provider;
  TimesheetReportSearchContainer({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
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
          const SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                child:  CustomDropdown<TimesheetProject>(
                  value: provider?.project,
                  labelText: 'Select Project',
                  items: provider?.timesheetRelatedResponse?.data?.projects ?? [],
                  onChanged: (TimesheetProject? newValue) {
                    provider?.selectedProject(newValue!);
                  },
                  itemLabelBuilder: (TimesheetProject value) => value.name ?? '',
                ),
              ),
              Expanded(
                child:  CustomDropdown<TimesheetEmployee>(
                  value: provider?.employee,
                  labelText: 'Select employee',
                  items: provider?.timesheetRelatedResponse?.data?.employees ?? [],
                  onChanged: (TimesheetEmployee? newValue) {
                    provider?.selectedEmployee(newValue!);
                  },
                  itemLabelBuilder: (TimesheetEmployee value) => value.name ?? '',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                child:  CustomDropdown<TimesheetTask>(
                  value: provider?.task,
                  labelText: 'Select task',
                  items: provider?.timesheetTaskListResponse?.data ?? [],
                  onChanged: (TimesheetTask? newValue) {
                    provider?.selectedTask(newValue!);
                  },
                  itemLabelBuilder: (TimesheetTask value) => value.name ?? '',
                ),
              ),
              Expanded(
                child:  CustomDropdown<Client>(
                  value: provider?.client,
                  labelText: 'Select client',
                  items: provider?.crmClientListResponse?.data?.clients ?? [],
                  onChanged: (Client? newValue) {
                    provider?.selectedClient(newValue!);
                  },
                  itemLabelBuilder: (Client value) => value.name ?? '',
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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